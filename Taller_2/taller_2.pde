int mode = 0;

PGraphics pg;
PFont myFont;

void setup() {
  background(0);
  myFont = createFont("Verdana", 50);
  size(600, 600);
  //noLoop();
}

void draw() {
  switch(mode) {
  case 0:
    menu();
    break;
  case 1:
    poggendorff();
    break;  
  case 2:
    triangulo();
    break;
  case 3:
    anstis();
    break;
  case 4:
    stroboscopicMotion();
    break;
  case 5:
    cafeWall();
    break;
  case 6:
    break;
  default:
    background(0);
  }
}

void menu() {
  background(0); // "limpia"

  fill(255); // white
  textSize(36);
  textAlign(CENTER, CENTER);
  text("TALLER 2", width/2, height/8);

  stroke(220, 120);
  line(width/8, height/8 + 40, width - width/8, height/8 + 40);

  textSize(32);
  text("Illusions", width/2, height/4 - 10);
  textSize(24);
  textAlign(CENTER, CENTER);
  String options = "1: Poggendorff Ilussion\n2: PenRose Triangle\n3: Stuart Anstis ilussion\n4: Stroboscopic Motion\n5: Cafe Wall\n6: Necker Cube\n0: Menu";
  text(options, width/2, height/4 + 140);

  textSize(32);
  text("Members", width/2, height/2 + 160);
  textSize(26);
  textAlign(CENTER, CENTER);
  String members = "Juan Sebastian Peña\nJuan Sebastian Becerra";
  text(members, width/2, height/2 + 220);
}


/*
Codigo basado en el codigo de Victor Ramirez
 https://github.com/VisualComputing/Cognitive/blob/gh-pages/sketches/poggendorff.js
 */

//declaracion de los colores del triangulo
color yellow = color(253, 255, 0);
color red = color(255, 0, 0);
color blue = color(0, 0, 255);
color aux;

void poggendorff() {
  background(255);
  pg.beginDraw();
  float LineWidth = 50.0;
  pg.strokeWeight(3);
  float x1 =  (pg.width - LineWidth) / 2.0;
  float x2 =  (pg.width + LineWidth) / 2.0;
  float y1 =  20.0;
  float y2 =  pg.height - y1;
  float d = 100.0;
  float z = 25.0;
  pg.stroke(red);
  pg.line( x1-d, y1, (x1+x2)/2.0, (y1+y2)/2.0 );
  pg.stroke(yellow);
  pg.line( x2+d, y2, (x1+x2)/2.0, (y1+y2)/2.0 );
  pg.stroke(blue);
  pg.line( z*(x1 - 2*d - x2)/(y1-y2) + d + x2, y2, (x1+x2)/2.0, (y1+y2)/2.0-z );
  if ( !mousePressed ) {
    pg.noStroke();
    pg.fill(90);
    pg.rect( x1, y1, x2-x1, y2-y1);
  }

  pg.endDraw();
  image(pg, 0, 50);
}


/*
Codigo basado en el codigo de Edwin Alexander Bohorquez Gamba
 https://github.com/VisualComputing/Cognitive/blob/gh-pages/sketches/PenroseTriangle.js
 */

void triangulo() {
  background(255);
  pg.beginDraw();
  pg.strokeWeight(3);                
  //Figura amarilla
  pg.beginShape();        
  pg.fill(yellow);        
  pg.vertex(270, 25);
  pg.vertex(108, 316);
  pg.vertex(137, 368);
  pg.vertex(271, 129);
  pg.vertex(346, 264);
  pg.vertex(405, 264);
  pg.vertex(270, 25);                
  pg.endShape();

  //Figura roja
  pg.beginShape();
  pg.fill(red);
  pg.vertex(270, 25);
  pg.vertex(329, 25);
  pg.vertex(491, 316);
  pg.vertex(228, 316);
  pg.vertex(257, 264);
  pg.vertex(405, 264);
  pg.vertex(270, 25);
  pg.endShape();

  //Figura azul
  pg.beginShape();
  pg.fill(blue);
  pg.vertex(300, 182);
  pg.vertex(228, 316); 
  pg.vertex(491, 316);
  pg.vertex(467, 368);
  pg.vertex(137, 368);             
  pg.vertex(271, 129);
  pg.vertex(300, 182);
  pg.endShape();

  pg.endDraw();
  image(pg, 0, 50);
}

void anstis() {
  background(255);
  pg.beginDraw();
  pg.background(255);
  if (!mousePressed) {
    makeBars();
  }
  moveRect();
  pg.endDraw();

  image(pg, 0, 50);
}

int rx = 100;
float rspeed = 1.00;

void moveRect() {
  pg.noStroke();
  pg.fill(255, 255, 0);
  pg.rect( rx, 120, 60, 30 );
  pg.fill(0, 0, 102);
  pg.rect( rx, 220, 60, 30 );
  rx += rspeed;
  if ( rx+60 >= pg.width || rx <=010 ) {
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


boolean firstPair = false;

void stroboscopicMotion() {
  frameRate(2);
  background(255);
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
  image(pg, 0, 0);
  firstPair = !firstPair;
}

int cWidth = 30; // cell width
int cHeight = 26; // cell height
int linexHeight = 1; // stroke width for horizontal
int lineyHeight = 2; // stroke width for vertical lines
int rows = 15; // number of rows to draw
int canvasWidth = 600; // canvas width

void cafeWall() {
  background(136, 136, 136);
  pg.beginDraw();
  mouseMoved();
  pg.endDraw();
  image(pg, 0, 50);
}

void drawRow(int row) {
  int yPos = row * (cHeight + lineyHeight) + lineyHeight;
  int numCells = ceil(canvasWidth / cWidth) + 3;
  for (int i = -80; i < numCells; i = i + 1) {
    if (i % 2 == 0) {
      pg.fill(0);
    } else {
      pg.fill(255);
    }
    pg.noStroke();
    int pos = row % 4;
    if (pos == 3) pos = 1;
    pg.rect(
      i * (cWidth + linexHeight) - pos * mouseX / 15 % (2 * cWidth) + 15, 
      yPos, 
      cWidth, 
      cHeight
      );
  }
}

void mouseMoved() {
  if (mode == 5) {
    pg.background(136, 136, 136);
    for (int i = 0; i < rows; i = i + 1) {
      drawRow(i);
    }
  }
}

void mouseClicked() {
  // cada vez que se da click los colores se van rotando para generar la ilusion
  if (mode == 2) {
    aux = yellow;
    yellow = blue;
    blue = red;                
    red = aux;
  }
}

void keyPressed() {
  if (key == '0') {
    mode = 0; // menu
  } else if (key == '1') {
    mode = 1; // poggendorff
    pg = createGraphics(600, 500);
  } else if (key == '2') {
    mode = 2; // triangulo
    pg = createGraphics(600, 400);
    pg.smooth();
  } else if (key == '3') {
    mode = 3; // anstis
    pg = createGraphics(600, 400);
  } else if (key == '4') {
    mode = 4; // stroboscopic
    pg = createGraphics(600, 600);
  } else if (key == '5') {
    mode = 5; // cafeWall
    pg = createGraphics(canvasWidth, (cHeight + lineyHeight) * rows + lineyHeight);
  } else if (key == '6') {
    mode = 6; // necker cube
    pg = createGraphics(600, 600);
  }
  frameRate(60);
}

// Referencias:
