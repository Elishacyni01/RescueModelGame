PImage []thsr;
PImage hand, stone, salesman, motor;
PImage gamestart, gamerun1, gamerun2, gamewin, gamelosetime, gamelosebroken;
// PImage [][] player;
// PImage [] playerIdle, playerMotor, playerCrash;

PImage player, playerCrash;


final int GAME_START = 0, GAME_RUN1 = 1, GAME_RUN2 = 2, GAME_WIN = 3, GAME_LOSE_TIME = 4, GAME_LOSE_BROKEN = 5;
int gameState = 0;

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
  gamerun2 = loadImage("img/gamerun2.jpg");
  gamewin = loadImage("img/gamewin.jpg");
  gamelosetime = loadImage("img/gamelosetime.jpg");
  gamelosebroken = loadImage("img/gamelosebroken.jpg");
  
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
}

void draw() {
    switch (gameState) {

    case GAME_START:

        break;
        
    case GAME_RUN1://Rubbing model
    
        break;

    case GAME_RUN2://start run

        break;

    case GAME_WIN: 
        
        break;
        
    case GAME_LOSE_TIME: //time over
        
        break;
        
    case GAME_LOSE_BROKEN: //model broken
        
        break;
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
