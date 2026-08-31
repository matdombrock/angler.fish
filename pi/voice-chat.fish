#!/usr/bin/env fish

# model
# set model openrouter/openrouter/free
set model openrouter/nvidia/nemotron-3.5-lightning
# Session ID
# set sid (date +%s) #test1
set sid test1
#
set prompt_sys "
# IMPORTANT
This is a voice chat, 
Your answers will be spoken via TTS.
Keep your answers short and simple.

DO NOT USE symbols and markdown that can't be easily spoken.
NO MARKDOWN. NO EMOJIS.
NO ASTERISKS or BOLD/ITALIC markers.
Use plain text only.
Use periods at the end of sentences.
Use commas for pauses.
Avoid bullet points and numbered lists.
Keep paragraphs short - one or two sentences max.
"
# piper setup
set piper_voice lessac # or: amy
set piper_weight high # or: medium
set piper_vw $piper_voice-$piper_weight
set piper_vdir ~/.piper-voices
#
set chat_dir ~/Lab/pichat/

function listen
    ffmpeg -loglevel quiet -f alsa -i default -y /tmp/vc.wav &
    set FPID $last_pid
    echo "Recording... press any key to stop, or q to quit" >&2
    read -n 1 -s -P "" key
    kill $FPID
    wait $FPID 2>/dev/null; or true
    if test "$key" = q
        echo "Quitting." >&2
        exit 0
    end
    whisper-cli \
        -f /tmp/vc.wav \
        -l en \
        --no-prints \
        --output-txt \
        --output-file /tmp/vc \
        -m /usr/share/whisper.cpp-model-base.en/ggml-base.en.bin >/dev/null 2>/dev/null
    echo /tmp/vc.txt
end

# thinking is required for some models
function pichat
    pi \
        --model $model \
        --session-id $sid \
        --thinking low \
        --append-system-prompt "$prompt_sys" \
        -p "$argv"
end

function tout
    # echo -e "\n\n\n\n"
    echo -------
    echo "agent:"
    echo -------
    echo $argv
    # echo -e "\n\n\n\n"
end

function tts
    echo $argv | piper-tts \
        --quiet \
        -m $piper_vdir/en_US-$piper_vw.onnx \
        --output_raw - \
        | ffplay \
        -loglevel quiet \
        -nodisp \
        -autoexit \
        -f s16le \
        -ar 22050 \
        -ch_layout mono \
        -volume 80 -i -
end

function once
    set prompt (cat (listen))
    cd $chat_dir
    echo $prompt
    set res (pichat $prompt)
    tout $res
    tts $res
end

if test "$argv[1]" = --loop
    echo LOOP MODE
    while true
        once
    end
else
    once
end
