// Represents a block on the map which contains
// a Keeper and a Coin
class Block {
  
  PVector[] coord;  // coordinates of the square block
  int opening;      // specifies opening to the cave
  Keeper keeper;    // Keeper
  Coin coin;        // Coin
  
  // Takes the coordinates for the cave and
  // the position of the keeper inside the cave
  Block(PVector[] coords, int opening, int coinPos) {
    
    // Get the coordinates for the cave
    coord = coords;
    
    // Get the desired opening to the cave
    this.opening = opening;
    
    // Position of keeper within cave
    PVector keeper_pos = new PVector((coord[0].x+coord[1].x)/2, (coord[0].y+coord[2].y)/2);
    
    // Initilize Keeper
    keeper = new Keeper(keeper_pos);
    
    // Initialize a Coin object
    coin = new Coin(coinPos);
  }
  
  void draw() {
    // Draw the cave with the opening in the specified direction
    // The opening to the cave is indicated by the following:
    // 0: south west, 1: north west, 2: south east, 3: north east
    strokeWeight(5);
    if(opening == 0) {
      line(coord[0].x, coord[0].y, coord[1].x, coord[1].y);      // x1, y1, x2, y2
      line(coord[0].x, coord[0].y, coord[2].x, coord[2].y);      // x1, y1, x3, y3  
      line(coord[2].x, coord[2].y, coord[3].x, coord[3].y);      // x3, y3, x4, y4  
      line(coord[1].x, coord[1].y, coord[4].x, coord[4].y);      // x2, y2, x5, y5
    }
    else if(opening == 1) {
      line(coord[0].x, coord[0].y, coord[1].x, coord[1].y);      // x1, y1, x2, y2
      line(coord[0].x, coord[0].y, coord[2].x, coord[2].y);      // x1, y1, x3, y3  
      line(coord[2].x, coord[2].y, coord[3].x, coord[3].y);      // x3, y3, x4, y4  
      line(coord[3].x, coord[3].y, coord[4].x, coord[4].y);      // x2, y2, x5, y5
    }
    else if(opening == 2) {
      line(coord[0].x, coord[0].y, coord[1].x, coord[1].y);      // x1, y1, x2, y2
      line(coord[0].x, coord[0].y, coord[4].x, coord[4].y);      // x1, y1, x3, y3  
      line(coord[2].x, coord[2].y, coord[3].x, coord[3].y);      // x3, y3, x4, y4  
      line(coord[1].x, coord[1].y, coord[3].x, coord[3].y);      // x2, y2, x5, y5
    }
    else if(opening == 3) {
      line(coord[0].x, coord[0].y, coord[1].x, coord[1].y);      // x1, y1, x2, y2
      line(coord[4].x, coord[4].y, coord[2].x, coord[2].y);      // x1, y1, x3, y3  
      line(coord[2].x, coord[2].y, coord[3].x, coord[3].y);      // x3, y3, x4, y4  
      line(coord[1].x, coord[1].y, coord[3].x, coord[3].y);      // x2, y2, x5, y5
    }
    
    // Draw the coin
    coin.draw();
    
    // Draw the Keeper
    keeper.draw();
  }
  
  // Check if player has collied with the walls of the cave
  boolean wallCollission(PVector pos, int radius) {
    
    // Top wall of the cave
    PVector lineA_1 = new PVector(coord[0].x, coord[0].y);
    PVector lineA_2 = new PVector(coord[1].x, coord[1].y);
    
    // Top to bottom of player
    PVector lineB_1 = new PVector(pos.x, pos.y-radius);
    PVector lineB_2 = new PVector(pos.x, pos.y+radius);
    
    // Solve the equation for the intersection point on line A
    float ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
              (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
              ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
              (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
              
    // Solve the equation for the intersection point on line B
    float ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
              (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
              ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
              (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));    
    
    // Return true if u is between 0 and 1
    if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
      return true;
      
    // Bottom wall of the cave
    lineA_1 = new PVector(coord[2].x, coord[2].y);
    lineA_2 = new PVector(coord[3].x, coord[3].y);
    
    // Solve the equation for the intersection point on line A
    ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
              (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
              ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
              (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
              
    // Solve the equation for the intersection point on line B
    ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
              (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
              ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
              (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));    
    
    // Return true if u is between 0 and 1
    if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
      return true;
    
    if(opening == 0 || opening == 1) {
      // Left wall of cave
      lineA_1 = new PVector(coord[0].x, coord[0].y);
      lineA_2 = new PVector(coord[2].x, coord[2].y);
      
      // Left side to right side of player
      lineB_1 = new PVector(pos.x-radius, pos.y);
      lineB_2 = new PVector(pos.x+radius, pos.y);
      
      // Solve the equation for the intersection point on line A
      ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
               (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
               ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
               (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                
      // Solve the equation for the intersection point on line B
      ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
               (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
               ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
               (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
      
      // Return true if u is between 0 and 1
      if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
       return true;
       
      if(opening == 0) {
        // Right wall of cave
        lineA_1 = new PVector(coord[1].x, coord[1].y);
        lineA_2 = new PVector(coord[4].x, coord[4].y);
        
        // Left side to right side of player
        lineB_1 = new PVector(pos.x-radius, pos.y);
        lineB_2 = new PVector(pos.x+radius, pos.y);
        
        // Solve the equation for the intersection point on line A
        ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                  
        // Solve the equation for the intersection point on line B
        ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
        
        // Return true if u is between 0 and 1
        if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
         return true;
      }
      if(opening == 1) {
        // Right wall of cave
        lineA_1 = new PVector(coord[3].x, coord[3].y);
        lineA_2 = new PVector(coord[4].x, coord[4].y);
        
        // Left side to right side of player
        lineB_1 = new PVector(pos.x-radius, pos.y);
        lineB_2 = new PVector(pos.x+radius, pos.y);
        
        // Solve the equation for the intersection point on line A
        ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                  
        // Solve the equation for the intersection point on line B
        ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
        
        // Return true if u is between 0 and 1
        if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
         return true;      
      }
    }
    if(opening == 2 || opening == 3) {
      // Right wall of cave
      lineA_1 = new PVector(coord[1].x, coord[1].y);
      lineA_2 = new PVector(coord[3].x, coord[3].y);
      
      // Left side to right side of player
      lineB_1 = new PVector(pos.x-radius, pos.y);
      lineB_2 = new PVector(pos.x+radius, pos.y);
      
      // Solve the equation for the intersection point on line A
      ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
               (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
               ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
               (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                
      // Solve the equation for the intersection point on line B
      ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
               (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
               ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
               (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
      
      // Return true if u is between 0 and 1
      if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
       return true;  
       
      if(opening == 2) {
        // Left wall of cave
        lineA_1 = new PVector(coord[0].x, coord[0].y);
        lineA_2 = new PVector(coord[4].x, coord[4].y);
       
        // Left side to right side of player
        lineB_1 = new PVector(pos.x-radius, pos.y);
        lineB_2 = new PVector(pos.x+radius, pos.y);
        
        // Solve the equation for the intersection point on line A
        ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                  
        // Solve the equation for the intersection point on line B
        ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
        
        // Return true if u is between 0 and 1
        if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
         return true; 
      }
      if(opening == 3) {
        // Right wall of cave
        lineA_1 = new PVector(coord[4].x, coord[4].y);
        lineA_2 = new PVector(coord[2].x, coord[2].y);
        
        // Left side to right side of player
        lineB_1 = new PVector(pos.x-radius, pos.y);
        lineB_2 = new PVector(pos.x+radius, pos.y);
        
        // Solve the equation for the intersection point on line A
        ua = ((lineB_2.x - lineB_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineB_2.y - lineB_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
                  
        // Solve the equation for the intersection point on line B
        ub = ((lineA_2.x - lineA_1.x)*(lineA_1.y - lineB_1.y)-
                 (lineA_2.y - lineA_1.y)*(lineA_1.x-lineB_1.x))/
                 ((lineB_2.y - lineB_1.y)*(lineA_2.x - lineA_1.x) - 
                 (lineB_2.x - lineB_1.x)*(lineA_2.y - lineA_1.y));
        
        // Return true if u is between 0 and 1
        if((ua > 0 && ua < 1) && (ub > 0 && ub < 1))
         return true;       
      }
    }
      
    return false;
  }
  
  // Calls Keeper.hasCaught(Player p)
  boolean isCaught(Player p) {
    return keeper.hasCaught(p);
  }
  
  // Check if player is in the bounds of the cave
  boolean player_in_block(Player p) {
    if(p.pos.x >= coord[0].x && p.pos.y >= coord[0].y && p.pos.x <= coord[3].x && p.pos.y <= coord[3].y) {
      return true;  
    }
    return false;
  }
  
  // Prompt the keeper to chase the player
  void chase_player(Player p, boolean isSlow) {
    keeper.chase(p, isSlow);
  }
  
  // Prompt the keeper to guard inside the block
  void keeper_guard_on() {
    keeper.guardModeOn();
  }
  
  // Calls coinCollected method in the coinClass
  boolean player_collected_coin(Player p) {
    return coin.coinCollected(p);
  }
  
  // Reset keeper and coin positions
  void reset() {
    // Set keeper pos to starting pos
    keeper.pos.x = keeper.startingPos.x;
    keeper.pos.y = keeper.startingPos.y;
    
    // Set coin pos to starting pos
    coin.pos.x = coin.startingPos.x;
    coin.pos.y = coin.startingPos.y;
  }
  
  class Keeper {
  
    // Keeper attributes
    PVector pos;                         // current (x,y) position of comp
    PVector startingPos;                 // Starting position of keeper
    PVector vel;                         // current velocity of comp
    PVector acc;                         // current acceleration of comp
    int keeper_diameter = 40;            // diameter of the comp
    int r = keeper_diameter/2;           // radius of the comp
    int size_x, size_y;                  // maximum x and y values for the comp (i.e. size of the arena)
    boolean collission = false;          // to see if comp has collided with obstacle
    boolean stopped = false;             // to see if comp has stopped
    PImage image;                        // Keeper umage
    float image_x = keeper_diameter+50;  // x coordinate of image
    float image_y = keeper_diameter+50;  // y coordinate of image
    boolean guard_mode = true;
  
    // Comp constructor
    Keeper(PVector position) {
      // Initialize initial attributes of Comp
      pos = new PVector(position.x, position.y);
      vel = new PVector( 0, 0 );
      acc = new PVector( 5, 5 );
      
      // Fixate starting position
      startingPos = new PVector(pos.x, pos.y);
      
      image = loadImage("keeper.png");
    }
  
    void draw() {
      noFill();
      strokeWeight( 3 );
      imageMode(CENTER);
      image( image, pos.x, pos.y, image_x, image_y);
      
      // If guard_mode on, guard inside block
      if(guard_mode) {
        if(pos.x > startingPos.x)
          pos.x--;
        else if(pos.x < startingPos.x)
          pos.x++;
        if(pos.y > startingPos.y)
          pos.y--;
        else if(pos.y < startingPos.y)
          pos.y++;
      }
      
      // Check for lower and upper bounds on grid
      if (( pos.x+vel.x < 0 ) || ( pos.x+vel.x > size_x - keeper_diameter )) 
        vel.x = -(vel.x);
      if (( pos.y+vel.y < 0 ) || ( pos.y+vel.y > size_y - keeper_diameter )) 
        vel.y = -(vel.y);
      
      // Update Player location
      pos.x += vel.x;
      pos.y += vel.y;
    
      // Reset velocity
      vel.x = vel.y = 0;
    }
    
    // Check if keeper has caught player
    boolean hasCaught(Player p) {
        float r1 = p.player_diameter / 2;
        PVector playerCenter = new PVector( p.pos.x+r1, p.pos.y+r1 );
        float r2 = keeper_diameter / 2;
        PVector keeperCenter = new PVector( pos.x+r2, pos.y+r2 );
        float d = sqrt( sq(playerCenter.x - keeperCenter.x) + sq(playerCenter.y - keeperCenter.y ));
        if ( d < r1 + r2 ) {
          return true;
        } else {
          return false;
        }
    }
    
    // Chase player
    void chase(Player p, boolean isSlow) {
      // Set guard mode to false
      guard_mode = false;
      // calculate "difference" vector between the Keeper and the Player
      PVector diff = pos.sub( pos, p.pos );
      // compute the distance between the keeper and the player (magnitude of difference vector)
      float d = diff.mag();
      if ( d > 0 ) {
        // normalize difference vector
        diff.normalize();
        // adjust x and y velocity according to the difference vector
        vel = p.pos.sub( diff, vel );
        
        if(isSlow) {
          if(p.playerID == 1) {
            vel.mult(2.5+Game.increaseFactor_p1);
            Game.increaseFactor_p1 += 0.03;        // Slowly increase keeper speed
          }
          else {
            vel.mult(2.5+Game.increaseFactor_p2);
            Game.increaseFactor_p2 += 0.03;        // Slowly increase keeper speed
          }
        }
        else {  // Make the keeper faster
          vel.mult(7);
        }
      }
    }
    
    // Turn on guard mode
    void guardModeOn() {
      guard_mode = true;
    } 
  }
  
  // Represents a Coin inside the block
  class Coin {
    PImage coin_image;           // coin image
    PVector pos;                 // position of coin
    PVector startingPos;         // initial pos of coin
    float coin_diameter = 30;    // diameter of coin
    
    // Constructor
    Coin(int coinPos) {
      pos = new PVector();
      
      if(coinPos == 0)  // coin is west of keeper
        pos.x = keeper.pos.x - keeper.image_x;
      if(coinPos == 1)  // coin is east of keeper
        pos.x = keeper.pos.x + keeper.image_y;
        
      pos.y = keeper.pos.y;  // always the same as keeper's y-coordinate 
      
      // Set startingPos of coin
      startingPos = new PVector(pos.x,pos.y);
      
      coin_image = loadImage("coin.png");
    }
    
    void draw() {
      // Draw the coin
      image(coin_image, pos.x, pos.y, 30, 30);
    }
    
    boolean coinCollected(Player p) {
      float r1 = p.player_diameter / 2;
      PVector playerCenter = new PVector( p.pos.x+r1, p.pos.y+r1 );
      float r2 = coin_diameter / 2;
      PVector coinCenter = new PVector( pos.x+r2, pos.y+r2 );
      float d = sqrt( sq(playerCenter.x - coinCenter.x) + sq(playerCenter.y - coinCenter.y ));
      if ( d < r1 + r2 ) {
        PVector original_pos = new PVector(pos.x, pos.y);
        pos.x = pos.y = -5;
        // Wait and make coin reappear
        Thread waitThread = new Thread(new WaitThread(original_pos, 3000));
        waitThread.start();
        return true;
      } else {
        return false;
      }
    }

    class WaitThread implements Runnable {
      PVector originalPos;
      int waitTime;
      
      WaitThread(PVector originalPos, int milis) {
        this.originalPos = new PVector(originalPos.x, originalPos.y);
        waitTime = milis;
      }
      public void run() {
        waitThread(waitTime);  
      }
      // Waits for the specified time interval
      void waitThread(int waitTime) {
        
        delay(waitTime);
        
        pos.x = originalPos.x;
        pos.y = originalPos.y;
        
        Game.escapedWithCoin = false;
      }
    }
  }
}