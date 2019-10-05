void setup(){
  size(600, 400);
}

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
  stroke(255,0,0);
  line( x1-d, y1, (x1+x2)/2.0, (y1+y2)/2.0 );
  stroke( 0, 255, 0 );
  line( x2+d, y2, (x1+x2)/2.0, (y1+y2)/2.0 );
  stroke( 0, 0, 255 );
  line( z*(x1 - 2*d - x2)/(y1-y2) + d + x2, y2, (x1+x2)/2.0, (y1+y2)/2.0-z );
  if( !mousePressed ){
            noStroke();
            fill(90);
            rect( x1, y1, x2-x1, y2-y1);
        }
  
}
