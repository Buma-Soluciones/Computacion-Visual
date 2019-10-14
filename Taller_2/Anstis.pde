PGraphics pg;

int rx = 100;
float rspeed = 1.00;

void setup() {
  size(650, 400);
  pg = createGraphics(650, 400);
}

void draw() {


  pg.beginDraw();
  pg.background(255);
  if (!mousePressed) {
    makeBars();
  }
  moveRect();
  pg.endDraw();

  image(pg, 0, 0);
}

void moveRect() {
  pg.noStroke();
  pg.fill(255, 255, 0);
  pg.rect( rx, 120, 60, 30 );
  pg.fill(0, 0, 102);
  pg.rect( rx, 220, 60, 30 );
  rx += rspeed;
  if ( rx+60 >= 650 || rx <= 10 ) {
    rspeed *= (-1.0);
  }
}

void makeBars() {
  pg.strokeCap(SQUARE);
  pg.strokeWeight(15);
  pg.stroke(0);
  for (int i = 0; i < 22; i++) 
    pg.line(10+i*30, 495-100, 10+i*30, 5);
}
