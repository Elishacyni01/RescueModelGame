class Rock{
  float x, y;
  float w = 80, h = 80;
  boolean isAlive;
  
  void display(){
    
  //  if(rightState){
  //    x--;
  //}
    
    if(isAlive == true){
      for(int i=0; i<3; i++){
        x=100+i*200;
        y=170+i*100;
        image(rock, x + roadSpeed, y, w, h);
      }
    }
    
  }
  
  void checkCollision(Player player){

    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){
      x=y=-1000;
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
