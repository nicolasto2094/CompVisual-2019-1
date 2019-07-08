PGraphics pg;
PImage img;
import processing.video.*;
Movie myMovie;

PShape texImg;
PShader texShader;

PShape texVid;
PShader texShader1;

void setup() {
  size(1150, 600, P2D);  
  img = loadImage("laDefense.jpg"); 
  texImg = createShape(img);
  texShader = loadShader("normal.glsl");
  

  /*myMovie = new Movie(this, "transit.mp4");
  myMovie.loop();  
  myMovie.volume(0);
  texImg = createShape(myMovie);
  texShader = loadShader("normal.glsl");
  */
  
}


boolean select = true;
int option = 0;
float[][]matrix = new float[3][3];

void draw() {

  shader(texShader);
  shape(texImg);
  
}
void movieEvent(Movie m) {
  m.read();
}

PShape createShape(PImage tex) {
  textureMode(NORMAL);
  PShape shape = createShape();
  shape.beginShape();
  shape.noStroke();
  textureMode(NORMAL);
  shape.texture(tex);
  shape.vertex(0, 0, 0, 0);
  shape.vertex(width, 0, 1, 0);
  shape.vertex(width, height, 1, 1);
  shape.vertex(0, height, 0, 1);
  shape.endShape();
  return shape;
}

void keyPressed() {
  if (key == '1') {  //Sharpness
     texShader = loadShader("sharpness.glsl");
  }else if(key == '2'){ //Edge detection 1
    texShader = loadShader("edge1.glsl");
  }else if(key == '3'){ //Edge detection 2
    texShader = loadShader("edge2.glsl");
  }else if(key == '4'){ //Edge detection 3
    texShader = loadShader("edge3.glsl");
  }else if(key == '5'){ //Emboss
    texShader = loadShader("emboss.glsl");
  }else if(key == '6'){ //Repujado
   texShader = loadShader("repujado.glsl");
  }else{ //Normal
    texShader = loadShader("normal.glsl");
  }
}
