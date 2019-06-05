import nub.timing.*;
import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. nub' objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;
// triangle's vertices color
color[] c = {color(255, 255, 0), color(0, 255, 255), color(255, 0, 255)};
int sft = 100;
// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean squareCap = false;
boolean antialiasing = false;
boolean depthMap = false;
// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(1024, 1024, renderer);

  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  //scene.fitBallInterpolation();

  // not really needed here but create a spinning task
  // just to illustrate some nub.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}

void triangleRaster() {  
  int limCoord = floor(pow(2, n)/2);
  boolean repeat = true;
  for (int i = - limCoord; i < limCoord; i++) {
    for (int j = - limCoord; j < limCoord; j++) {
      pushStyle();
      Vector p = node.worldLocation(new Vector(i + 0.5f, j + 0.5f));
      if (belongsToArea(p, false)) {
        drawPoint(i, j);
        repeat = false;
        if (antialiasing) {
          Vector[] n = neighbors(i, j);
          for (int k = 0; k < 8; k++) {
            if (belongsToArea(n[k], true)) {
              int[] po = positions(k);
              drawPoint(i + po[0], j + po[1]);
            }
          }
        }
      }
      popStyle();
    }
    if (i == limCoord - 1 && repeat) {
      Vector v = v1;
      v1 = v2;
      v2 = v;
      i = -limCoord;
      repeat = false;
    }
  }

}


boolean belongsToArea(Vector p, boolean softMode) {
  boolean belongsTo;
  float w[] = new float[3];
  belongsTo = (w[0] = edge(p, v1, v2)) >= 0;
  belongsTo &= (belongsTo || softMode) ? (w[1] = edge(p, v2, v3)) >= 0 : false;
  belongsTo &= (belongsTo || softMode) ? (w[2] = edge(p, v3, v1)) >= 0 : false;
  if (belongsTo && !softMode || !belongsTo && softMode) {
    color c = interpolateRGB(w);
    if (depthMap)
      c = depthMap(p, c);
    if (softMode)
      c = color(c, sft);
    setColor(c);
    return true;
  }
  return false;
}


color interpolateRGB(float[] edge) {
  float r = 0, g = 0, b = 0, 
    area = edge(v1, v2, v3);
  for (int i = 0; i < 3; i++) {
    edge[i] /= area;
    r += edge[i] * red(c[i]);
    g += edge[i] * green(c[i]);
    b += edge[i] * blue(c[i]);
  }
  return color(r, g, b);
}

float distanceToEye(Vector p) {
  Vector eye = scene.eye().position();
  Vector point = scene.eye().location(p);
  float d = eye.distance(point);
  return norm(d, 2000, 0);
}

float edge(Vector p, Vector vi, Vector vj) {
  float px = node.location(p).x(), py = node.location(p).y(), 
    vix = node.location(vi).x(), viy = node.location(vi).y(), 
    vjx = node.location(vj).x(), vjy = node.location(vj).y();
  return (px - vix) * (vjy - viy) - (py - viy) * (vjx - vix);
}

color depthMap(Vector p, color c) {
  float normDistance = distanceToEye(p), 
    r = red(c) * normDistance, 
    g = green(c) * normDistance, 
    b = blue(c) * normDistance;
  return color(r, g, b);
}


void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    v1 = new Vector(mouseX-width/2, mouseY-height/2);
  } else if (mouseButton == RIGHT) {
    v2 = new Vector(mouseX-width/2, mouseY-height/2);
  } else {
    v3 = new Vector(mouseX-width/2, mouseY-height/2);
  }
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}


Vector[] neighbors(int i, int j) {
  Vector[] n = new Vector[8];
  for (int k = 0; k < 8; k++) {
    int [] po = positions(k);
    n[k] = node.worldLocation(new Vector(i + po[0] + 0.5f, j + po[1] + 0.5f));
  }
  return n;
}

int[] positions(int i) {
  int [] po = new int[2];
  switch(i) {
  case 0:
    po[0] = -1;
    po[1] = -1;
    break;
  case 1:
    po[0] = 1;
    po[1] = 1;
    break;
  case 2:
    po[0] = -1;
    po[1] = 1;
    break;
  case 3:
    po[0] = 1;
    po[1] = -1;
    break;
  case 4:
    po[0] = 0;
    po[1] = -1;
    break;
  case 5:
    po[0] = -1;
    po[1] = 0;
    break;
  case 6:
    po[0] = 0;
    po[1] = 1;
    break;
  case 7:
    po[0] = 1;
    po[1] = 0;
    break;
  }
  return po;
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
  if (key == 'a')
    antialiasing = !antialiasing;
  if (key == 'p')
    depthMap = !depthMap;

}

void drawPoint(float x, float y) {
    noStroke();
    rect(x, y, 1, 1);

}

void setColor(color c) {
  stroke(c);
  fill(c);
}
