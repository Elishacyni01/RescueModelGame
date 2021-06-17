class Motor{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  void display(){
    image(motor0, x + roadSpeed, y, w, h);
  }
  
  
  void checkCollision(Player player){
    
  }
  
  // Contructor
  Motor(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
