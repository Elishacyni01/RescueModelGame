class Player{
  float x, y;
  float w = 100, h = 100;
  int row;
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 380;

  void update(){
    //PImage playerDisplay = playerIdle;
    
    /*
    if(rightState){
      for(int i = 0; i < 120; i++){
        float t = 0;
        if(t % 2 == 0){
          image(playerImage[0][0], x, y);
        }else if(t % 2 == 1){
          image(playerImage[1][0], x, y);
        }
        t++;
      }
    }
    
    
    //while(isHit == false){
      // switch image between player0&1
    
    
    if(upState){
      
      // if the player aren't at the top line
      if(row > 1){
        y -= 110;
        upState = false;
      }
      
    }else if(downState){
      
      // if the player aren't at the bottom line
      if(row < 3){
        y += 110;
        downState = false;
      }
    
    }
    */
    //image(playerIdle, x, y);
  }
  
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    row = (int) ((y - PLAYER_INIT_Y) / 100) + 1;
  }
}
