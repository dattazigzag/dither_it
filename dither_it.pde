import milchreis.imageprocessing.*;

PImage img;
boolean imageLoaded = false;
String message = "Please Press L to load an image";

int ditherIdx = 0;

void setup() {
  size(400, 400);  // Initial size, will be adjusted
  surface.setResizable(true);
  textAlign(CENTER, CENTER);
  textSize(16);
  background(0);
}

void draw() {
  background(0);

  if (imageLoaded && img != null) {
    PImage processed = img;

    if (ditherIdx == 0) {
      processed = Dithering.apply(processed, Dithering.Algorithm.BAYER_2x2);
      //label = "BAYER_2x2";
    }
    if (ditherIdx == 1) {
      processed = Dithering.apply(processed, Dithering.Algorithm.BAYER_4x4);
      //label = "BAYER_4x4";
    }
    if (ditherIdx == 2) {
      processed = Dithering.apply(processed, Dithering.Algorithm.BAYER_8x8);
      //label = "BAYER_8x8";
    }

    //processed = Dithering.apply(processed, Dithering.BAYER_8x8);
    image(processed, 0, 0, width, height);

    textAlign(CENTER, CENTER);
    textSize(16);
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(width/2, height-60, 400, 70);
    fill(255);
    textSize(12);
    text("Press L to a New Image\nUse the left or right arrow keys to swap between 3 different dither effects.\nPress S to save the current Dithered image.\nPress ESC to close the window.", width/2, height-60);
  } else {
    fill(255);
    textSize(16);
    text(message, width/2, height/2);
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      ditherIdx= ditherIdx+1;
    }
    if (keyCode == LEFT) {
      ditherIdx= ditherIdx-1;
    }
    if (ditherIdx < 1) {
      ditherIdx = 3;
    }
    if (ditherIdx > 2) {
      ditherIdx = 0;
    }
  }

  if (key == 'l' || key == 'L') {
    selectInput("Select an image file:", "fileSelected");
  }

  if (key == 'S' || key == 's') {
    saveFrame("dither.png");
  }
}


void fileSelected(File selection) {
  if (selection != null) {
    try {
      img = loadImage(selection.getAbsolutePath());
      if (img != null && img.width > 0) {
        imageLoaded = true;

        // Calculate display constraints
        float display_width = displayWidth * 0.9;
        float display_height = displayHeight * 0.9;
        // Calculate scaling factor
        float scaleW = display_width / img.width;
        float scaleH = display_height / img.height;
        float scale = min(scaleW, scaleH);
        // Resize window
        surface.setSize(int(img.width * scale), int(img.height * scale));
      } else {
        message = "Invalid image format. Press L to try again.";
        imageLoaded = false;
      }
    }
    catch (Exception e) {
      message = "Error loading image. Press L to try again.";
      imageLoaded = false;
    }
  }
}
