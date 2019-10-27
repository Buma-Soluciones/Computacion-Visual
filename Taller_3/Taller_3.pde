import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 9;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

 
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);
  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    float area = (node.location(v3).x()-node.location(v1).x())*(node.location(v2).y()-node.location(v1).y()) - (node.location(v3).y()-node.location(v1).y())*(node.location(v2).x()-node.location(v1).x());
    push();
    noStroke();
        for (int x = round(-pow(2, n-1)); x < pow(2, n-1); x++) {
      for (int y = round(-pow(2, n-1)); y < pow(2, n-1); y++) {
        int c = 0;
        if (core(x+0.25, y+0.25) == true)
          c += 1;
        if (core(x+0.75, y+0.25) == true)
          c += 1;
        if (core(x+0.25, y+0.75) == true)
          c += 1;
        if (core(x+0.75, y+0.75) == true)
          c += 1;
        if (c > 0) {
          float w1 = border(v2, v3, new Vector(x+0.5,y+0.5));
          float w2 = border(v3, v1, new Vector(x+0.5,y+0.5));
          float w3 = border(v1, v2, new Vector(x+0.5,y+0.5));
          w1 /= area;
          w2 /= area;
          w3 /= area;
          fill((map(w1, 0, 1, 0, 255)*c/4), (map(w2, 0, 1, 0, 255)*c/4), (map(w3, 0, 1, 0, 255)*c/4));
          square(x, y, 1);
        };
      }
    }
    pop();
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  push();

  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

float border(Vector a, Vector b, Vector c){
  return (c.x()-node.location(a).x())*(node.location(b).y()-node.location(a).y()) - (c.y()-node.location(a).y())*(node.location(b).x()-node.location(a).x());
}

boolean core(float x, float y) {
  boolean core1 = true;
  core1 &= (border(v1, v2, new Vector(x,y)) <= 0);
  core1 &= (border(v2, v3, new Vector(x,y)) <= 0);
  core1 &= (border(v3, v1, new Vector(x,y)) <= 0);
  
  boolean core2 = true;
  core2 &= (border(v1, v2, new Vector(x,y)) >= 0);
  core2 &= (border(v2, v3, new Vector(x,y)) >= 0);
  core2 &= (border(v3, v1, new Vector(x,y)) >= 0);
  return core1||core2;
}



void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
