class Player{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  
  final float PLAYER_INIT_X = 0;
  final float PLAYER_INIT_Y = 280;
  
  float frame;
  int indexStatus = 0;
  int indexRunPose = 0;
  
  float speed;
  float runningSpeed = 40;
  float motorSpeed = 10;
  int health = 10;
  boolean idleAppear = true;
  boolean crashAppear = false;
  boolean friendAppear = false;
  
  boolean endingRun = false;
  int endingTimer = 0;
  int endingDuration = 1000;
  
  int hurtTimer = 0;
  int hurtDuration = 40;
  int helpTimer = 0;
  int helpDuration = 100;
  int sellTimer = 0;
  int sellDuration = 100;
  
  
  void update(){
    
   if(rightState){
     idleAppear = false;
        
     // ----- IF FRIEND NOT HELPING -----
     if(!friendAppear){
       // switch image between player0&1
       if(frame % 10 == 0){
         roadSpeed -= speed;
         speed = runningSpeed;
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
          
       // Player Status change according to his health
       if(health <= 6 && health > 3){
         indexStatus = 1;
         runningSpeed = 30;
       }
            
       if(health<=3 && health>=1){
         indexStatus = 2;
         runningSpeed = 25;
       } 
          
       // Player image
       image(playerImage[indexStatus][indexRunPose], x, y);
     }
        
     // ----- IF FRIEND HELPING -----
     if(friendAppear){
       if(helpTimer > 0){
         // Speed increase
         speed = motorSpeed;
         roadSpeed -= speed;
            
         // Player image
         image(motor1, x, y -20, ROAD_SIZE, 120);
         
         helpTimer --;
       }
     }
   }
      
   if(upState && hurtTimer == 0 && sellTimer == 0){
     if(y == 180){
       y = 180;
     }else{
       y -= h;
     }
     upState = false;
   }
      
   if(downState && hurtTimer == 0 && sellTimer == 0){
     if(y == height - h){
       y = height - h;
     }else{
       y += h;
     }
     downState = false;
   }
      
      
   if(!rightState && !upState && !downState && hurtTimer == 0 && helpTimer == 0 && endingTimer == 0){
     idleAppear = true;
   }
      
   if(idleAppear == true){
     image(playerIdle[indexStatus], x, y);
   }
    
   // ---------- PLAYER HURT ----------
   // println(crashAppear);
   if(crashAppear == true){
      
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
   //println(hurtTimer);
   
   // ---------- FRIEND HELPING ----------
   if(friendAppear == true){
     
     if(helpTimer > 0){
       // Player image
       image(motor1, x, y -20, ROAD_SIZE, 120);
     }
     if(helpTimer == 0){
       friendAppear = false;
       speed = runningSpeed;
     }
   }
   // println(helpTimer);
   
   // ---------- SALESMAN INTERRUPT ----------
   if(sellTimer > 0){
     
     // Player is not allowed to make movement
     rightState = false;
     upState = false;
     downState = false;
     
     // Talking
     image(talk, x + 20, y - 50);
     image(salesman, x + ROAD_SIZE, y);
     sellTimer --;
   }
   if(sellTimer == 0){
     
   }
   // println(sellTimer);
   
   // ---------- ENDING RUN ----------
   if(endingTimer > 0){
     // Player is not allowed to make movement
     idleAppear = false;
     rightState = false;
     upState = false;
     downState = false;
     
     // Automatically moving to right part
     x += 2;
     
     // switch image between player0&1
     if(frame % 10 == 0){
       roadSpeed -= speed;
       speed = runningSpeed;
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
         
     // Player Status change according to his health
     if(health <= 6 && health > 3){
       indexStatus = 1;
     }
            
     if(health<=3 && health>=1){
       indexStatus = 2;
     } 
          
     // Player image
     image(playerImage[indexStatus][indexRunPose], x, y);
     
     endingTimer--;
   }
   // println(endingTimer);
   
   
   frame ++;
  }
  

  
  void hurt(){
    // PLAYER WILL CRASH TO THE GROUND
    // PlayerHealth decrease will be written in their own class.
    
    // If there isn't friend helping, do the crush scene.
    if(!friendAppear){
      idleAppear = false;
      crashAppear = true;
      
      // Set the hurtTimer and start to count down
      hurtTimer = hurtDuration;
      
      crash.trigger();
    }
  }
  
  void salesInterrupt(){
    // Set the sellTimer and start to count down
    sellTimer = sellDuration;
  }

  void helpByFriend(){
    idleAppear = false;
    crashAppear = false;
    friendAppear = true;
    
    // Set the helpTimer and start to count down
    helpTimer = helpDuration;
  }
  
  void touchLine(){
    // Set the endingTimer and start to count down
    endingTimer = endingDuration;
  }
  
  Player(){
    x = PLAYER_INIT_X;
    y = PLAYER_INIT_Y;
    runningSpeed = 40;
    indexStatus = 0;
    indexRunPose = 0;
    health = 10;
    frame = 0;
    endingRun = false;
    endingTimer = 0;
  }
}
