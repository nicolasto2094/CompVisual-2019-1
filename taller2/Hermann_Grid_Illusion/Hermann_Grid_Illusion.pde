void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  for (int i = 0; i < height; i += 80) {
    stroke(255, 255, 255);
    strokeWeight(10);
    line(0, i, width, i);
    line(i, 0, i, height);
  }
}
