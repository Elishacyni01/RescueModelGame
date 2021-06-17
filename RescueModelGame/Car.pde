class Car{
  float x, y;
  float w = ROAD_SIZE, h = ROAD_SIZE;
  boolean isAlive;
  float speed = 1;
  
  void display(){
    image(car0, x + roadSpeed, y, w, h);
    image(car1, x + 100 + roadSpeed, y, w, h);
    image(car2, x + 200 + roadSpeed, y, w, h);
  }
  
  void update(){
    y += speed;
    if(y >= height) y = -h;
  }
  
  void checkCollision(Player player){
    
  }
  
  // Contructor
  Car(float x, float y){
    isAlive = true;
    this.x = x;
    this.y = y;
  }
}
