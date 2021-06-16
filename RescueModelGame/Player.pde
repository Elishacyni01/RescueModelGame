class Player{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  int row;
  
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 280;
  
  float frame;
  int indexStatus = 0;
  int indexRunPose = 0;
  
  float speed = 30;
  int health = 10;
  boolean playerIdleAppear = true;
  boolean playerCrashAppear = false;
  
  int hurtTimer = 0;
  int hurtDuration = 15;

  void update(){
    speed = 30;
      playerIdleAppear = true;
      
      // switch image between player0&1
      
      if(rightState){
        playerIdleAppear = false;
        if(frame % 10 == 0){
          roadSpeed -= speed;
          // switch image
          switch (indexRunPose) {
            case 0:
              indexRunPose = 1;
              break;
            case 1:
              indexRunPose = 0;
              break;
          }
        }
        if(health <= 6 && health > 3){
          indexStatus = 1;
        }
            
        if(health<=3 && health>=1){
          indexStatus = 2;
        } 


        image(playerImage[indexStatus][indexRunPose], x, y);

      }
      
      if(upState){
        if(y == 180){
          y = 180;
        }else{
          y -= h;
        }
        upState = false;
      }
      
      if(downState){
        if(y == height - h){
          y = height - h;
        }else{
          y += h;
        }
        downState = false;
      }
      
      if(playerIdleAppear == true){
        image(playerIdle, x, y);
      }
    
    frame ++;
  }
  

  
  void hurt(){
    
    rightState = false;
    // PlayerCrash image & move to the other side of rock or car
    hurtTimer = hurtDuration;
    
    if(hurtTimer > 0){
      speed = 0;
      playerIdleAppear = false;
      playerCrashAppear = true;
      hurtTimer --;
      
    }
    println(hurtTimer);
    if(hurtTimer == 0){
      playerCrashAppear = false;
    }
    if(playerCrashAppear == true){
      image(playerCrash0, x, y);
    }
      
    if(health == 0){
      gameState = GAME_LOSE_BROKEN;
    }
   frame ++;
  }
  
  void reduceTime(){

    
    gameTimer-=360;
    delay(5000);
   //try {
   // Thread.sleep(5000); 
   // gameTimer-=360;
 
   // } catch(InterruptedException ex) {
      
   // Thread.currentThread().interrupt();
   //  }

    //gameTimer-=360;
    //rightState = false;

    gameTimer -= 360;
    rightState = false;

  }

    
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    
  }
}
