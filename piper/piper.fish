#!/usr/bin/env fish

set piper_voice lessac # or: amy
set piper_weight high # or: medium
set piper_vw $piper_voice-$piper_weight

set piper_vdir ~/.piper-voices

function piper-setup
  set base https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/$piper_voice/$piper_weight/en_US-$piper_vw
  mkdir -p $piper_vdir
  cd $piper_vdir
  echo "Downloading onnx..."
  wget $base.onnx
  echo "Downloading json..."
  wget $base.onnx.json
  echo "piper voices downloaded, ensure it is also installed on this system"
  ls $piper_vdir
end

function piper-echo
  echo $argv[1] | piper-tts --quiet -m $piper_vdir/en_US-$piper_vw.onnx --output_raw - | aplay --quiet -r 22050 -f S16_LE -c 1
end

function piper-echo-cat
  piper-echo (cat $argv[1] | string join "    ")
end

function piper-write
  echo $argv[1] | piper-tts --quiet -m $piper_vdir/en_US-$piper_vw.onnx -f $argv[2] && aplay --quiet $argv[2]
end

function piper-write-cat
  piper-write (cat $argv[1] | string join "   ") $argv[2]
end

set cmd $argv[1]

if test "$cmd" = "echo"
  piper-echo $argv[2]
else if test "$cmd" = "cat"
  piper-echo-cat $argv[2]
else if test "$cmd" = "echow"
  piper-write $argv[2] $argv[3]
else if test "$cmd" = "catw"
  piper-write-cat $argv[2] $argv[3]
else if test "$cmd" = "setup"
  piper-setup
else if test "$cmd" = "-h"
  echo "help: <echo|cat|echow|catw|setup>"
end
