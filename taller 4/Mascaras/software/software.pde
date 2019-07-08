PGraphics pg;
PGraphics pg1;
PImage img;
/*import processing.video.*;
Movie myMovie;
*/
float[][] matrix = { { 0, 0, 0 },
                     { 0,  1, 0 },
                     { 0, 0, 0 } }; 

void setup() {
  size(720, 720);
  img = loadImage("laDefense.jpg"); 
}


/*
void setup() {
  size(1150, 600);  
  img = loadImage("laDefense.jpg"); 

  myMovie = new Movie(this, "transit.mp4");
  myMovie.loop();  
  myMovie.volume(0);
}
*/

void draw() {
 
  image(img, 0, 0);
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      color c = convolution(x, y, matrix, img);
      int pixel = x + y*img.width;
      pixels[pixel] = c;
    }
  }
  updatePixels();
  
  /*
  pg.beginDraw();
  pg.image(myMovie,0,0,470,400);
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++ ) {
      color c = convolution1(x, y, matrix1, myMovie);
      int pixel = x + y*myMovie.width;
      pixels[pixel] = c;
    }
  }
  updatePixels();
  pg.endDraw();
  image(pg, 20, 20);
  }
  botones();
  float[][]matriz = {{random(-10,10),random(-10,10),random(-10,10)},{random(-10,10),random(-10,10),random(-10,10)},{random(-10,10),random(-10,10),random(-10,10)}};
*/
}

color convolution(int x, int y, float[][] matrix, PImage img)
{
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  for (int i = 0; i < 3; i++){
    for (int j= 0; j < 3; j++){
      int pixel = x + i + (y + j) * img.width;
      if(pixel < img.pixels.length-1){
        r += (red(img.pixels[pixel]) * matrix[i][j]);
        g += (green(img.pixels[pixel]) * matrix[i][j]);
        b += (blue(img.pixels[pixel]) * matrix[i][j]);
      } 
    }
  }
  return color(r, g, b);
}

void keyPressed() {
  if (key == '1') {  //Sharpness
     matrix = new float[][]{ { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } }; 
  }else if(key == '2'){ //Edge detection 1
    matrix = new float[][]{ { 1, 0, -1 },
                     { 0,  0, 0 },
                     { -1, 0, 1 } }; 
  }else if(key == '3'){ //Edge detection 2
    matrix = new float[][]{ { 0, 1, 0 },
                     { 1,  -4,  1},
                     { 0, 1, 0 } }; 
  }else if(key == '4'){ //Edge detection 3
    matrix = new float[][]{ { -1, -1, -1 },
                     { -1,  8, -1},
                     { -1, -1, -1} }; 
  }else if(key == '5'){ //Emboss
    matrix = new float[][]{ { 2, 0,  0},
                     { 0,  -1, 0},
                     { 0, 0, -1} }; 
  }else if(key == '6'){ //Repujado
    matrix = new float[][]{ { -2, -1,  0},
                     { -1,  1, 1},
                     { 0, 1, 2} }; 
  }else{ //Normal
    matrix = new float[][]{ { 0, 0,  0},
                     { 0,  1, 0},
                     { 0, 0, 0} }; 
  }
}

/*
void movieEvent(Movie m) {
  m.read();
}*/
