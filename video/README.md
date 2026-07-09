# Convert Video

An `ffmpeg` wrapper to handle simple video conversion

## Usage

```bash
./convert-video.sh input.mkv output.mp4 33
```

Params:
- input path
- output path
- cfr (optional, defaults to 28)

Converted files are written to `~/Videos/convert`

# PNG2Video

png2video.fish - Convert a directory of PNGs to an MP4 video

## Usage
```bash
./pngs_to_video.fish [options] [directory]
```

Options:
```
  -o, --output FILE     Output video file (default: output.mp4)
  -f, --fps FPS         Frames per second (default: 24)
  -s, --sort ORDER      Sort order: name, numeric, time (default: name)
  -r, --reverse         Reverse sort order
  -h, --help            Show this help
```
