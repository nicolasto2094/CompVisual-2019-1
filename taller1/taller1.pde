PGraphics pg;
PGraphics pg1;
PImage img;
import processing.video.*;
Movie myMovie;

void setup() {
  size(1150, 600);  
  img = loadImage("laDefense.jpg"); 
  pg = createGraphics(470, 400);
  pg1 = createGraphics(470, 400); 

  myMovie = new Movie(this, "transit.mp4");
  myMovie.loop();  
  myMovie.volume(0);
}


boolean select = true;
int option = 0;
float[][]matrix = new float[3][3];
void draw() {
 
  if(select){
  pg.beginDraw();  
  pg.image(img, 0, 0); 
  pg.endDraw();
  image(pg, 20, 20);
  }else{
  pg.beginDraw();
  pg.image(myMovie,0,0,470,400);
  pg.endDraw();
  image(pg, 20, 20);
  }
  botones();
  if(option==1){escalaGris();}
  if(option==2){float[][]matriz = {{-1,-1,-1},{-1,8,-1},{-1,-1,-1}};
    convolucion(matriz);}
  if(option==3){float[][]matriz = {{0,-1,0},{-1,5,-1},{0,-1,0}};
    convolucion(matriz);}
  if(option==4){float[][]matriz = {{-2,-1,0},{-1,2,1},{0,1,2}};
    convolucion(matriz);}
  float[][]matriz = {{random(-10,10),random(-10,10),random(-10,10)},{random(-10,10),random(-10,10),random(-10,10)},{random(-10,10),random(-10,10),random(-10,10)}};

  if(option==5){matrix = matriz;option=6;}
  if(option==6){convolucion(matrix);}  
  
  if(option==7){histograma();}  
  
}

void escalaGris(){  
  pg1.beginDraw();    
  int dimension = pg1.width * pg1.height;
  pg1.loadPixels();
  for (int i = 0; i < dimension; i++) {
    pg1.pixels[i] = color((red(pg.pixels[i])+blue(pg.pixels[i])+green(pg.pixels[i]))/3);
  }
  pg1.updatePixels();
  pg1.endDraw();
  pintar(pg1);
}

void convolucion(float[][]matriz){  
  pg1.beginDraw();    
  pg1.loadPixels();
  int xstart = 0;
  int ystart = 0;
  int xend = pg.width;
  int yend = pg.height;
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      color c = convolution(x, y, matriz, 3, pg);
      int loc = x + y*pg.width;
      pg1.pixels[loc] = c;
    }
  }
  pg1.updatePixels();
  pg1.endDraw();
  pintar(pg1);
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

void pintar(PGraphics grap){    
  image(grap,510,20);
}
int x=1000, y=160, w=100, h=30;
int xx=30, yy=500;
void botones(){
  int x=1000, y=160, w=100, h=30;
  fill(130);
  stroke(0);
  rect(x, y, w, h,10);
  fill(0);
  text("Imagen", x+6, y+h-10);
  if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h && mousePressed==true) {select =true;}
  
  fill(130);
  stroke(0);
  rect(x, y+40, w, h,10);
  fill(0);
  text("Video", x+6, y+h-10+40);  
  if(mouseX > x && mouseX < x+w && mouseY > y+40 && mouseY < y+h+40&& mousePressed==true) {select=false;}
  
  fill(130);
  stroke(0);
  rect(xx, yy, w, h,10);
  fill(0);
  text("Escala grises", xx+6, yy+h-10);  
  if(mouseX > xx && mouseX < xx+w && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=1;}
  
  fill(130);
  stroke(0);
  rect(xx+150, yy, w, h,10);
  fill(0);
  text("Bordes", xx+6+150, yy+h-10);  
  if(mouseX > xx+150 && mouseX < xx+w+150 && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=2;}
  
  fill(130);
  stroke(0);
  rect(xx+300, yy, w, h,10);
  fill(0);
  text("Afilar", xx+6+300, yy+h-10);  
  if(mouseX > xx+300 && mouseX < xx+w+300 && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=3;}
  
  fill(130);
  stroke(0);
  rect(xx+450, yy, w, h,10);
  fill(0);
  text("Repujado", xx+6+450, yy+h-10);  
  if(mouseX > xx+450 && mouseX < xx+w+450 && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=4;}
  
  fill(130);
  stroke(0);
  rect(xx+600, yy, w, h,10);
  fill(0);
  text("Aleatorio", xx+6+600, yy+h-10);  
  if(mouseX > xx+600 && mouseX < xx+w+600 && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=5;}
  
    
  fill(130);
  stroke(0);
  rect(xx+750, yy, w+100, h,10);
  fill(0);
  text("Histograma + segmentación", xx+6+750, yy+h-10);  
  if(mouseX > xx+750 && mouseX < xx+w+750 && mouseY > yy && mouseY < yy+h&& mousePressed==true) {option=7;}
 
  if(!select){
    fill(130);
    stroke(0);
    rect(xx, yy-60, w+100, h,10);
    fill(0);
    text("Cuadros por segundo: "+frameRate, xx+6, yy+h-70); 
  }else{
     fill(130);
    stroke(0);
    rect(xx, yy-60, w+100, h,10);
    fill(0);
    text("Imagen!", xx+6, yy+h-70); 
  } 

}

void histograma(){

  int[] hist = new int[256];

// Calculate the histogram
  for (int i = 0; i < pg.width; i++) {
    for (int j = 0; j < pg.height; j++) {
      int bright = int(brightness(get(i+20, j+20)));
      hist[bright]++; 
    }
  }

  // Find the largest value in the histogram
  int histMax = max(hist);

  stroke(255);
  for (int i = 0; i < pg.width; i += 2) {
    int which = int(map(i, 0, pg.width, 0, 255));
    int y = int(map(hist[which], 0, histMax, pg.height, 0));
    line(i+20, pg.height+20, i+20, y+20);  
    

  }
  if(mouseX>20 && mouseX<pg.width+20 && mouseY>20 && mouseY<pg.height+20){
  segmentar();}
}
int posX;
void segmentar(){
  posX = (mouseX-20);
  posX = (15*posX)/470;
  pg1.beginDraw();    
  int dimension = pg1.width * pg1.height;
  pg1.loadPixels();
  for (int i = 0; i < dimension; i++) {
    if(brightness(pg.pixels[i])>=posX*17 && brightness(pg.pixels[i])<=(posX+1)*17){
    pg1.pixels[i] = pg.pixels[i];}else{
      pg1.pixels[i] = color(200);
    }
  }
  pg1.updatePixels();
  pg1.endDraw();
  pintar(pg1);
}

void movieEvent(Movie m) {
  m.read();
}
