float w2, h2; 
float x, y;

void setup() {
  size(710, 340);
  w2 = width/2;
  h2 = height/40.0f;
  stroke(255, 0, 0);
  x = height/4 + 230;
  y = height/4 -30;
  
}

void draw() {
  background(255, 255, 255);
    
    for (int i=2; i<40; i+=8) {
      if (i%2 == 0) {
        fill(0);
        stroke(0);
        strokeWeight(5);
        rect(w2-(i*6), h2*i, 60+(i*12), h2);
      }
    }
    
    stroke(0);
    strokeWeight(12);
    line(w2/2+10, height , w2+15, 0);
    line(w2+48, 0, width - (w2/2 - 48), height);
    
    stroke(255, 0, 0);
    line (w2-20, y, 80+w2, y);
    
    if (y <= height/4 + 230){ 
      y = y + 0.5; 
    }
    
    line (w2-20, x, 80+w2, x);
    
    if (x >= height/4 -30){ 
      x = x - 0.5; 
    }
   
}
