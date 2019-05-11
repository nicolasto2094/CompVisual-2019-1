int gridSize = 60;
void setup() {
  size(640, 360);

}

void draw() {
  background(255, 255, 255);
  stroke(255, 0, 0);
  strokeWeight(5);
  if (!mousePressed) {    
    line(0, height/3 , width, height/3);
    line(0, 2*height/3 , width, 2*height/3);
    
  } else {
    background(255, 255,255);
    stroke(255, 0, 0);
    line(0, height/3 , width, height/3);
    line(0, 2*height/3 , width, 2*height/3);
    
    for (int x = 0; x <= width ; x += gridSize) {
    for (int y = 0; y <= height; y += gridSize) {
      //noStroke();
      //fill(255);
      strokeWeight(3);
      stroke( 20, 20, 20);
      line(x, y, width/2, height/2);
    }
  }
    
    
  }
}
