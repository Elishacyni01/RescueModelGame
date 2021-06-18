class Player{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  int row;
  
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 280;
  
  float frame;
  int indexStatus = 0;
  int indexRunPose = 0;
  
  float speed = 50;
  int health = 10;
  boolean idleAppear = true;
  boolean crashAppear = false;
  boolean friendAppear = false;
   
  int hurtTimer = 0;
  int hurtDuration = 40;
  
  
  void update(){
    
      //idleAppear = true;
      
      // switch image between player0&1
      
      if(rightState){
        idleAppear = false;
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
          speed = 40;
        }
            
        if(health<=3 && health>=1){
          indexStatus = 2;
          speed = 25;
        } 


        image(playerImage[indexStatus][indexRunPose], x, y);

      }
      
      if(upState && hurtTimer == 0){
        if(y == 180){
          y = 180;
        }else{
          y -= h;
        }
        upState = false;
      }
      
      if(downState && hurtTimer == 0){
        if(y == height - h){
          y = height - h;
        }else{
          y += h;
        }
        downState = false;
      }
      
      if(idleAppear == true){
        image(playerIdle, x, y);
      }
      
      if(!rightState && !upState && !downState && hurtTimer == 0){
        idleAppear = true;
      }
    
    // ---------- PLAYER HURT ----------
    // println(crashAppear);
    if(crashAppear == true){
      // Set the hurtTimer and start to count down
      //hurtTimer = hurtDuration;
      
      if(hurtTimer > 0){
        // Player is not allowed to make movement
        rightState = false;
        upState = false;
        downState = false;
        
        image(playerCrash0, x, y);
        hurtTimer --;
        
      }
      if(hurtTimer == 0){
       idleAppear = true;
       crashAppear = false;
      }
    }
    println(hurtTimer);
    
    
    
    
    
    frame ++;
  }
  

  
  void hurt(){
    // PLAYER WILL CRASH TO THE GROUND
    // PlayerHealth decrease will be written in their own class.
    
    idleAppear = false;
    crashAppear = true;
    
    // Set the hurtTimer and start to count down
    hurtTimer = hurtDuration;
  }
  
  //void touchLine(){
   
  //  if(player.x > 30){
  //  x+=speed;
  //  rightState = false;
  //  }
  //}
  
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

  void helpByFriend(){
    idleAppear = false;
    crashAppear = false;
    friendAppear = true;
    
    if(rightState){
      roadSpeed -= 3 * speed;
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
      
    if(friendAppear == true){
      image(motor1, x, y);
    }
    
    
    frame ++;
  }
  
  
  
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    
  }
}
