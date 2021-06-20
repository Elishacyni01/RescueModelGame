class Car{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  float speed = 2;
  
  void display(){
    image(car, x + roadSpeed, y, w, h);
  }
  
  void update(){
    y += speed;
    if(y >= height) y = -h;
  }
  
  boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){
      
      // player.health -= 3;
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }
  
  
  // Contructor
  Car(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
