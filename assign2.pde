final int game_start = 0;
final int game_run = 1;
final int game_over = -1;

PImage bg1, bg2, gameStart;
PImage start_buttom, start_bg;
PImage end_buttom, end_bg;
PImage enemy;
PImage treasure;
PImage fighter;
PImage hp;

int gameState;
int bg_position1 = 0, bg_position2 = -641 ;
int fighter_position_x = 589, fighter_position_y = 214;
int enemy_position_x= 0, enemy_position_y;
int treasure_position_x, treasure_position_y;
int blood = 20, coefficient = 2, bloodWidth;

boolean upPressed = false, downPressed = false; 
boolean rightPressed = false, leftPressed = false; 

void setup () {
  size(640,480) ; 
  
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  start_buttom = loadImage("img/start1.png");
  start_bg = loadImage("img/start2.png");
  end_buttom = loadImage("img/end1.png");
  end_bg = loadImage("img/end2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  
  gameState = game_start;
}

void draw() {
  switch(gameState){
   case game_start:
     enemy_position_y = floor(random(419));
     fighter_position_x = 588;
     treasure_position_x = floor(random(110, 600));
     treasure_position_y = floor(random(440));
     image(start_bg, 0, 0);
     if(mouseX >= 210 && mouseX <= 430 && 
        mouseY >= 382 && mouseY <= 412){
          image(start_buttom, 0, 0);
          if(mousePressed)
            gameState = game_run;
            blood = 20;
        }
   break;
     
   case game_run:
     bg_position1 += 1;
     if(bg_position1 == 641){
       bg_position1 = -640;
     }
     image(bg1, bg_position1, 0);
     
     bg_position2 += 1 ;
     if(bg_position2 == 641){
       bg_position2 = -641;
     }
     image(bg2, bg_position2, 0);
         
     enemy_position_x += 5;
     enemy_position_x %= 640;
     enemy_speed();
     image(enemy, enemy_position_x, enemy_position_y);
  
     fighter_position_move_x();
     fighter_position_move_y();
     fighter_max_x();
     fighter_max_y();
     
     hit_enemy();
     image(fighter, fighter_position_x, fighter_position_y);
     
     fill(255, 0, 0);
     get_treasure();
     calculate_blood();
     rect(10, 5, bloodWidth, 20 );
     image(treasure, treasure_position_x, treasure_position_y);
     
     image(hp, 0 ,0);
     
     if(blood <= 0)
       gameState = game_over;
       break;
     
     case game_over:
       image(end_bg, 0, 0);
       if(mouseX >= 215 && mouseX <= 430 && 
          mouseY >= 315 && mouseY <= 344){
            image(end_buttom, 0, 0);
            if(mousePressed)
              gameState = game_run;
              blood=20;
     }
     break;  
  }
}

void keyPressed(){
 if (key == CODED){
  switch( keyCode ){
   case UP:
     upPressed = true;
     break; 
     
   case DOWN:
     downPressed = true;
     break;
     
   case LEFT:
     leftPressed = true;
     break;
     
   case RIGHT:
     rightPressed = true;
     break;
  }
 }
}

void keyReleased(){
 if (key == CODED){
  switch( keyCode ){
   case UP:
     upPressed = false;
     break; 
     
   case DOWN:
     downPressed = false;
     break;
     
   case LEFT:
     leftPressed = false;
     break;
     
   case RIGHT:
     rightPressed = false;
     break;
  }
 }
}

int fighter_position_move_x(){
  if(rightPressed) 
    fighter_position_x += 5;
  if(leftPressed)
    fighter_position_x -= 5;
  
   return fighter_position_x;
}

int fighter_position_move_y(){
  if(upPressed)
    fighter_position_y -= 5;
  if(downPressed)
    fighter_position_y += 5;
    
   return fighter_position_y;
}

int calculate_blood(){
  bloodWidth = blood * coefficient;
  
  return bloodWidth;
}

int fighter_max_x(){
  if(fighter_position_x >= 589)
    fighter_position_x = 589;
  if(fighter_position_x <= 0)
    fighter_position_x = 0;
  
  return fighter_position_x;
}


int fighter_max_y(){
  if(fighter_position_y >= 429)
    fighter_position_y = 429;
  if(fighter_position_y <= 0)
    fighter_position_y = 0;
  
  return fighter_position_y;
}


int get_treasure(){
  if(fighter_position_x >= treasure_position_x - 40 &&
     fighter_position_x <= treasure_position_x + 40 &&
     fighter_position_y >= treasure_position_y - 40 &&
     fighter_position_y <= treasure_position_y + 40){
       blood += 10;
       treasure_position_x = floor(random(100,600));
       treasure_position_y = floor(random(400));
     }
    if(blood >= 100)
      blood = 100;
      
  return blood;
}

int hit_enemy(){
  if(enemy_position_x >= fighter_position_x - 55 &&
     enemy_position_x <= fighter_position_x + 50 &&
     enemy_position_y >= fighter_position_y - 55 &&
     enemy_position_y <= fighter_position_y + 50 ){
     blood -= 20; 
     enemy_position_x = 0;
     enemy_position_y = floor(random(419));
     }
     
  return blood;
}

int enemy_speed(){
  enemy_position_y += (fighter_position_y - enemy_position_y)/25;
  
  return enemy_position_y;
}
