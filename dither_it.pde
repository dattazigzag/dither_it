import milchreis.imageprocessing.*;

// Image processing variables
PImage img;
PImage processedImage;
boolean imageLoaded = false;
String message = "Please Press L to load an image";
int ditherIdx = 0;

// UI Constants
final int BANNER_HEIGHT = 70;
final float DISPLAY_SCALE = 0.9;
final String[] DITHER_TYPES = {"BAYER_2x2", "BAYER_4x4", "BAYER_8x8"};

void setup() {
  size(400, 400);
  surface.setResizable(false);  // Prevent manual resizing
  initializeUI();
}

void initializeUI() {
  textAlign(CENTER, CENTER);
  textSize(16);
  background(0);
}

void draw() {
  background(0);
  if (imageLoaded && img != null) {
    drawProcessedImage();
    drawInstructionBanner();
  } else {
    drawLoadPrompt();
  }
}

void drawProcessedImage() {
  // Apply dithering effect
  processedImage = applyDithering(img.copy());
  image(processedImage, 0, 0, width, height);
}

PImage applyDithering(PImage source) {
  switch(ditherIdx) {
    case 0: return Dithering.apply(source, Dithering.Algorithm.BAYER_2x2);
    case 1: return Dithering.apply(source, Dithering.Algorithm.BAYER_4x4);
    case 2: return Dithering.apply(source, Dithering.Algorithm.BAYER_8x8);
    default: return source;
  }
}

void drawInstructionBanner() {
  rectMode(CENTER);
  noStroke();
  fill(0);
  rect(width/2, height-BANNER_HEIGHT/2, width, BANNER_HEIGHT);
  
  fill(255);
  textSize(12);
  text("Press L to a New Image\n" +
       "Use the left or right arrow keys to swap between 3 different dither effects.\n" +
       "Press S to save the current Dithered image.\n" +
       "Press ESC to close the window.", 
       width/2, height-BANNER_HEIGHT/2);
}

void drawLoadPrompt() {
  fill(255);
  textSize(16);
  text(message, width/2, height/2);
}

void keyPressed() {
  handleDitherNavigation();
  handleImageOperations();
}

void handleDitherNavigation() {
  if (key == CODED) {
    if (keyCode == RIGHT) ditherIdx = (ditherIdx + 1) % 3;
    if (keyCode == LEFT) ditherIdx = (ditherIdx + 2) % 3;
  }
}

void handleImageOperations() {
  if (key == 'l' || key == 'L') {
    selectInput("Select an image file:", "fileSelected");
  }
  if ((key == 'S' || key == 's') && imageLoaded) {
    // Save only the processed image without UI elements
    processedImage.save("dither-" + DITHER_TYPES[ditherIdx] + ".png");
  }
}

void fileSelected(File selection) {
  if (selection == null) return;
  
  try {
    img = loadImage(selection.getAbsolutePath());
    if (img != null && img.width > 0) {
      imageLoaded = true;
      resizeWindowToImage();
    } else {
      throw new Exception("Invalid image format");
    }
  } catch (Exception e) {
    message = "Error loading image. Press L to try again.";
    imageLoaded = false;
  }
}

void resizeWindowToImage() {
  float scaleW = (displayWidth * DISPLAY_SCALE) / img.width;
  float scaleH = (displayHeight * DISPLAY_SCALE) / img.height;
  float scale = min(scaleW, scaleH);
  surface.setSize(int(img.width * scale), int(img.height * scale));
}
