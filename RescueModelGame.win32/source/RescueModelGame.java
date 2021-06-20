import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class RescueModelGame extends PApplet {

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

public void setup() {
  
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

public void initGame(){
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


public boolean isExist(float positionA, float positionB, float positionC){
  if (positionA == positionB && positionB == positionC){
    return true;
  }
  return false;
}

public void draw() {
  
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
      fill(0xffFFFF00);
      strokeWeight(3);
      stroke(0xff4d3900);
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
        image(house1, roadSpeed + (20 * i + 1.8f) * ROAD_SIZE, 100, 1.7f * ROAD_SIZE, 0.8f * ROAD_SIZE);
        image(house0, roadSpeed + (20 * i + 3.5f) * ROAD_SIZE, 80, 1.7f * ROAD_SIZE, ROAD_SIZE);
        image(house1, roadSpeed + (20 * i + 6.8f) * ROAD_SIZE, 100, 1.7f * ROAD_SIZE, 0.8f * ROAD_SIZE);
        image(tree, roadSpeed + 20 * i * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 5) * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 8) * ROAD_SIZE, 80, 200, ROAD_SIZE);
      }
      for(int i=0; i < 3; i++){
        image(house0, roadSpeed + (20 * i + 16) * ROAD_SIZE, 80, 1.7f * ROAD_SIZE, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 14) * ROAD_SIZE, 80, 200, ROAD_SIZE);
        image(tree, roadSpeed + (20 * i + 18) * ROAD_SIZE, 80, 200, ROAD_SIZE);
      }
      image(tree, roadSpeed + 60 * ROAD_SIZE, 80, 200, ROAD_SIZE);
      
        
      //ending line
      noStroke();
      fill(0xffffffff);
      rect(roadSpeed + endingLine, 180, 20, 300);
      
      // School
      for(int i=0; i<4; i++){
        for(int j=0; j<3; j++){
          image(endroad, roadSpeed + (62.5f+i) * ROAD_SIZE, 180 + j * ROAD_SIZE);
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

public void restart(){
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

public boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh){
  return  ax + aw > bx &&    // a right edge past b left
        ax < bx + bw &&    // a left edge past b right
        ay + ah > by &&    // a top edge past b bottom
        ay < by + bh;
}

public void drawRemovingUI(){
  noStroke();
  fill(0xff4d1f00);
  rect(30, 100, 310, 3);
  
  float depthString = roadSpeed/-30;
  float RemovingDot = (depthString*1.5f)+30;
  
  image(smallplayer,RemovingDot, 100);
  image(school,310, 70,40,50);
  if(rightState){
    RemovingDot++;
  }
}

// mm:ss format
public void drawTimerUI(){
  textSize(56);
  String timeString = convertFramesToTimeString(gameTimer);
  textAlign(RIGHT, TOP);
  
  // Time Text Shadow Effect
  fill(0, 60);
  text(timeString, 623, 3);
  
  // Actual Time Text
  int timeTextColor = getTimeTextColor(gameTimer);
  fill(timeTextColor);
  text(timeString, 620, 0);
}

public void addTime(float seconds){
  gameTimer += seconds * 4 * 15;          
}

public String convertFramesToTimeString(int frames){
  String mm = nf(floor(floor(frames/60)/60),2);
  String ss = nf(floor(frames/60)%60,2);
  return mm + ":" + ss;
}

public int getTimeTextColor(int frames){  
  int min = floor(frames / (60 * 60));
  int sec = (floor(frames / 60)) % 60;
  
  if(min == 1){return 0xff4d1f00;
  }else if(min == 0 && sec <= 59 && sec >= 30){return 0xff4d1f00;
  }else if(min == 0 && sec <= 29 && sec >= 10){return 0xff8b4513;
  }else {return 0xffffa07a;} 
  
}

  
public void keyPressed(){
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


public void keyReleased(){
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
class Car{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  float speed = 2;
  
  public void display(){
    image(car, x + roadSpeed, y, w, h);
  }
  
  public void update(){
    y += speed;
    if(y >= height) y = -h;
  }
  
  public boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){
      
      // player.health -= 3;
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }
  
  
  // Contructor
  Car(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
class Motor{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  public void display(){
    image(motor0, x + roadSpeed, y, w, h);
  }
  
  public boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }
  
  
  // Contructor
  Motor(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
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
  
  
  public void update(){
    
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
  

  
  public void hurt(){
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
  
  public void salesInterrupt(){
    // Set the sellTimer and start to count down
    sellTimer = sellDuration;
    
    // sales sound
    woman.trigger();
  }

  public void helpByFriend(){
    idleAppear = false;
    crashAppear = false;
    friendAppear = true;
    
    // Set the helpTimer and start to count down
    helpTimer = helpDuration;
    
    // motor sound
    motor.trigger();
  }
  
  public void touchLine(){
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
class Rock{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  public void display(){
    
    image(rock, x + roadSpeed, y, w, h);
  }
  
  public boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h)){
      
      
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }

  // Contructor
  Rock(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
    
    
  }
}
class Salesman{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  
  public void display(){
    image(salesman, x + roadSpeed, y, w, h);
  }
    
  
  public boolean checkCollision(Player player){

    if(isHit(x + roadSpeed, y, w, h, player.x, player.y, player.w, player.h) && isAlive){
      
      isAlive = false;
      
      return true;
    }else{
      return false;
    }
  }
  
  // Contructor
  Salesman(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
/* @pjs preload=
"img/hand.png,
img/rock.png,
img/salesman.png,
img/motor0.png,
img/motor1.png,
img/gamestart.jpg,
img/gamerun1.jpg,
img/gamewin.jpg,
img/gamelosetime.jpg,
img/gamelosebroken.jpg,
img/restartHovered.png,
img/restartNormal.png,
img/startHovered.png,
img/startNormal.png,
img/sky.jpg,
img/talk.png,
img/road0.png,
img/road1.png,
img/road2.png,
img/road3.png,
img/road4.png,
img/road5.png,
img/life.png,
img/lifeHalf.png,
img/crossroad.png,
img/car.png,
img/smallplayer.png,
img/school.png,
img/house0.png,
img/house1.png,
img/tree.png,
img/end.png,
img/end1.png,
img/endroad.jpg,
img/players/player0_0.png,
img/players/player0_1.png,
img/players/player1_0.png,
img/players/player1_1.png,
img/players/player2_0.png,
img/players/player2_1.png,
img/players/playerCrash0.png,
img/players/playerCrash1.png,
img/players/playerIdle0.png,
img/players/playerIdle1.png,
img/players/playerIdle2.png,
img/thsr0.png,
img/thsr1.png,
img/thsr2.png,
img/thsr3.png";
font="font/font.ttf"; */
  public void settings() {  size(640, 480, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RescueModelGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
