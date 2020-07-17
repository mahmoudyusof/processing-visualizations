float [][] field;
int res = 5;
int cols, rows;
float xoff, yoff, zoff;
float inc = 0.05;

OpenSimplexNoise noise;

void setup(){
  //size(800, 600);
  fullScreen(P2D);
  noise = new OpenSimplexNoise();
  cols = 1 + width / res;
  rows = 1 + height / res;
  field = new float[cols][rows];
}
void line(PVector v1, PVector v2){
  line(v1.x, v1.y, v2.x, v2.y);
}


void draw(){
  background(0);
  xoff = 0;
  for(int i=0; i<cols; i++){
    yoff = 0;
    for(int j=0; j<rows; j++){
      field[i][j] = (float) Math.abs(noise.eval(xoff, yoff, zoff));
      yoff += inc;
    }
    xoff += inc;
  }
  
  zoff += 0.01;
  //for(int i=0; i<cols; i++){
  //  for(int j=0; j<rows; j++){
  //    stroke(field[i][j] * 255);
  //    strokeWeight(res * 0.4);
  //    point(i*res, j*res);
  //  }
  //}
  
  for(int i=0; i<cols-1; i++){
    for(int j=0; j<rows-1; j++){
      float x = i * res;
      float y = j * res;
      float top_mean = (field[i][j] + field[i+1][j]) / 2.0;
      float right_mean = (field[i+1][j] + field[i+1][j+1]) / 2.0;
      float bottom_mean = (field[i+1][j+1] + field[i][j+1]) / 2.0;
      float left_mean = (field[i][j+1] + field[i][j]) / 2.0;
      
      PVector a = new PVector(x+res*top_mean, y);
      PVector b = new PVector(x+res, y+res*right_mean);
      PVector c = new PVector(x+res*bottom_mean, y+res);
      PVector d = new PVector(x, y+res*left_mean);
      int state = getState(
        field[i][j] > 0.2 ? 1 : 0,
        field[i+1][j] > 0.2 ? 1 : 0,
        field[i+1][j+1] > 0.2 ? 1 : 0,
        field[i][j+1] > 0.2 ? 1 : 0
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

int getState(int a, int b, int c, int d){
  return a*8 + b*4 + c*2 + d;
}
