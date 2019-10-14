int cWidth = 30; // cell width
int cHeight = 26; // cell height
int linexHeight = 1; // stroke width for horizontal
int lineyHeight = 2; // stroke width for vertical lines
int rows = 9; // number of rows to draw
int canvasWidth = 400; // canvas width

void settings(){
  size(canvasWidth, (cHeight + lineyHeight) * rows + lineyHeight);
}
void setup(){
  
  background(136,136,136);
  smooth();
  mouseMoved();
}
void drawRow(int row) {
        int yPos = row * (cHeight + lineyHeight) + lineyHeight;
        int numCells = ceil(canvasWidth / cWidth) + 3;
        for (int i = -80; i < numCells; i = i + 1) {
            if (i % 2 == 0) {
                fill(0);
            } else {
                fill(255);
            }
            noStroke();
            int pos = row % 4;
            if (pos == 3) pos = 1;
            rect(
                i * (cWidth + linexHeight) - pos * mouseX / 15 % (2 * cWidth) + 15,
                yPos,
                cWidth,
                cHeight
            );
        }
    }
void draw(){ }

void mouseMoved(){
  background(136,136,136);
  for (int i = 0; i < rows; i = i + 1) {
            drawRow(i);
        }

}
