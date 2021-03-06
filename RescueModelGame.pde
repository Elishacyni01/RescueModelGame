PImage thsr0,thsr1,thsr2,thsr3;
PImage road0, road1, road2, road3, road4, road5;
PImage hand, salesman, motor0, motor1, life, lifeHalf, sky, rock, crossroad, car, talk;
PImage gamestart, gamerun1, gamerun2, gamewin, gamelosetime, gamelosebroken;
PImage smallplayer, school, house0, house1, tree, end, end1, endroad;
PImage restartHovered, restartNormal, startHovered, startNormal;

PImage [][] playerImage;
PImage playerCrash0;
PImage [] playerIdle;
PFont font;

final int GAME_START = 0, GAME_RUN1 = 1, GAME_RUN2 = 2, GAME_WIN = 3, GAME_LOSE_TIME = 4, GAME_LOSE_BROKEN = 5;
int gameState = 0;

final int START_BUTTON_WIDTH = 200;
final int START_BUTTON_HEIGHT = 100;
final int START_BUTTON_X = 350;
final int START_BUTTON_Y = 300;
final int RESTART_BUTTON_X = 200;
final int RESTART_BUTTON_Y = 350;

final int PLAYER_RUN_POSE = 2;
final int PLAYER_STATUS = 3;
int playerRow;
int endingLine = 6000;

final int BAR_HEIGHT = 60;
int barWidth = 60;

float roadSpeed = 0;
final int ROAD_SIZE = 100;

final int GAME_INIT_TIMER = 3600;
int gameTimer = GAME_INIT_TIMER;
final float CLOCK_BONUS_SECONDS = 15f;

boolean rightState = false;
boolean upState = false;
boolean downState = false;

Player player;
Rock[] rocks;
Salesman[] sales;
Motor[] motors;
Car[] cars;

// Declare an array of x position
int[] xpos = new int[2];
int[] ypos = new int[2];

import ddf.minim.*;

Minim minim;
AudioSample buttom;
AudioSample rub;
AudioSample crash;
AudioSample motor;
AudioSample woman;
AudioPlayer yeah;
AudioPlayer lose;
AudioPlayer timeup;
AudioPlayer backmusic;

void setup() {
  size(640, 480, P2D);
  frameRate(60);
  minim = new Minim(this);
  
  // load mp3 from the data folder
  buttom = minim.loadSample( "buttom01.mp3", 128);
  rub = minim.loadSample( "rub.mp3", 128);
  crash = minim.loadSample( "crash.mp3", 128);
  motor = minim.loadSample( "motor.mp3", 256);
  woman = minim.loadSample( "woman.mp3", 256);
  yeah = minim.loadFile( "yeah.mp3", 256);
  timeup = minim.loadFile( "timeup.mp3", 256);
  backmusic = minim.loadFile( "backmusic.mp3", 256);
  lose = minim.loadFile( "lose.mp3", 256);
  
  hand = loadImage("img/hand.png");
  rock = loadImage("img/rock.png");
  salesman = loadImage("img/salesman.png");
  motor0 = loadImage("img/motor0.png");
  motor1 = loadImage("img/motor1.png");
  gamestart = loadImage("img/gamestart.jpg");
  gamerun1 = loadImage("img/gamerun1.jpg");
  gamewin = loadImage("img/gamewin.jpg");
  gamelosetime = loadImage("img/gamelosetime.jpg");
  gamelosebroken = loadImage("img/gamelosebroken.jpg");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  sky = loadImage("img/sky.jpg");
  talk = loadImage("img/talk.png");
  road0 = loadImage("img/road0.png");
  road1 = loadImage("img/road1.png");
  road2 = loadImage("img/road2.png");
  road3 = loadImage("img/road3.png");
  road4 = loadImage("img/road4.png");
  road5 = loadImage("img/road5.png");
  life = loadImage("img/life.png");
  lifeHalf = loadImage("img/lifeHalf.png");
  crossroad = loadImage("img/crossroad.png");
  car = loadImage("img/car.png");
  smallplayer = loadImage("img/smallplayer.png");
  school = loadImage("img/school.png");
  house0 = loadImage("img/house0.png");
  house1 = loadImage("img/house1.png");
  tree = loadImage("img/tree.png");
  end = loadImage("img/end.png");
  end1 = loadImage("img/end1.png");
  endroad = loadImage("img/endroad.jpg");
  
  // Load PImage[][] player
  playerImage = new PImage[PLAYER_STATUS][PLAYER_RUN_POSE];
  for(int i = 0; i < playerImage.length; i++){
    for(int j = 0; j < playerImage[i].length; j++){
      playerImage[i][j] = loadImage("img/players/player" + i + "_" + j + ".png");
    }
  }
  
  // Load PImage[] playerIdle
  playerIdle = new PImage[PLAYER_STATUS];
  for(int i = 0; i < playerIdle.length; i++){
    playerIdle[i] = loadImage("img/players/playerIdle" + i + ".png");
  }
  
  // Player loadImage
  playerCrash0 = loadImage("img/players/playerCrash0.png");
  
  // THSR loadImage
  thsr0 = loadImage("img/thsr0.png");
  thsr1 = loadImage("img/thsr1.png");
  thsr2 = loadImage("img/thsr2.png");
  thsr3 = loadImage("img/thsr3.png");
  
  font = createFont("font/font.ttf", 56);
  textFont(font);
  
  initGame();
}

void initGame(){
  // Initialize Game
  
  // ---------- FOR GAMERUN1 ----------
  // Initialize Barwidth & THSR
  barWidth = 60;
  
  // Initialize all elements of each array to zero.
  for (int i = 0; i < xpos.length; i ++ ) {
    xpos[i] = 0; 
    ypos[i] = 0;
  }
  
  // ---------- FOR GAMERUN2 ----------
  // Initialize Player
  player = new Player();
  
  // Initialize Gametimer & roadSpeed
  gameTimer = GAME_INIT_TIMER;
  roadSpeed = 0;
  
  // Initialize Rocks and their positions
  rocks = new Rock[19];
  
  for(int i=0; i < rocks.length; i++){
    float newX = (3*i + 4) * ROAD_SIZE;
    float newY = 180 + floor(random(3)) * ROAD_SIZE;
    
    rocks[i] = new Rock(newX, newY);
    
    // NO ROCKS ALLOWED ON CROSSROAD
    if(newX == 10 * ROAD_SIZE || newX == 13 * ROAD_SIZE
       || newX == 31 * ROAD_SIZE || newX == 52 * ROAD_SIZE){
         
      rocks[i].isAlive = false;
      
    }
  }
  
  // Initialize Salesmen and their positions
  sales = new Salesman[8];
  
  for(int i=0; i < sales.length; i++){
    float newX = (6*i + 9) * ROAD_SIZE;
    float newY = 180 + floor(random(3)) * ROAD_SIZE;
    
    sales[i] = new Salesman(newX, newY);
    
    // NO SALESMAN ALLOWED ON CROSSROAD
    if(newX == 33 * ROAD_SIZE || newX == 51 * ROAD_SIZE){
      
      sales[i].isAlive = false;
      
    }
  }

  // Initialize Motor and their positions
  motors = new Motor[2];
  
  for(int i=0; i < motors.length; i++){
    float newX = (24*i + 18) * ROAD_SIZE;
    float newY = 180 + floor(random(3)) * ROAD_SIZE;
    
    motors[i] = new Motor(newX, newY);
  }

  // Initialize Car and their positions
  cars = new Car[6];
    
  for(int i=0; i < cars.length; i++){
    
    float newX, newY;
    newX = 0;
    newY = 0;
    
    if(i % 2 == 0){
      newX = (10 * i + 11) * ROAD_SIZE;
      newY = -100;
    }else if(i % 2 == 1){
      newX = (10 * (i-1) + 12) * ROAD_SIZE;
      newY = 290;
    }
      
    cars[i] = new Car(newX, newY);
  }
}


boolean isExist(float positionA, float positionB, float positionC){
  if (positionA == positionB && positionB == positionC){
    return true;
  }
  return false;
}

void draw() {
  
  switch (gameState) {

    case GAME_START:
      image(gamestart, 0, 0);
      
      if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
        && START_BUTTON_X < mouseX
        && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
        && START_BUTTON_Y < mouseY) {
  
        image(startHovered, START_BUTTON_X, START_BUTTON_Y);
        if(mousePressed){
          buttom.trigger();
          gameState = GAME_RUN1;
          mousePressed = false;
        }
  
      }else{
  
        image(startNormal, START_BUTTON_X, START_BUTTON_Y);
  
      }
    
    break;
        
    case GAME_RUN1:  // Rubbing model
    
      backmusic.play();
    
      image(gamerun1, 0, 0);
      
      // THSR
      if(barWidth <= 200){
        image(thsr0, 100, 150);
      }else if(barWidth <= 450){
        image(thsr1, 100, 150);
      }else if(barWidth <= 600){
        image(thsr2, 100, 150);
      }else if(barWidth <= 640){
        image(thsr3, 100, 150);
      }
      
      // Restrict hand area
      // noCursor();
      if(mouseX < 170){
        mouseX = 170;
      }else if(mouseX > 520){
        mouseX= 520;
      }
      if(mouseY < 220){
        mouseY = 220;
      }else if(mouseY > 420){
        mouseY= 420;
      }
      
      image(hand, mouseX - 120 , mouseY - 120);
      
      // ACTION DETECT
      
      // Shift array values
      for (int i = 0; i < xpos.length-1; i ++ ) {
        // Shift all elements down one spot. 
        // xpos[0] = xpos[1], xpos[1] = xpos[2], and so on. Stop at the second to last element.
        xpos[i] = xpos[i+1];
        ypos[i] = ypos[i+1];
      }
  
      // New location
      xpos[xpos.length-1] = mouseX; // Update the last spot in the array with the mouse location.
      ypos[ypos.length-1] = mouseY;
      
      // If distance over 50, bar increase
      for (int i = 0; i < xpos.length-1; i ++ ) {
        float d = dist(xpos[i], ypos[i], xpos[i+1], ypos[i+1]);
        if(d > 50){
          barWidth += 3;
        }
      }
      
      // Bar
      fill(#FFFF00);
      strokeWeight(3);
      stroke(#4d3900);
      rect(5, 420, barWidth, BAR_HEIGHT, 7);
      
      // Bar Progress
      if(barWidth > width - 10){
        gameState = GAME_RUN2;
      }
      
      // Timer
      gameTimer --;
      if(gameTimer <= 0) gameState = GAME_LOSE_TIME;
      drawTimerUI();
    
    break;
    
    case GAME_RUN2: // Start run
    
     backmusic.play();
    
      // Background
      image(sky, 0, 0);
      
      // Road
      for(int i=0; i < 67; i++){
        image(road0, roadSpeed + i * ROAD_SIZE, 180);
        image(road1, roadSpeed + i * ROAD_SIZE, 280);
        image(road2, roadSpeed + i * ROAD_SIZE, 380);
      }
      
      // Tree & House
      for(int i=0; i < 3; i++){
        image(house1, roadSpeed + (20 * i + 1.8) * ROAD_SIZE, 100, 1.7 * ROAD_SIZE, 0.8 * ROAD_SIZE);
        image(house0, roadSpeed + (20 * i + 3.5) * ROAD_SIZE, 80, 1.7 * ROAD_SIZE, ROAD_SIZE);
        image(house1, roadSpeed + (20 * i + 6.8) * ROAD_SIZE, 100, 1.7 * ROAD_SIZE, 0.8 * ROAD_SIZE);
        image(tree, roadSpeed + 20 * i * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 5) * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 8) * ROAD_SIZE, 80, 200, ROAD_SIZE);
      }
      for(int i=0; i < 3; i++){
        image(house0, roadSpeed + (20 * i + 16) * ROAD_SIZE, 80, 1.7 * ROAD_SIZE, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 14) * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 18) * ROAD_SIZE, 80, 200, ROAD_SIZE);
      }
      image(tree, roadSpeed + 60 * ROAD_SIZE, 80, 200, ROAD_SIZE);
      
        
      //ending line
      noStroke();
      fill(#ffffff);
      rect(roadSpeed + endingLine, 180, 20, 300);
      
      // School
      for(int i=0; i<4; i++){
        for(int j=0; j<3; j++){
          image(endroad, roadSpeed + (62.5+i) * ROAD_SIZE, 180 + j * ROAD_SIZE);
        }
      }
      image(end1, endingLine + roadSpeed + 3 * ROAD_SIZE - 50, 0, 400, 250);
      
      // Crossroad
      for(int i=0; i < 3; i++){
        image(crossroad, roadSpeed + (10 + 20*i) * ROAD_SIZE, 180);
      }
      
      for(int i=0; i < 3; i++){
        for(int j=0; j < 2; j++){
          image(road3, roadSpeed + (10 + 20*i) * ROAD_SIZE, -20 + j * ROAD_SIZE);
          image(road4, roadSpeed + (11 + 20*i) * ROAD_SIZE, -20 + j * ROAD_SIZE);
          image(road4, roadSpeed + (12 + 20*i) * ROAD_SIZE, -20 + j * ROAD_SIZE);
          image(road5, roadSpeed + (13 + 20*i) * ROAD_SIZE, -20 + j * ROAD_SIZE);
        }
      }
      
      // Life
      for(int i = 0; i < player.health; i++){
        int f = floor((i+1)/2) - 1; // full heart num
        int h = floor(i/2); // half heart num
        image(lifeHalf, 15 + h*70, 15, 50, 40);
        image(life, 15 + f*70, 15, 50, 40);
      }
      
      
      // Player
      player.update();
      
      // Rock
      for(int i = 0; i < rocks.length; i++){
        if(rocks[i].isAlive){
          
          if(rocks[i].checkCollision(player)){
            
            if(!player.friendAppear){
              
              player.health -= 2;
            }
            player.hurt();
            
          }else{
            
            rocks[i].display();
          }
        }
      }
      
      // Salesman
      for(int i=0; i < sales.length; i++){
        if(sales[i].isAlive){
          sales[i].display();
        }
          
        if(sales[i].checkCollision(player)){
          player.salesInterrupt();
          
        } 
      }
      
      // Motor
      for(int i=0; i < motors.length; i++){
        if(motors[i].isAlive){
          
          if(motors[i].checkCollision(player)){
            
            player.helpByFriend();
            
          }else{
            
            motors[i].display();
          }
        }
      }
      
      // Car
      for(int i=0; i < cars.length; i++){
        if(cars[i].isAlive){
          
          if(cars[i].checkCollision(player)){
            
            if(!player.friendAppear){
              
              player.health -= 3;
            }
            
            player.hurt();
            
          }else{
            
            cars[i].display();
            cars[i].update();
          }
        }
      }

      // removing
      drawRemovingUI();
      
      // Timer
      gameTimer --;
      if(gameTimer <= 0) gameState = GAME_LOSE_TIME;
      drawTimerUI();  
      
      // Health
      if(player.health <= 0){
        lose.play();
        gameState = GAME_LOSE_BROKEN;
        
      }
      
     // ENDING LINE
     //println(roadSpeed);
     if(roadSpeed <= - 6000){
       
       roadSpeed = -6000;
       player.speed = 0;
       
       // Automatically run to school
       player.touchLine();
     }
     
     if(player.x >= 300){
       yeah.play();
       gameState = GAME_WIN;
     }
     
    break;

    case GAME_WIN: 
      image(gamewin, 0, 0, width, height);
      
      restart();
      initGame();
    break;
        
    case GAME_LOSE_TIME: // time over
      image(gamelosetime, 0, 0);
      timeup.play();
      restart();
      initGame();
    break;
        
    case GAME_LOSE_BROKEN: //model broken
      image(gamelosebroken, 0, 0);
      backmusic.pause();
      restart();
      initGame();
    break;
  }
}

void restart(){
  if(RESTART_BUTTON_X + START_BUTTON_WIDTH > mouseX
      && RESTART_BUTTON_X < mouseX
      && RESTART_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
      && RESTART_BUTTON_Y < mouseY) {

      image(restartHovered, RESTART_BUTTON_X, RESTART_BUTTON_Y);
      if(mousePressed){
        buttom.trigger();
        gameState = GAME_START;
        mousePressed = false;
      }

    }else{

      image(restartNormal, RESTART_BUTTON_X, RESTART_BUTTON_Y);

    }
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh){
  return  ax + aw > bx &&    // a right edge past b left
        ax < bx + bw &&    // a left edge past b right
        ay + ah > by &&    // a top edge past b bottom
        ay < by + bh;
}

void drawRemovingUI(){
  noStroke();
  fill(#4d1f00);
  rect(30, 100, 310, 3);
  
  float depthString = roadSpeed/-30;
  float RemovingDot = (depthString*1.5)+30;
  
  image(smallplayer,RemovingDot, 100);
  image(school,310, 70,40,50);
  if(rightState){
    RemovingDot++;
  }
}

// mm:ss format
void drawTimerUI(){
  textSize(56);
  String timeString = convertFramesToTimeString(gameTimer);
  textAlign(RIGHT, TOP);
  
  // Time Text Shadow Effect
  fill(0, 60);
  text(timeString, 623, 3);
  
  // Actual Time Text
  color timeTextColor = getTimeTextColor(gameTimer);
  fill(timeTextColor);
  text(timeString, 620, 0);
}

void addTime(float seconds){
  gameTimer += seconds * 4 * 15;          
}

String convertFramesToTimeString(int frames){
  String mm = nf(floor(floor(frames/60)/60),2);
  String ss = nf(floor(frames/60)%60,2);
  return mm + ":" + ss;
}

color getTimeTextColor(int frames){  
  int min = floor(frames / (60 * 60));
  int sec = (floor(frames / 60)) % 60;
  
  if(min == 1){return #4d1f00;
  }else if(min == 0 && sec <= 59 && sec >= 30){return #4d1f00;
  }else if(min == 0 && sec <= 29 && sec >= 10){return #8b4513;
  }else {return #ffa07a;} 
  
}

  
void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case RIGHT:
      rightState = true;
      break;
      case UP:
      upState = true;
      break;
      case DOWN:
      downState = true;
      break;
    }
  }else{
    if(key=='t'){
      gameTimer -= 180;
    }
    if(key=='k'){
      gameTimer += 180;
    }
    if(key=='r'){
      player.hurt();
    }
  }
}


void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case RIGHT:
      rightState = false;
      break;
      case UP:
      upState = false;
      break;
      case DOWN:
      downState = false;
      break;
    }
  }
}
