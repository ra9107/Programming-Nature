class StemCell {
  PVector position;
  //PVector velocity;
  //PVector acceleration;
  //float lifespan;
  float radius;
  float visionRange = 50;

  StemCell() {
    //Constructor - initialization
    position = new PVector(random(sWidth), random(sHeight -len*2.5, sHeight));
    //velocity = new PVector(0, 0);
    //lifespan = 500;
    radius = 5;
  }

  void display() {
    stroke(0);
    strokeWeight(0.25);
    fill(0, 200, 120);
    ellipse(position.x, position.y, radius, radius);
  }

  StemCell reproduce() {
    // reproduce a stemCell 
    StemCell newCell = new StemCell();
    return newCell;
  }

  boolean sensesOther(PVector c) {
    return PVector.dist(c, this.position) < visionRange;
  }
}