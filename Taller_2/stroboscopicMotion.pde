PGraphics pg;
boolean firstPair = false;

void setup() {
  size(600, 600);
  pg = createGraphics(600, 600);
}

void draw() {

  frameRate(2);
  stroboscopicMotion();
  image(pg, 0, 0);
}

void stroboscopicMotion() {
  pg.beginDraw();
  pg.background(192, 192, 192);
  pg.strokeWeight(100);
  pg.stroke(0, 0, 255);
  if (firstPair) {
    pg.point(150, 150);
    pg.point(450, 450);
  } else {
    pg.point(450, 150);
    pg.point(150, 450);
  }
  pg.endDraw();

  firstPair = !firstPair;
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