/*
Codigo basado en el codigo de Victor Ramirez
https://github.com/VisualComputing/Cognitive/blob/gh-pages/sketches/poggendorff.js
*/

//declaracion de los colores del triangulo
color yellow1 = color(253,255,0);
color red1 = color(255,0,0);
color blue1 = color(0,0,255);

//funcion setup
void setup(){
  size(600, 400);
}

//funcion draw
void draw(){
  background(255);
  float LineWidth = 50.0;
  strokeWeight(3);
  float x1 =  (width - LineWidth) / 2.0;
  float x2 =  (width + LineWidth) / 2.0;
  float y1 =  20.0;
  float y2 =  height - y1;
  float d = 100.0;
  float z = 25.0;
  stroke(red1);
  line( x1-d, y1, (x1+x2)/2.0, (y1+y2)/2.0 );
  stroke(yellow1);
  line( x2+d, y2, (x1+x2)/2.0, (y1+y2)/2.0 );
  stroke(blue1);
  line( z*(x1 - 2*d - x2)/(y1-y2) + d + x2, y2, (x1+x2)/2.0, (y1+y2)/2.0-z );
  if( !mousePressed ){
            noStroke();
            fill(90);
            rect( x1, y1, x2-x1, y2-y1);
        }
  
}
