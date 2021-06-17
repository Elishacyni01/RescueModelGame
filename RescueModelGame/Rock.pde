class Rock{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  void display(){
    
    image(rock, x + roadSpeed, y, w, h);
  }
  
  boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){
      player.health -= 2;
      
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }

  // Contructor
  Rock(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
    
    
  }
}
