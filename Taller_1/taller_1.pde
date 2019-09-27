// TO DO:
// Conversión a escala de grises: promedio rgb y luma.  CHECK
// Aplicación de algunas máscaras de convolución.
// (solo para imágenes) Despliegue del histograma.  
// (solo para imágenes) Segmentación de la imagen a partir del histograma.
// (solo para video) Medición de la eficiencia computacional para las operaciones realizadas. (framerate)


PGraphics pg;
PGraphics pg_hist;
PImage img;
PImage img_gray;
PImage img_luma;
int[] hist = new int[256];

float[][] identity = {
  { 0, 0, 0}, 
  { 0, 1, 0}, 
  { 0, 0, 0}
};

float[][] edgeDetection = {
  { -1, -1, -1}, 
  { -1, 8, -1}, 
  { -1, -1, -1}
};

float[][] sharpen = {
  { 0, -1, 0}, 
  { -1, 5, -1}, 
  { 0, -1, 0}
};

void setup() {
  background(0);
  createCanvas();
  img = loadImage("prueba.jpg");
  int h = img.height;
  int w = img.width;
  // size(322, 484);
  size(600, 500);
  //image(img, 0, 0);
  //surface.setSize(w, h);
}

void draw() {

  image(img, 0, 50, 300, 300);
  pg.beginDraw();
  // aqui va el codigo
  img_gray = toGrayscale(img, 1);
  // img_luma = toGrayscale(img, 1);
  // img_luma = makeConvolution(img, identity);
  pg.image(img_gray, 0, 0, 300, 300);
  pg.endDraw();
  image(pg, width/2, 50);  // se despliega el canvas 1
  
  pg_hist.beginDraw();
  // pg_hist.background(102);
  drawHist(img_gray);
  pg_hist.endDraw();
  image(pg_hist, width/2, height-150);
}

void createCanvas() {
  pg = createGraphics(300, 300); // canvas
  pg_hist = createGraphics(300, 100); // histogram
}

PImage toGrayscale(PImage img, int method) {
  PImage img_result = createImage(img.width, img.height, RGB);
  //image(img, width/2, 0, 300, 300); // Displays the image from point (0,0)
  img.loadPixels();
  img_result.loadPixels();
  for (int x = 0; x < img.width; x++) {
    // Loop through every pixel row
    for (int y = 0; y < img.height; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * img.width;

      int bright = int(brightness(img.get(x, y)));
      hist[bright]++; 

      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);

      float gray;
      if (method == 0) {
        gray = (r + g + b) / 3;
      } else {
        gray = 0.2126*r + 0.7152*g + 0.0722*b;
      }
      // Set the display pixel to the image pixel
      img_result.pixels[loc] =  color(gray, gray, gray);
    }

    img_result.updatePixels();
  }

  return img_result;
}

void drawHist(PImage img) {
  // Find the largest value in the histogram
  int histMax = max(hist);

  stroke(255);
  // Draw half of the histogram (skip every second value)
  for (int i = 0; i < img.width; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, img.width, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, img.height, 0));
    line(i, img.height, i, y);
  }
}

PImage makeConvolution(PImage img, float[][] kernel) {
  // https://processing.org/examples/convolution.html
  PImage img_result = createImage(img.width, img.height, RGB);
  img.loadPixels();

  // Loop through every pixel in the image.
  for (int y = 1; y < img.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) { // Skip left and right edges
      float sum = 0; // Kernel sum for this pixel
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }

      // based on the sum from the kernel
      img_result.pixels[y*img.width + x] = color(sum, sum, sum);
    }
  }


  return img_result;
}
