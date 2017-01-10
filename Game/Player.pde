class Player {
  
  int playerID;                          // Identifier for player
  PVector pos;                           // current (x,y) position of player
  PVector startingPos;                   // initial pos of player
  PVector vel;                           // current velocity of player
  PVector acc;                           // current acceleration of player
  int player_diameter = 55;              // diameter of the player
  int player_radius = player_diameter/2; // radius of the player
  int min_x, min_y;                      // minimum x and y values for the player
  int size_x, size_y;                    // maximum x and y values for the player (i.e. size of the arena)
  boolean collission = false;            // to see if player has collided with obstacle
  boolean blocked = false;               // to see if player has stopped
  PImage startImage;                     // Stock image for the player
  PImage[] image;                        // Array of images for the player
  int imageIndex = 0;                    // Index of the image to load
  int upCount = 0;                       // To keep track of images
  int downCount = 0;                     // in order to load the
  int leftCount = 0;                     // right images based
  int rightCount = 0;                    // on player's movement
  
  // Player Constructor
  Player(int playerID, PVector position, int size_x, int size_y, int min_x, int min_y) {
    
    // Get the ID for the player
    this.playerID = playerID;
    
    // Store the minimum bounds of the grid
    this.min_x = min_x;
    this.min_y = min_y;
    
    // Store the size of the grid
    this.size_x = size_x;
    this.size_y = size_y;
    
    // Initialize initial attributes of Player
    pos = new PVector( position.x,position.y );
    vel = new PVector( 0, 0 );
    acc = new PVector( 7, 7 );
    
    // Set startingPos of player
    startingPos = new PVector(pos.x, pos.y);
    
    image = new PImage[9];
    
    // Load images for player
    image[0] = loadImage("front.png");
    image[1] = loadImage("upLeft.png");
    image[2] = loadImage("upRight.png");
    image[3] = loadImage("frontLeft.png");
    image[4] = loadImage("frontRight.png");
    image[5] = loadImage("leftFront.png");
    image[6] = loadImage("leftBack.png");
    image[7] = loadImage("rightFront.png");
    image[8] = loadImage("rightBack.png");
  }
  
  void draw() { 
    noFill();
    strokeWeight( 3 );
    imageMode(CENTER);
    image( image[imageIndex], pos.x, pos.y, player_diameter, player_diameter );
    
    // Check collission with map walls
    if (( pos.x+vel.x-player_radius < min_x ) || ( pos.x+vel.x > size_x - player_radius )) 
      vel.x = 0;
    if (( pos.y+vel.y-player_radius < min_y ) || ( pos.y+vel.y > size_y - player_radius )) 
      vel.y =  0;
      
    if(Game.b1.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) || 
       Game.b2.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) ||
       Game.b3.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) ||
       Game.b4.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius)) {
      vel.x = 0;
    }
      
    if(Game.b1.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) || 
       Game.b2.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) ||
       Game.b3.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) ||
       Game.b4.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius)) {
      vel.y = 0;
    }
    
    if(Game.b5.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) || 
       Game.b6.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) ||
       Game.b7.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius) ||
       Game.b8.wallCollission(new PVector(pos.x+vel.x, pos.y), player_radius)) {
      vel.x = 0;
    }
      
    if(Game.b5.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) || 
       Game.b6.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) ||
       Game.b7.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius) ||
       Game.b8.wallCollission(new PVector(pos.x, pos.y+vel.y), player_radius)) {
      vel.y = 0;
    }    
    
    pos.x += vel.x;
    pos.y += vel.y;
    
    // Reset velocity
    vel.x = vel.y = 0; 
  }
  
  // To move Player in the desired direction.
  // This function also calls animate to update
  // the player image.
  void move(boolean n, boolean s, boolean w, boolean e) {
    if(n)
      vel.y -= acc.y;
    if(s)
       vel.y += acc.y;
    if(w)
       vel.x -= acc.x;
    if(e)
       vel.x += acc.x;
       
    animate(n, s, w, e);
  }
  
  // Sets the image based on player direction
  void animate(boolean n, boolean s, boolean w, boolean e) {   
    if(n) {
      imageIndex = 1 + upCount;
      if(upCount == 1)
         upCount--; // decrement up count if already at 2
      else
        upCount++;  // increment up count to put the other leg forward next time
    }
    else if(s) {
      imageIndex = 3 + downCount;
      if(downCount == 1)
         downCount--; // decrement down count if already at 2
      else
        downCount++;  // increment down count to put the other leg forward next time
    }
    else if(w) {
      imageIndex = 5 + leftCount;
      if(leftCount == 1)
         leftCount--; // decrement left count if already at 2
      else
        leftCount++;  // increment left count to put the other leg forward next time
    }
    else if(e) {
      imageIndex = 7 + rightCount;
      if(rightCount == 1)
         rightCount--; // decrement right count if already at 2
      else
        rightCount++;  // increment right count to put the other leg forward next time
    }
  }
  
  // Stop the player
  public void stopped() {
  }
  
  // Reset player position
  void reset() {
    // Reset player pos to starting pos
    pos.x = startingPos.x;
    pos.y = startingPos.y;
    
    // Reset image index to 0
    imageIndex = 0;
  }
}