color yellow1 = color(253,255,0);
color red1 = color(255,0,0);
color blue1 = color(0,0,255);
color aux;

void setup(){
  size(600, 400);
  smooth();
}

void draw(){
   background(255);          
   strokeWeight(3);                

        beginShape();        
        fill(yellow1);        
        vertex(270, 25);
        vertex(108, 316);
        vertex(137, 368);
        vertex(271, 129);
        vertex(346, 264);
        vertex(405, 264);
        vertex(270, 25);                
        endShape();

        beginShape();
        fill(red1);
        vertex(270, 25);
        vertex(329,25);
        vertex(491,316);
        vertex(228,316);
        vertex(257,264);
        vertex(405,264);
        vertex(270, 25);
        endShape();
        
        beginShape();
        fill(blue1);
        vertex(300, 182);
        vertex(228,316); 
        vertex(491,316);
        vertex(467, 368);
        vertex(137, 368);             
        vertex(271, 129);
        vertex(300, 182);
        endShape();    
}

void mouseClicked() {
  aux = yellow1;
  yellow1 = blue1;
  blue1 = red1;                
  red1 = aux; 
}
