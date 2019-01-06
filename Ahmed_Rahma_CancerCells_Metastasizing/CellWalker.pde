//CellWalker Class

class CellWalker {
  PVector position;
  PVector velocity;
  float telomeres;
  float lifespan;

  CellWalker(PVector p) {
    //Constructor - initialization
    //Define initial location
    position = p.copy();
    velocity = new PVector(0, 0);
    lifespan = random(50);
    telomeres = random(10);
  }

  void display() {
    //display as a stroke - point
    float x = position.x;
    float y = position.y;
    //Draw Cell Body
    fill(155);
    ellipse(x, y, 30, 20);

    //Draw Cell nucleus
    float eyeR = int(lifespan);
    float eyeG = int(lifespan);
    float eyeB = 255;
    fill(eyeR, eyeG, eyeB); //nucleus depends on random variables
    ellipse(x, y, 11, 8);

    //Draw Cell Receptors
    stroke(0);
    //receptors depend on old mouse position
    line(x-15, y, x-20, y-5);
    line(x-15, y-5, x-20, y-7);
    line(x+15, y, x+20, y-5);
  }

  void run() {
    step();
    display();
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  CellWalker reproduce() {
    //add a new CellWalker to the grid
    CellWalker c = new CellWalker(position);
    c.telomeres = telomeres;
    return c;
  }

  void step() {
    float r = random(1);
    //// A 30% of moving towards a source
    if (r < 0.3) {    
      PVector velocity = PVector.sub(source, position);
      //float ydir = (source.y-position.y);
      velocity.normalize();
      position.add(velocity);
      lifespan -= 0.4;
    } else {
      velocity = new PVector(random(-2, 2), random(-2, 2));
      //println(xdir);
      position.add(velocity);
      lifespan -= 0.4;
    }

    position.x = constrain(position.x, 0, width-1);
    position.y = constrain(position.y, 0, height-1);
  }
}