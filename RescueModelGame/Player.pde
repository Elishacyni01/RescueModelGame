class Player{
  float x, y;
  float w = 100, h = 100;
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 160;

  void update(){
    PImage playerDisplay = player[0][0];
    
    if(rightState){
      for(int i = 0; i < 120; i++){
        if(i % 2 == 0){
          image(player[0][0],0,165);
        }else{
          image(player[1][0],0,165);
        }
      }
    }else if(upState){
    }else if(downState){
    }
    image(playerDisplay, x, y);
  }
  
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
  }
}
