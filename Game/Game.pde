/**************************
*  THE KEEPERS            *
*  Author: Hammad Khalid  *
**************************/

static final int WIDTH = 1920;  // width of map
static final int HEIGHT = 1080;  // height of map

boolean running;  // Indicates whether the game is running

String winner;    // Player that has won the game

Player p1;  // Player 1
Player p2;  // Player 2

//Comp c1;    // Comp 1
static Block b1, b2, b3, b4, b5, b6, b7, b8;  // Caves

static final int BLOCK_OPENING = 100;  // length of block opening

int slowKeeper_1;  // represents which keeper to slow down for player 1
int slowKeeper_2;  // represents which keeper to slow down for player 2

int p1_score = 0;  // player 1's initial score
int p2_score = 0;  // player 2's initial score

boolean coinCollected_p1 = false;
boolean coinCollected_p2 = false;

public static boolean escapedWithCoin = false;
public static boolean escapedWithCoin_p2 = false;

public static float increaseFactor_p1 = 0;
public static float increaseFactor_p2 = 0;


// Booleans to indicate player's location in relation to the caves
boolean p2_visitedCave = false;
boolean p1_visitedCave = false;
boolean leftCave1 = true;
boolean leftCave2 = true;
boolean leftCave3 = true;
boolean leftCave4 = true;
boolean leftCave5 = true;
boolean leftCave6 = true;
boolean leftCave7 = true;
boolean leftCave8 = true;

// Booleans to represent which keeper to slow down
boolean isSlow_k1;
boolean isSlow_k2;
boolean isSlow_k3;
boolean isSlow_k4;
boolean isSlow_k5;
boolean isSlow_k6;
boolean isSlow_k7;
boolean isSlow_k8;

// To keep track of Player 1's direction
boolean p1_north;
boolean p1_south; 
boolean p1_west;
boolean p1_east;

// To keep track of Player 2's direction
boolean p2_north;
boolean p2_south; 
boolean p2_west;
boolean p2_east;

void setup() {
  size(1920,1080);
  
  // Initialize Player
  p1 = new Player(1, new PVector(1920/2+1920/4, 1080/2), 1920, 1080, 1920/2, 0);
  p2 = new Player(2, new PVector(1920/4, 1080/2), 1920/2, 1080, 0, 0);
  
  // Initialize caves, keepers and coins for player 2
  b1 = new Block(new PVector[]{new PVector(50,50), new PVector(400,50), new PVector(50,400), 
                 new PVector(400,400), new PVector(400,400-BLOCK_OPENING)}, 0, 0);
  b2 = new Block(new PVector[]{new PVector(50,600), new PVector(400,600), new PVector(50,950), 
                 new PVector(400,950), new PVector(400,600+BLOCK_OPENING)}, 1, 0);
  b3 = new Block(new PVector[]{new PVector(550,50), new PVector(900,50), new PVector(550,400), 
                 new PVector(900,400), new PVector(550,400-BLOCK_OPENING)}, 2, 1);
  b4 = new Block(new PVector[]{new PVector(550,600), new PVector(900,600), new PVector(550,950), 
                 new PVector(900,950), new PVector(550,600+BLOCK_OPENING)}, 3, 1);    
  
  // Initialize caves, keepers and coins for player 1
  b5 = new Block(new PVector[]{new PVector(WIDTH/2+50,50), new PVector(WIDTH/2+400,50), 
                 new PVector(WIDTH/2+50,400), new PVector(WIDTH/2+400,400), 
                 new PVector(WIDTH/2+400,400-BLOCK_OPENING)}, 0, 0);
  b6 = new Block(new PVector[]{new PVector(WIDTH/2+50,600), new PVector(WIDTH/2+400,600), 
                new PVector(WIDTH/2+50,950), new PVector(WIDTH/2+400,950), 
                new PVector(WIDTH/2+400,600+BLOCK_OPENING)}, 1, 0);
  b7 = new Block(new PVector[]{new PVector(WIDTH/2+550,50), new PVector(WIDTH/2+900,50), 
                 new PVector(WIDTH/2+550,400), new PVector(WIDTH/2+900,400), 
                 new PVector(WIDTH/2+550,400-BLOCK_OPENING)}, 2, 1);
  b8 = new Block(new PVector[]{new PVector(WIDTH/2+550,600), new PVector(WIDTH/2+900,600), 
                 new PVector(WIDTH/2+550,950), new PVector(WIDTH/2+900,950), 
                 new PVector(WIDTH/2+550,600+BLOCK_OPENING)}, 3, 1);  
                 
  // Initialize random variable to represent
  // which keeper to slow down for player 1
  slowKeeper_1 = int(random(4));
  
  // Initialize random variable to represent
  // which keeper to slow down for player 1
  slowKeeper_2 = int(random(4,8));
  
  running = true;  // Indicate that the game is running
}

void draw() {
  if(running) {
    background(#00ff00);
    
    // Draw divider for 2 players
    strokeWeight(7);
    line(1920/2,0,1920/2,1080);
   
    // Update player 1 location based on key press
    p1.move(p1_north, p1_south, p1_west, p1_east);
    
    // Update player 2 location based on key press
    p2.move(p2_north, p2_south, p2_west, p2_east);
    
    // Draw players
    p1.draw();
    p2.draw();
    
    // Draw caves
    b1.draw();
    b2.draw();
    b3.draw();
    b4.draw();
    b5.draw();
    b6.draw();
    b7.draw();
    b8.draw();
    
    // Check if player 2 has been caught by the keepers
    if(b1.isCaught(p2) || b2.isCaught(p2) || b3.isCaught(p2) || b4.isCaught(p2)) {
      p2.reset();  // Send p2 to start
      if(p2_score > 0)
        p2_score--;  // decrement p2's score
    }
    
    // Check for collision with blocks and check if
    // player 1 has been caught by the keepers
    if(b5.isCaught(p1) || b6.isCaught(p1) || b7.isCaught(p1) || b8.isCaught(p1)) {
      p1.reset();  // Send p2 to start
      if(p1_score > 0)
        p1_score--;  // decrement p2's score
    }    
    
    // Set the values of the booleans to
    // determine which keeper to slow down
    if(slowKeeper_1 == 0)
      isSlow_k1 = true;
    else
      isSlow_k1 = false;
  
    if(slowKeeper_1 == 1)
      isSlow_k2 = true;
    else
      isSlow_k2 = false;
      
    if(slowKeeper_1 == 2)
      isSlow_k3 = true;
    else
      isSlow_k3 = false;
      
    if(slowKeeper_1 == 3)
      isSlow_k4 = true;
    else
      isSlow_k4 = false;
      
    if(slowKeeper_2 == 4)
      isSlow_k5 = true;
    else
      isSlow_k5 = false;
      
    if(slowKeeper_2 == 5)
      isSlow_k6 = true;
    else
      isSlow_k6 = false;
      
    if(slowKeeper_2 == 6)
      isSlow_k7 = true;
    else
      isSlow_k7 = false;
      
    if(slowKeeper_2 == 7)
      isSlow_k8 = true;
    else
      isSlow_k8 = false;  
    
    // If player has entered a block,
    // make Keeper chase player
    // else, set keeper to guard.
    // Also check which keeper
    // to slow down, and whether to 
    // reset the keepers
    
    // Check for player 1
    if(b1.player_in_block(p2)) {
      //keeperLaugh.play();
      b1.chase_player(p2, isSlow_k1);
      p2_visitedCave = true; 
      leftCave1 = false;
    }
    else {
      b1.keeper_guard_on();
      leftCave1 = true;
    }
      
    if(b2.player_in_block(p2)) {
      b2.chase_player(p2, isSlow_k2);
      p2_visitedCave = true; 
      leftCave2 = false;  
    }
    else {
      b2.keeper_guard_on();
      leftCave2 = true;
    }
      
    if(b3.player_in_block(p2)) {
      b3.chase_player(p2,isSlow_k3);
      p2_visitedCave = true; 
      leftCave3 = false;  
    }
    else {
      b3.keeper_guard_on();   
      leftCave3 = true;
    }
      
    if(b4.player_in_block(p2)) {
      b4.chase_player(p2,isSlow_k4);
      p2_visitedCave = true; 
      leftCave4 = false;  
    }
    else {
      b4.keeper_guard_on();   
      leftCave4 = true;
    }
      
    // Check for player 2
    if(b5.player_in_block(p1)) {
      b5.chase_player(p1,isSlow_k5);
      p1_visitedCave = true;
      leftCave5 = false;
    }
    else {
      b5.keeper_guard_on();
      leftCave5 = true;  
    }
      
    if(b6.player_in_block(p1)) {
      b6.chase_player(p1,isSlow_k6);
      p1_visitedCave = true;
      leftCave6 = false;
    }
    else {
      b6.keeper_guard_on();
      leftCave6 = true;
    }
      
    if(b7.player_in_block(p1)) {
      b7.chase_player(p1,isSlow_k7);
      p1_visitedCave = true;
      leftCave7 = false;
    }
    else {
      b7.keeper_guard_on();
      leftCave7 = true;
    }
      
    if(b8.player_in_block(p1)) {
      b8.chase_player(p1,isSlow_k8);
      p1_visitedCave = true;
      leftCave8 = false;
    }
    else {
      b8.keeper_guard_on();
      leftCave8 = true;
    }
      
    // Reset increaseFactor if player 2 has enetered and left a cave
    if(p2_visitedCave && leftCave1 && leftCave2 && leftCave3 && leftCave4) {
     increaseFactor_p2 = 0;
    }
    
    // Reset increaseFactor if player 2 has enetered and left a cave
    if(p1_visitedCave && leftCave5 && leftCave6 && leftCave7 && leftCave8) {
     increaseFactor_p1 = 0;
    }
    
    // Check if player has collected a coin
    if(b1.player_collected_coin(p2) || b2.player_collected_coin(p2) || b3.player_collected_coin(p2) ||
       b4.player_collected_coin(p2)) {
      p2_score++;
      coinCollected_p2 = true;
    }
      
    if(coinCollected_p2) {
      if(leftCave1 && leftCave2 && leftCave3 && leftCave4) {  // If player took coin and escaped
        escapedWithCoin = true;
        resetKeepers(2);
        coinCollected_p2 = false;
      }
    }
    
    if(b5.player_collected_coin(p1) || b6.player_collected_coin(p1) || b7.player_collected_coin(p1) ||
       b8.player_collected_coin(p1)) {
       p1_score++;
       coinCollected_p1 = true;
    }
    
    if(coinCollected_p1) {
     if(leftCave5 && leftCave6 && leftCave7 && leftCave8) {  // If player took coin and escaped
       escapedWithCoin = true;
       resetKeepers(1);
       coinCollected_p1 = false;
     }
     else {
       escapedWithCoin = false;
     }
    }
    
    // Print player scores
    textSize(48);
    textAlign(CENTER);
    text("Score: " + p2_score, 1920/4, 1080/2+1080/2.1);
    text("Score: " + p1_score, 1920/2+1920/4, 1080/2+1080/2.1);
    
    if(p2_score >= 10) {
      running = false;
      winner = "Player 2";
    }
    else if(p1_score >= 10) {
      running = false;
      winner = "Player 1";
    }
  }
  else {  // If game terminated, print winner on screen
    background(#00ff00);
    textSize(64);
    textAlign(CENTER);
    text("Congratulations " + winner + "!" + " You have won the game!!!", 1920/2, 1080/2);
    textSize(48);
    text("Press 'R' to restart the game", 1920/2, 1080/2+1080/4);
  }
}

// Reset keeper speeds
void resetKeepers(int mapSide) {
    
  // reset which keeper to slow down for player 2
  if(mapSide == 2)
    slowKeeper_1 = int(random(4));
  
  // reset which keeper to slow down for player 1
  if(mapSide == 1)
    slowKeeper_2 = int(random(4,8));
}

// Function to reset the game
void resetGame() {
  
  // Reset player locations
  p1.reset();
  p2.reset();
  
  // Reset all keepers and coins positions
  b1.reset();
  b2.reset();
  b3.reset();
  b4.reset();
  
  // Reset player scores
  p2_score = p1_score = 0;
  
  // Set game state to running
  running = true;
}

// Set the desired directions to true on key presses
void keyPressed() {
  // Player 1 controls
  if(key == CODED) {
    switch(keyCode) {
      case UP:
        p1_north = true;
        break;
    case DOWN:
        p1_south = true;
        break;
    case LEFT:
        p1_west = true;
        break;
    case RIGHT:
        p1_east = true;
        break;
    }
  }
  // Player 2 controls
  if(key == 'w' || key == 'W')
    p2_north = true;
  if(key == 's' || key == 'S')   
    p2_south = true;
  if(key == 'a' || key == 'A')   
    p2_west = true;
  if(key == 'd' || key == 'D')   
    p2_east = true;
    
  // Menu controls
  if(!running){
    if(key == 'r' || key == 'R') {
      resetGame();
    }
  }
}

// Set the desired directions to false on key releases
void keyReleased() {
  // Player 1 controls
  if(key == CODED) {
    switch(keyCode) {
      case UP:
        p1_north = false;
        break;
    case DOWN:
        p1_south = false;
        break;
    case LEFT:
        p1_west = false;
        break;
    case RIGHT:
        p1_east = false;
        break;
    }
  }
  // Player 2 controls
  if(key == 'w' || key == 'W')
    p2_north = false;
  if(key == 's' || key == 'S')   
    p2_south = false;
  if(key == 'a' || key == 'A')   
    p2_west = false;
  if(key == 'd' || key == 'D')   
    p2_east = false;
}