class Salesman{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  void display(){
    image(salesman, x + roadSpeed, y, w, h);
  }
  
  void checkCollision(Player player){

    if(isHit(x+ roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){

      // stop player for some time
     player.reduceTime();
     isAlive = false;
    }
  }
  
  // Contructor
  Salesman(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
