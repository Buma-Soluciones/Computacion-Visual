/*
Codigo basado en el codigo de Edwin Alexander Bohorquez Gamba
https://github.com/VisualComputing/Cognitive/blob/gh-pages/sketches/PenroseTriangle.js
*/

//declaracion de los colores del triangulo
color yellow1 = color(253,255,0);
color red1 = color(255,0,0);
color blue1 = color(0,0,255);
color aux;

//funcion setup
void setup(){
  size(600, 400);
  smooth();
}

//funcion draw
void draw(){
   background(255);          
   strokeWeight(3);                
        //Figura amarilla
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
        
        //Figura roja
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
        //Figura azul
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

//cada vez que se da click los colores se van rotando para generar la ilusion
void mouseClicked() {
  aux = yellow1;
  yellow1 = blue1;
  blue1 = red1;                
  red1 = aux; 
}
