class Salesman{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  void display(){
    image(salesman, x + roadSpeed, y, w, h);
  }
    
  
  boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h) && isAlive){
      
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }
  
  // Contructor
  Salesman(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
