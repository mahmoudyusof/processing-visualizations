int n = 10;

Ball[] balls = new Ball[n];
float[][] field;
int res = 6;
int rows, cols;
int dx, dy;

void setup(){
  size(600, 400, P2D);
  //fullScreen(P2D);
  rows = 1 + height / res;
  cols = 1 + width / res;
  field = new float[cols][rows];
  for(int i=0; i<n; i++){
    dx = (int)Math.ceil(random(-3, 3));
    dy = (int)Math.ceil(random(-2, 2));
    balls[i] = new Ball(
      (int)Math.ceil(random(width / 2) + width / 8),
      (int)Math.ceil(random(height / 2) + height / 8),
      dx == 0 ? 1 : dx,
      dy == 0 ? 1 : dy,
      (int)Math.ceil(random(10, 100))
    );
  }
  
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      field[i][j] = fun(i*res, j*res);
    }
  }
}

void draw(){
  background(0);
  stroke(255, 0, 0);
  strokeWeight(1);
  noFill();
  for(Ball ball : balls){
    //circle(ball.x, ball.y, ball.radius*2);
    ball.x += ball.dx;
    ball.y += ball.dy;
    if(ball.x - ball.radius < 0 || ball.x + ball.radius > width){
      ball.dx = -1 * ball.dx;
    }
    
    if(ball.y - ball.radius < 0 || ball.y + ball.radius > height){
      ball.dy = -1 * ball.dy;
    }
  }
  for(int i=0; i<cols; i++){
    for(int j=0; j<rows; j++){
      field[i][j] = fun(i*res, j*res);
    }
  }
  strokeWeight(5);
  for(int i=0; i<cols-1; i++){
    for(int j=0; j<rows-1; j++){
      //if(field[i][j] > 1){
      //  stroke(0, 255, 0);
      //}else{
      //  stroke(100);
      //}
      //point(i*res, j*res);
      
      //PVector q = new PVector(i*res, j*res);
      //PVector r = new PVector(i*res + res, j*res);
      //PVector s = new PVector(i*res + res, j*res + res);
      //PVector t = new PVector(i*res, j*res + res);
      float fq = fun(i*res, j*res);
      float fr = fun(i*res + res, j*res);
      float fs = fun(i*res + res, j*res + res);
      float ft = fun(i*res, j*res + res);
      
      PVector a = new PVector(Math.abs(( res*Math.abs(1-fr) / Math.abs(fq-fr) ) - (i*res+res)), j*res);
      PVector b = new PVector(i*res+res, Math.abs(( res*Math.abs(1-fr) / Math.abs(fs-fr) ) + (j*res)));
      PVector c = new PVector(Math.abs(( res*Math.abs(1-ft) / Math.abs(fs-ft) ) + i*res), j*res+res);
      PVector d = new PVector(i*res, Math.abs(( res*Math.abs(1-fq) / Math.abs(ft-fq) ) + j*res));
      int state = getState(
        field[i][j] > 1 ? 1 : 0,
        field[i+1][j] > 1 ? 1 : 0,
        field[i+1][j+1] > 1 ? 1 : 0,
        field[i][j+1] > 1 ? 1 : 0
      );
      stroke(255);
      strokeWeight(1);
      switch(state){
        case(1):
          line(c, d);
          break;
        case(2):
          line(b, c);
          break;
        case(3):
          line(b, d);
          break;
        case(4):
          line(a, b);
          break;
        case(5):
          line(a, d);
          line(b, c);
          break;
        case(6):
          line(a, c);
          break;
        case(7):
          line(a, d);
          break;
        case(8):
          line(a, d);
          break;
        case(9):
          line(a, c);
          break;
        case(10):
          line(a, b);
          line(c, d);
          break;
        case(11):
          line(a, b);
          break;
        case(12):
          line(b, d);
          break;
        case(13):
          line(b, c);
          break;
        case(14):
          line(c, d);
          break;
      }
    }
  }
}


float fun(int x, int y){
  float max = 0;
  float val = 0;
  for (Ball ball : balls){
    val = (float)(Math.pow(ball.radius, 2) / (Math.pow(x - ball.x, 2) + Math.pow(y - ball.y, 2)));
    if(val > max) max = val;
  }
  return max;
}

int getState(int a, int b, int c, int d){
  return a*8 + b*4 + c*2 + d;
}
void line(PVector v1, PVector v2){
  line(v1.x, v1.y, v2.x, v2.y);
}
