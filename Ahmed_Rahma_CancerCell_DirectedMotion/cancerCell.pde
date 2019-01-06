class cancerCell {
  PVector position;  
  PVector velocity;
  PVector acceleration;
  float topspeed;   // The Mover's maximum speed
  float diameter;
  float stepSize;
  color rand;

  //constructor, set values for all variables
  cancerCell() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0.01, 0.01);
    diameter = 40;
    topspeed = 4;
    stepSize =1;
    rand = color(random(255), random(255), random(255));
  }

  void randStep() {
    //move x,y position based on a random number -1,0,+1 (* magnitude of step determined by stepSize)
    int xRand = int(random(3))-1; // 0, 1, 2
    position.x += stepSize * xRand ;
    int yRand = int (random(3)) -1 ; // 0, 1, 2
    position.y += stepSize * yRand;

    //not really necesary but this attempts to bring the cells closer 
    //to the display screen if they go off bounds
    if (position.x < diameter/2) position.x ++;
    else if (position.x > width - diameter/2) position.x --;
    if (position.y < diameter/2) position.y ++;
    else if (position.y > height - diameter/2) position.y --;
 
  }

//cell accelerates towards the food
  void foodStep() {
    PVector food = new PVector(foodx, foody);
    //sets acceleration vector to the vector between the ellipse center and the food center
    acceleration = PVector.sub(food, position);
    //magnitude of acceleration
    acceleration.normalize();
    acceleration.mult(0.2);

    velocity.add(acceleration);      //incorporate acceleration into velocity
    velocity.limit(topspeed);     //limits velocity
    position.add(velocity);
  }

  //keeps the cancer cells away from healthy cells
  void medicineStep() {
    PVector medicine = new PVector(medicinex, mediciney);
    //sets acceleration vector to the vector between the ellipse center and the food center
    acceleration = PVector.sub(medicine, position);
    //magnitude of acceleration
    acceleration.normalize();
    acceleration.mult(0.2);
    //negates the acceleration direction so that it is being repelled
    acceleration.x *=-1; 
    acceleration.y *= -1;
    velocity.add(acceleration);    //incorporate acceleration into velocity
    velocity.limit(topspeed);     //limits velocity
    position.add(velocity);
  }

  //displays the cancerCell as a red circle with four lines comign out of it
  void display() { //using vectors
    fill(rand);
    ellipse(position.x, position.y, diameter, diameter);
    fill(0);
    line(position.x + diameter/2, position.y, position.x + diameter, position.y);
    line(position.x - diameter/2, position.y, position.x - diameter, position.y);
    line(position.x, position.y + diameter/2, position.x, position.y + diameter);
    line(position.x, position.y - diameter/2, position.x, position.y - diameter);
  }
}

/*
//random movement 
 float rand = random(tx);
 float yrand = random(ty);
 xpos = map(rand, 0, tx, 0, width); 
 ypos = map(yrand, 0, ty, 0, height);
 
 //Perlin noise
 void step() {
 position.x = map(noise(tx), 0, 1, 0, width ); 
 position.y = map(noise(ty), 0, 1, 0, height);
 
 //moving forward in time (time vs noise graph)
 tx += stepSize * (0.01);
 ty += stepSize * (0.01);
 }
 
 */