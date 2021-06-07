class Player{
  float x, y;
  float w = 100, h = 100;
  int row;
  final float PLAYER_INIT_X = 30;
  final float PLAYER_INIT_Y = 380;
  float frame;
  int indexStatus = 0;
  int indexRunPose = 0;
  float speed = 5;
  boolean playerIdleAppear = true;
  int health = 10;

  void update(){
    //PImage playerDisplay = playerIdle;
    playerIdleAppear = true;
    // switch image between player0&1
    
    if(rightState){
      playerIdleAppear = false;
      if(frame % 15 == 0){
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
  
  
    
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    row = (int) ((y - PLAYER_INIT_Y) / 100) + 1;
  }
}
