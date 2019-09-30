import processing.video.*;
Movie video;

int mode = 0;
int grayHist = -1;

PGraphics pg1;
PGraphics pg2;
PGraphics pg3;
PGraphics pg4;
PGraphics pgT; // texto

PFont myFont;

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

float[][] emboss = {
  { -2, -1, 0}, 
  { -1, 1, 1}, 
  { 0, 1, 2}
};

void setup() {
  background(0);
  myFont = createFont("Verdana", 50);
  createCanvas();
  img = loadImage("imagen300.jpg");

  size(600, 650);
  //surface.setSize(w, h);
  noLoop();
}

void draw() {
  if (mode == 0) {
    println("Menu");
    menu();
  } else if (mode == 1) {
    println("Grayscale mode");
    grayscaleMode();
  } else if (mode == 2) {
    println("Convolution mode");
    convolutionMode();
  } else if (mode == 3) {
    println("Video mode");
    videoMode();
  }
}

void createCanvas() {
  pg1 = createGraphics(300, 300); // canvas original
  pg2 = createGraphics(300, 300);
  pg3 = createGraphics(300, 300);
  pg4 = createGraphics(300, 300);
  pgT = createGraphics(width, height/3, JAVA2D);
}

void textCavas(String t1, String t2, String t3, String t4) {
  textAlign(CENTER);
  textSize(16);
  text(t1, width/4, height/2 - 10);
  text(t2, width - width/4, height/2  - 10);
  text(t3, width/4, height - 10);
  text(t4, width - width/4, height - 10);
}

void menu() {
  background(0); // "limpia"

  fill(255); // white
  textSize(36);
  textAlign(CENTER, CENTER);
  text("TALLER 1", width/2, height/8);

  stroke(220, 120);
  line(width/8, height/8 + 40, width - width/8, height/8 + 40);

  textSize(32);
  text("Opciones", width/2, height/4);
  textSize(26);
  textAlign(CENTER, CENTER);
  String options = "G: Escala de grises\nC: Convoluciones\nV: Video\nM: Menu";
  text(options, width/2, height/4 + 100);

  textSize(32);
  text("Integrantes", width/2, height/2 + 90);
  textSize(26);
  textAlign(CENTER, CENTER);
  String members = "Juan Sebastian Peña\nJuan Sebastian Becerra";
  text(members, width/2, height/2 + 160);
}

void grayscaleMode() {
  background(0);
  textSize(32);
  textAlign(LEFT);
  text("Histograma", width/12, height/2 + 60);
  textSize(26);
  String options = "A: Promedio RGB\nL: Luma";
  text(options, width/12, height/2 + 100);

  // img = loadImage("prueba300.jpg");

  pg1.beginDraw();
  pg1.image(img, 0, 0, 300, 300);
  pg1.endDraw();
  image(pg1, 0, 0);

  img_gray = toGrayscale(img, 0);
  img_luma = toGrayscale(img, 1);

  pg2.beginDraw();
  pg2.image(img_gray, 0, 0, 300, 300);
  pg2.endDraw();
  image(pg2, width/2, 0);  // se despliega el canvas para avg

  pg4.beginDraw();
  pg4.image(img_luma, 0, 0, 300, 300);
  pg4.endDraw();
  image(pg2, width/2, height/2);  // se despliega el canvas para luma

  textCavas("Original", "Promedio", "", "Luma");

  if (grayHist == 0) {
    drawHist(img_gray);
  } else if (grayHist == 1) {
    drawHist(img_luma);
  }
}

void convolutionMode() {
  background(0);
  // img = loadImage("prueba300.jpg");

  pg1.beginDraw();
  pg1.image(img, 0, 0, 300, 300);
  pg1.endDraw();
  image(pg1, 0, 0);

  // Edge Detection

  pg2.beginDraw();
  pg2.image(img, 0, 0);

  pg2.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      color c = convolution(x, y, edgeDetection, img);
      int loc = x + y * img.width;
      pg2.pixels[loc] = c;
    }
  }
  pg2.updatePixels();

  image(pg2, width/2, 0);  // se despliega el canvas
  pg2.endDraw();

  // Sharpen

  pg3.beginDraw();
  pg3.image(img, 0, 0);

  pg3.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      color c = convolution(x, y, sharpen, img);
      int loc = x + y * img.width;
      pg3.pixels[loc] = c;
    }
  }
  pg3.updatePixels();

  image(pg3, 0, height/2);  // se despliega el canvas
  pg3.endDraw();

  // Emboss

  pg4.beginDraw();
  pg4.image(img, 0, 0);

  pg4.loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      color c = convolution(x, y, emboss, img);
      int loc = x + y * img.width;
      pg4.pixels[loc] = c;
    }
  }
  pg4.updatePixels();

  image(pg4, width/2, height/2);  // se despliega el canvas
  pg4.endDraw();

  textCavas("Original", "Edge Detection", "Sharpen", "Emboss");
}

void videoMode() {
  background(0);

  image(video, 0, 0, 600, 400);
  float md = video.duration();
  float mt = video.time();
  if (md - mt <= 0) {
    noLoop();
  }

  pgT.beginDraw();
  //pg.smooth();
  pgT.background(0);
  pgT.fill(255);
  pgT.textAlign(CENTER, CENTER);
  pgT.textFont(myFont, 36);
  pgT.text(int(frameRate) + " fps", pgT.width/2, pgT.height/2);
  pgT.endDraw();
  image(pgT, 0, height - pgT.height);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

PImage toGrayscale(PImage img, int method) {
  PImage img_result = createImage(img.width, img.height, RGB);
  img.loadPixels();
  img_result.loadPixels();
  for (int x = 0; x < img.width; x++) {
    // Loop through every pixel row
    for (int y = 0; y < img.height; y++) {
      // Use the formula to find the 1D location
      int loc = x + y * img.width;

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
  hist = new int[256];
  // Calculate the histogram
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {

      int c = img.get(i, j);
      int bright = int(brightness(c));
      hist[bright]++;
    }
  }

  // Find the largest value in the histogram
  int histMax = max(hist);
  println("histMax: " + histMax);

  println("img.width: " + img.width);
  println("img.height: " + img.height);

  stroke(255);
  // Draw half of the histogram (skip every second value)
  // int imgWidth = img.width;
  int imgWidth = 300;
  for (int i = 0; i < imgWidth; i += 2) {
    // Map i (from 0..img.width) to a location in the histogram (0..255)
    int which = int(map(i, 0, imgWidth, 0, 255));
    // Convert the histogram value to a location between 
    // the bottom and the top of the picture
    int y = int(map(hist[which], 0, histMax, img.height, 0));
    line(i, img.height, i, y);
  }
}

color convolution(int x, int y, float[][] kernel, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int matrixsize = kernel.length;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++) {
    for (int j = 0; j < matrixsize; j++) {
      // What pixel are we testing
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + yloc * img.width;

      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc, 0, img.pixels.length-1);

      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * kernel[i][j]);
      gtotal += (green(img.pixels[loc]) * kernel[i][j]);
      btotal += (blue(img.pixels[loc]) * kernel[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}


void keyPressed() {
  if (mode == 1 && (key == 'a' || key == 'A')) {
    grayHist = 0;
    redraw();
  } else if (mode == 1 && (key == 'l' || key == 'L')) {
    grayHist = 1;
    redraw();
  }
  if (key == 'm' || key == 'M') {
    mode = 0; // menu
    redraw();  // or loop()
  } else if (key == 'g' || key == 'G') {
    mode = 1; // grayscaleMode
    redraw();
  } else if (key == 'c' || key == 'C') {
    mode = 2; // convolutionMode
    redraw();
  } else if (key == 'v' || key == 'V') {
    video = new Movie(this, "video.mp4");
    video.play();
    mode = 3; // videoMode
    loop();
  }
}
