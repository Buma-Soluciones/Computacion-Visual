// Adaptacion de: https://editor.p5js.org/kylemath@gmail.com/sketches/cSDvZ9zOO

void setup(){
size(700, 400,P3D);
ortho();
}

void draw(){
  background(25);
  strokeWeight(3);

  push();
  translate(150, 200, 0);
  noFill();
  rotateDraw();
  pop();

  push();
  translate(350, 200, 0);
  noFill();
  rotateDraw();
  pop();

  push();
  translate(550, 200, 0);
  noFill();
  rotateDraw();
  pop();

}

void rotateDraw(){
  stroke(200);
  rotateZ(frameCount * 0.001);
  rotateX(frameCount * 0.001);
  rotateY(frameCount * 0.001);
  box(100, 100, frameCount * 0.1);
}
