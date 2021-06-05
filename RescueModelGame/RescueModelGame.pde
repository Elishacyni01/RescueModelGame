PImage []thsr;
PImage thsr0;
PImage hand, stone, salesman, motor;
PImage gamestart, gamerun1, gamerun2, gamewin, gamelosetime, gamelosebroken;
PImage restartHovered,restartNormal,startHovered,startNormal,row,sky;
// PImage [][] player;
// PImage [] playerIdle, playerMotor, playerCrash;

PImage player, playerCrash;


final int GAME_START = 0, GAME_RUN1 = 1, GAME_RUN2 = 2, GAME_WIN = 3, GAME_LOSE_TIME = 4, GAME_LOSE_BROKEN = 5;
int gameState = 0;

final int START_BUTTON_WIDTH = 200;
final int START_BUTTON_HEIGHT = 100;
final int START_BUTTON_X = 350;
final int START_BUTTON_Y = 300;
final int RESTART_BUTTON_X = 200;
final int RESTART_BUTTON_Y = 350;

float playerX, playerY;
final int PLAYER_RUN_POSE = 2;
final int PLAYER_DAMAGE_CONDS = 3;


void setup() {
  size(640, 480, P2D);
  
  hand = loadImage("img/hand.jpg");
  stone = loadImage("img/stone.jpg");
  salesman = loadImage("img/salesman.jpg");
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
  row = loadImage("img/row.jpg");
  sky = loadImage("img/sky.jpg");
  
  player = loadImage("img/player.jpg");

  /*
  // Load PImage[][] player
  player = new PImage[PLAYER_RUN_POSE][PLAYER_DAMAGE_CONDS];
  for(int i = 0; i < player.length; i++){
    for(int j = 0; j < player[i].length; j++){
      player[i][j] = loadImage("img/players/player" + i + "/player" + i + "_" + j + ".jpg");
    }
  }
  */
  
  thsr0 = loadImage("img/thsr0.jpg");
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
        
    case GAME_RUN1: // Rubbing model
      image(gamerun1, 0, 0);
      image(thsr0, 100, 150);
      
      if(mouseX < 50){
        mouseX = 50;
      }else if(mouseX > 400){
        mouseX= 400;
      }
      if(mouseY < 100){
        mouseY = 100;
      }else if(mouseY > 300){
        mouseY= 300;
      }
      
      image(hand, mouseX, mouseY);
    break;

    case GAME_RUN2: // start run
      image(sky, 0, 0);
      image(row, 0, 0);
    
    break;

    case GAME_WIN: 
      image(gamewin, 0, 0);
      restart();
    break;
        
    case GAME_LOSE_TIME: //time over
      image(gamelosetime, 0, 0);
      restart();
    break;
        
    case GAME_LOSE_BROKEN: //model broken
      image(gamelosebroken, 0, 0);
      restart();
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

void keyPressed(){
  }