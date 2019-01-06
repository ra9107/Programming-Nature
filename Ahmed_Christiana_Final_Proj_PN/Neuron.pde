//"age" of cell determines heirarchy and placement in space
//age will 
class Neuron extends StemCell {
  PVector position;

  PVector velocity;
  PVector acceleration;
  float maxSpeed = 3;
  float maxForce = 1.2;
  float age;
  color c;
  boolean reachPathStart;
  float colorV = 220;

  Neuron(PVector pos) {
    //super();
    age = 0;
    position = pos;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0.01, 0.1);
    radius = 10;
  }

  void display() {
    stroke(0);
    strokeWeight(0.5);
    fill(colorV);
    ellipse(position.x, position.y, radius, radius*2);
    update();
  }

  void age() {
    age++;
    colorV -= 20;
  }

  void seek(PVector pathStart) { //basically seek and slow down as approaching target
    PVector desired = PVector.sub(pathStart, this.position);
    desired.normalize();
    desired.mult(maxSpeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  //void foundStart(Path p) {
  //  PVector desired = PVector.sub(p.start, this.position);
  //  float d = desired.mag(); 
  //  if (d<5) {
  //  }
  //}

  void follow(Path p) {
    //PVector target = null;
    //float worldRecord = 10000000;
    //Predict the vehicle’s future location.
    PVector predict = velocity.copy(); 
    predict.normalize();
    predict.mult(25);
    PVector predictLoc = PVector.add(position, predict);
    //Find the normal point along the  path.

    PVector a = p.start;     
    PVector b = p.end; 
    PVector normalPoint = getNormalPoint(predictLoc, a, b);
    //Move a little further along the pathand set a target
    PVector dir = PVector.sub(b, a); 
    dir.normalize(); 
    dir.mult(10);
    PVector target = PVector.add(normalPoint, dir);
    //If we are off the path, seek that target in order to stay on the path
    float distance = PVector.dist(normalPoint, predictLoc);
    if (distance > p.radius) {

      //START
      //for (int i = 0; i < p.points.size()-1; i++) {
      //  PVector a = p.points.get(i);
      //  PVector b = p.points.get(i+1);
      //  PVector normalPoint = getNormalPoint(predictLoc, a, b);
      //  if (normalPoint.x < a.x || normalPoint.x > b.x) {
      //    normalPoint = b.copy();
      //  }
      //  float distance = PVector.dist(predictLoc, normalPoint);
      //  //If we beat the record, then this should be our target!
      //    if (distance < worldRecord) { 
      //    worldRecord = distance; 
      //    target = normalPoint.copy();
      //  }
      //END
      seek(target);
    }
  }


  PVector getNormalPoint(PVector p, PVector a, PVector b) {
    PVector ap = PVector.sub(p, a); //PVector that points from a to p
    PVector ab = PVector.sub(b, a); //PVector that points from a to b
    ab.normalize(); //Using the dot product for scalar projection 
    ab.mult(ap.dot(ab));
    PVector normalPoint = PVector.add(a, ab);
    //Finding the normal point along the line segment
    return normalPoint;
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);  //add acceleration to velocity
    velocity.limit(maxSpeed);
    position.add(velocity);  //add velocity to location
    //checkEdges();
    acceleration.set(0, 0);
  }
}



//void checkEdges() {
//  if (position.x<0) {              //if too far left
//    position.x=width;              //move to the right of the window
//  } else if (position.x>width) {  //if too far right
//    position.x=0;                 //move to the left of the window
//  }
//  if (position.y<0) {             //if too high
//    position.y=height;            //move to the bottom of the window
//  } else if (position.y>height) { //if too low
//    position.y=0;                 //move to the top of the window
//  }
//}

//FOLLOW PATH CODE
//      PVector a = p.start;     
//      PVector b = p.end; 
//      PVector normalPoint = getNormalPoint(predictLoc, a, b);
//      //Move a little further along the pathand set a target
//      PVector dir = PVector.sub(b, a); 
//      dir.normalize(); 
//      dir.mult(10);
//      PVector target = PVector.add(normalPoint, dir);
//      //If we are off the path, seek that target in order to stay on the path
//      float distance = PVector.dist(normalPoint, predictLoc);
//      if (distance > p.radius) {