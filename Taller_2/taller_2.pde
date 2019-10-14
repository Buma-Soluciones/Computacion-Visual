int mode = 0;

PGraphics pg1;
PFont myFont;
PImage img;

// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 10;
int rows = 10;

// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x, y;   // x,y location
  float w, h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    angle = tempAngle;
  } 

  // Oscillation means increase angle
  void oscillate() {
    angle += 0.02;
  }

  void display() {
    stroke(255);
    // Color calculated using sine wave
    fill(127+127*sin(angle));
    rect(x, y, w, h);
  }
}

void setup() {
  background(0);
  myFont = createFont("Verdana", 50);
  createCanvas();
  //img = loadImage("imagen300.jpg");

  size(600, 600);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*20, j*20, 20, 20, i+j);
    }
  }
  //noLoop();
}

void draw() {
  if (mode == 0) {
    //println("Menu");
    menu();
  } else {
    background(0);
    // The counter variables i and j are also the column and row numbers and 
    // are used as arguments to the constructor for each object in the grid.  
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        // Oscillate and display each object
        grid[i][j].oscillate();
        grid[i][j].display();
      }
    }
  }
}

void createCanvas() {
  pg1 = createGraphics(300, 300); // canvas original
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
  text("Illusions", width/2, height/4);
  textSize(26);
  textAlign(CENTER, CENTER);
  String options = "G: Escala de grises\nC: Convoluciones\nV: Video\nM: Menu";
  text(options, width/2, height/4 + 100);

  textSize(32);
  text("Members", width/2, height/2 + 90);
  textSize(26);
  textAlign(CENTER, CENTER);
  String members = "Juan Sebastian Peña\nJuan Sebastian Becerra";
  text(members, width/2, height/2 + 160);
}


void keyPressed() {
  if (mode == 1 && (key == 'a' || key == 'A')) {
    redraw();
  }
  if (key == 'm' || key == 'M') {
    mode = 0; // menu
    redraw();  // or loop()
  }
  mode = key;
}

// Referencias:
