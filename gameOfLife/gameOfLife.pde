int res = 5;
int rows;
int cols;
int[][] grid;
int[][] clone;
int n = 0;
void setup() {
  //size(800, 800);
  fullScreen(P2D);
  rows = width / res;
  cols = height / res;
  grid = new int[rows][cols];
  clone = new int[rows][cols];
  
  for(int i=0; i<rows; i++){
    for(int j=0; j<cols; j++){
      grid[i][j] = floor(random(2));
    }
  }
  frameRate(15);
  
}

void draw() {
  background(0);
  for(int i=0; i<rows; i++){
    for(int j=0; j<cols; j++){
      stroke(1);
      fill(grid[i][j] * 255);
      rect(i*res, j*res, res, res);
      n = aliveNeighbors(i, j);
      if(grid[i][j] == 1 && n < 2){
        clone[i][j] = 0;
      }else if(grid[i][j] == 1 && (n == 2 || n == 3)){
        clone[i][j] = 1;
      }else if(grid[i][j] == 1 && n > 3){
        clone[i][j] = 0;
      }else if(grid[i][j] == 0 && n == 3){
        clone[i][j] = 1;
      }else{
        clone[i][j] = grid[i][j];
      }
    }
  }
  
  for(int i=0; i<rows; i++){
    for(int j=0; j<cols; j++){
      grid[i][j] = clone[i][j];
    }
  }
  
}

int aliveNeighbors(int r, int c){
  int res = 0;
  if(r > 0){
    res += grid[r-1][c];
    if(c > 0){
      res += grid[r-1][c-1];
    }
    if(c < cols-1){
      res += grid[r-1][c+1];
    }
  }
  if(r < rows-1){
    res += grid[r+1][c];
    if(c > 0){
      res += grid[r+1][c-1];
    }
    if(c < cols-1){
      res += grid[r+1][c+1];
    }
  }
  if(c > 0){ res += grid[r][c-1]; }
  if(c < cols-1){ res += grid[r][c+1]; }
  return res;
}
