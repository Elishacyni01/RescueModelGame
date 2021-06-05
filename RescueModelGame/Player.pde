class Player{
  final float PLAYER_INIT_X;
  final float PLAYER_INIT_Y;

  void update(){
    //PImage playerDisplay = playerIdle;
    
    if(rightState){
      for(int i = 0; i < 120; i++){
        if(i % 2 == 0){
          image(player[0][0],0,165);
        }else{
          image(player[1][0],0,165);
        }
      }
    }
  }
}
