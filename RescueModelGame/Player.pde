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
  

  void update(){
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
        if(health<=6 && health>3){
          indexStatus = 1;
          }
            
        if(health<=3){
          indexStatus = 1;
          } 
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
    health--;
    // PlayerCrash image & move to the other side of rock or car
    if(health == 0){
      gameState = GAME_LOSE_BROKEN;
    }
  }
    
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    row = (int) ((y - PLAYER_INIT_Y) / 100) + 1;
  }
}
