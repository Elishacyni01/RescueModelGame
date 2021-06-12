class Rock{
  float x, y;
  float w = 60, h = ROAD_SIZE;
  boolean isAlive;
  
  void display(){
    
    if(isAlive == true){
      image(rock, x, y, w, h);
    }
    if(rightState){
      x--;
  }
  }
  
  void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){

      player.hurt();
      isAlive = false;
    }
  }
  
  // Contructor
  Rock(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
