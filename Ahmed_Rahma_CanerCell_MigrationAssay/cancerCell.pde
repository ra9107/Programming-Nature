class cancerCell {
  PVector position;  
  PVector velocity;
  PVector acceleration;
  float topspeed;   // The Mover's maximum speed
  float mass;
  float diameter;
  color rand;

  //constructor, set values for all variables
  cancerCell() {
    position = new PVector(500, 150);
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-0.003, -0.001), random(-0.005, -0.001));
    diameter = 10;
    topspeed = 5;
    mass = 3;
    rand = color(random(255), random(255), random(255));
  }

//update position of cell based on changes to velocity caused by changes in acceleration
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  //displays the cancerCell as a circle with a random color
  void display() { //using vectors
    fill(rand);
    ellipse(position.x - diameter/2, position.y, diameter, diameter);
    //fill(0);
    //line(position.x + diameter/2, position.y, position.x + diameter, position.y);
    //line(position.x - diameter/2, position.y, position.x - diameter, position.y);
    //line(position.x, position.y + diameter/2, position.x, position.y + diameter);
    //line(position.x, position.y - diameter/2, position.x, position.y - diameter);
  }
  
  //application of Newton's second law for force
  void applyForce(PVector force){
     PVector forc = force.copy();
     forc.div(mass);
     acceleration.add(forc);
  }
  
  //drag caused by entering an attractor(blood vessel)
  void drag(attractor blood){
   float speed = velocity.mag();
   //mag of drag is drag coefficient * speed squared 
   float dragMagnitude = blood.dragCoeff * speed * speed;
   
   PVector drag = velocity.copy();
   drag.mult(-1);
   drag.normalize();
   drag.mult(dragMagnitude);
   applyForce(drag);
   }
  
}