class Rock{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  
  void display(){
    // image(rock, x, y, w, h);
  }
  
  void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){

      player.hurt();

    }
  }
  
  // Contructor
  Rock(float x, float y){
    this.x = x;
    this.y = y;
  }
}
