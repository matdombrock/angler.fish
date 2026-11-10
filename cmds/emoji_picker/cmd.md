# emoji_picker

Pick and print an emoji from a giant list

! fzf

`echo (string split " " (cat $ANG/emoji_picker/emojis.md | fzf))[1]`

