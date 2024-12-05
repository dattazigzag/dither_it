# Image Dithering Processor

A Processing sketch that applies dithering effects to images using the `imageprocessing` library by Milchreis.

## Features

- Load any image via file selector
- Apply three different Bayer dithering patterns (2x2, 4x4, 8x8)
- Auto-resize window to fit image while maintaining aspect ratio
- Save processed images without UI elements
- Simple keyboard controls

## Dependencies

- Processing 4+
- [Milchreis Image Processing Library](https://github.com/Milchreis/processing-imageprocessing)

## Installation

1. Install Processing from [processing.org](https://processing.org)
2. Install the Image Processing Library:
   - Open Processing
   - Go to `Sketch > Import Library > Add Library`
   - Search for "Image Processing"
   - Install the library by Milchreis

## Usage

### Controls

- `L`: Load a new image
- `←/→`: Switch between dithering effects
- `S`: Save current dithered image
- `ESC`: Close application

### Output

Saved images will be named `dither-PATTERN.png` where PATTERN indicates the dithering algorithm used (BAYER_2x2, BAYER_4x4, or BAYER_8x8).

## License

MIT License - feel free to use and modify for your own projects.