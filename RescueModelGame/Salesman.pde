class Salesman{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  
  void display(){
    
  }
  
  void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){

      // stop player for some time

    }
  }
  
  // Contructor
  Salesman(float x, float y){
    this.x = x;
    this.y = y;
  }
}
