// Adaptacion de: https://editor.p5js.org/kylemath@gmail.com/sketches/cSDvZ9zOO

void setup(){
size(600, 400,P3D);
ortho();
}

void draw(){
  background(25);
  strokeWeight(3);

  push();
  translate(width/2, height/2, 0);
  noFill();
  rotateDraw();
  pop();
}

void rotateDraw(){
  stroke(200);
  rotateX(frameCount * 0.002);
  rotateY(frameCount * 0.002);
  box(200, 200, frameCount * 0.1);
}
