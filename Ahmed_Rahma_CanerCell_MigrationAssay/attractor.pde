//simple attractor class to make an object that attracts cells to itself
class attractor{
  PVector position;
  float diam;
  float mass;
  float G;//constant
  float dragCoeff;
  
  attractor(){
    position = new PVector(0,150);
    diam = 25;//if its bigger its easier to see drag
    mass = 20;
    G = 1;
    dragCoeff = 0.5;
  }
  
  void display(){
    stroke(160, 43, 43);
    fill(198, 27, 27);
    ellipse(position.x, position.y, diam, diam);
  }
  
  //attracts the cancerCell to it 
  PVector attract(cancerCell cell){
    PVector force = PVector.sub(position, cell.position);
    float distance = force.mag();
    force.normalize();
    distance = constrain(distance,1.0,15); //constrain distance so that 
    float strength = (G * mass* cell.mass)/(distance * distance);
    force.mult(strength);
    return force;  
  }
}

//void drag(cancerCell cell){
  // float speed = cell.velocity.mag();
  // float dragMagnitude = dragCoeff * speed * speed;
   
  // PVector drag = cell.velocity.copy();
  // drag.mult(-1);
  // drag.normalize();
  // drag.mult(dragMagnitude);
  // cell.applyForce(drag);
  //}