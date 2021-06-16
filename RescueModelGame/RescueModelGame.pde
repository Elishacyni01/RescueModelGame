PImage thsr0,thsr1,thsr2,thsr3;
PImage road0, road1, road2;
PImage hand, salesman, motor, life, lifeHalf, sky, rock, crossroad;
PImage gamestart, gamerun1, gamerun2, gamewin, gamelosetime, gamelosebroken;
PImage restartHovered, restartNormal, startHovered, startNormal;

PImage [][] playerImage;
PImage playerCrash0, playerIdle;
PFont font;

final int GAME_START = 0, GAME_RUN1 = 1, GAME_RUN2 = 2, GAME_WIN = 3, GAME_LOSE_TIME = 4, GAME_LOSE_BROKEN = 5;
int gameState = 2;

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

// Declare an array of x position
int[] xpos = new int[2];
int[] ypos = new int[2];

void setup() {
  size(640, 480, P2D);
  
  hand = loadImage("img/hand.png");
  rock = loadImage("img/rock.png");
  salesman = loadImage("img/salesman.png");
  motor = loadImage("img/motor.jpg");
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
  road0 = loadImage("img/road0.png");
  road1 = loadImage("img/road1.png");
  road2 = loadImage("img/road2.png");
  life = loadImage("img/life.png");
  lifeHalf = loadImage("img/lifeHalf.png");
  crossroad = loadImage("img/crossroad.png");
  
  // Load PImage[][] player
  playerImage = new PImage[PLAYER_STATUS][PLAYER_RUN_POSE];
  for(int i = 0; i < playerImage.length; i++){
    for(int j = 0; j < playerImage[i].length; j++){
      playerImage[i][j] = loadImage("img/players/player" + i + "_" + j + ".png");
    }
  }
  
  // Player loadImage
  playerCrash0 = loadImage("img/players/playerCrash0.png");
  playerIdle = loadImage("img/players/playerIdle.png");
  
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
  
  // FOR GAMERUN1
  // Initialize Barwidth & THSR
  barWidth = 60;
  
  // Initialize all elements of each array to zero.
  for (int i = 0; i < xpos.length; i ++ ) {
    xpos[i] = 0; 
    ypos[i] = 0;
  }
  
  // FOR GAMERUN2
  // Initialize Player
  player = new Player();
  gameTimer = GAME_INIT_TIMER;
  
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
          gameState = GAME_RUN1;
          mousePressed = false;
        }
  
      }else{
  
        image(startNormal, START_BUTTON_X, START_BUTTON_Y);
  
      }
    
    break;
        
    case GAME_RUN1:  // Rubbing model
    
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
    
      // Background
      image(sky, 0, 0);
      
      // Road
      for(int i=0; i < 64; i++){
        image(road0, roadSpeed + i * ROAD_SIZE, 180);
        image(road1, roadSpeed + i * ROAD_SIZE, 280);
        image(road2, roadSpeed + i * ROAD_SIZE, 380);
      }
      
      //ending line
      noStroke();
      fill(#ffffff);
      rect(roadSpeed +endingLine, 180, 20, 300);
      //player.touchLine();
     
      // Crossroad
      for(int i=0; i < 3; i++){
        image(crossroad, roadSpeed + (10 + 20*i) * ROAD_SIZE, 180);
      }
      
      // Life
      for(int i = 0; i < player.health; i++){
        int f = floor((i+1)/2) - 1; // full heart num
        int h = floor(i/2); // half heart num
        image(lifeHalf, 15 + h*70, 15, 50, 40);
        image(life, 15 + f*70, 15, 50, 40);
      }
      println(player.health);
      
      // Player
      player.update();
      
      // Rock
      for(int i = 0; i < rocks.length; i++){
        if(rocks[i].isAlive){
          rocks[i].display();
          rocks[i].checkCollision(player);
        }else{
          // player.hurt();
        }
      }
      
      // Salesman
      for(int i=0; i < sales.length; i++){
        if(sales[i].isAlive){
          sales[i].display();
          sales[i].checkCollision(player);
        }
      }

      // Timer
      gameTimer --;
      if(gameTimer <= 0) gameState = GAME_LOSE_TIME;
      drawTimerUI();  
    
    break;

    case GAME_WIN: 
      image(gamewin, 0, 0);
      restart();
      initGame();
    break;
        
    case GAME_LOSE_TIME: // time over
      image(gamelosetime, 0, 0);
      restart();
      initGame();
    break;
        
    case GAME_LOSE_BROKEN: //model broken
      image(gamelosebroken, 0, 0);
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

//mm:ss format
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
  String mm=nf(floor(floor(frames/60)/60),2);
  String ss=nf(floor(frames/60)%60,2);
  return mm+":"+ss;  
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
