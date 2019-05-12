Cell[][] grid; 
 
// Number of columns and rows in the grid 
int cols = 100; 
int rows = 100; 
 
void setup() { 
 
  size(500,500); 
  grid = new Cell[cols][rows]; 
  for (int i = 0; i < cols; i++) { 
    for (int j = 0; j < rows; j++) { 
      // Initialize each object 
      grid[i][j] = new Cell(i*40,j*40,40,40,i+j); 
    } 
  } 
 
} 
int pos = 0;
int cont = 0;
void draw() { 
   background(0); 
  // The counter variables i and j are also the column and row numbers and  
  // are used as arguments to the constructor for each object in the grid.   
  for (int i = 0; i < cols; i++) { 
    for (int j = 0; j < rows; j++) { 
      // Oscillate and display each object 
      grid[i][j].display(i,j,-pos); 
    } 
  } 
  if(cont%3==0){
  if (cont <  1000){pos++;}
  else{
    pos--;
    if(cont > 2000){cont=0;}}
  }
  cont++;
} 
 
class Cell { 
  // A cell object knows about its location in the grid  
  // as well as its size with the variables x,y,w,h 
  float x,y;   // x,y location 
  float w,h;   // width and height 
  float angle; // angle for oscillating brightness 
 
  // Cell Constructor 
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) { 
    x = tempX; 
    y = tempY; 
    w = tempW; 
    h = tempH; 
    angle = tempAngle; 
  }     
  void display(int i, int j, int pos) { 
    strokeWeight(2); 
    stroke(125); 
    // Color calculated using sine wave 
    if(j%2==0){       
      if(i%2!=0){ 
        fill(0);} 
      else{ 
        fill(255);}
        rect(x+pos,y,w,h);  
    }else{ 
      if(i%2==0){ 
        fill(0);} 
      else{ 
        fill(255);} 
        rect(x,y,w,h);  
  } 
    
  } 
}
