//CellWalker Class

class CellWalker {
  float symprob;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float telomeres;  //this can be used as the fitness
  float lifespan;  //or this (or both?)

  float recordDist;   // How close did it get to the target
  float fitness;

  boolean hitTarget = false; //reached target?
  int finishTime;
  color c;

  CellWalker(PVector p) {
    //Constructor - initialization
    //Define initial location
    acceleration = new PVector();
    position = p.copy();
    velocity = new PVector(0, 0);

    lifespan = random(50, 100);
    fitness = lifespan;
    telomeres = random(10, 20);
    c = color(random(255), random(255), random(255));

    finishTime = 0;
    recordDist = 1000;
  }

  //likelihood of being in the next generation
  void fitness() {
    if (recordDist < 1) recordDist = 1;
    //ADD THIS BUT USE TELOMERES OR LIFESPAN???
    //fitness = (1/(finishTime*recordDist)); //Reward finishing faster and getting close
    //fitness = pow(fitness, 4); //exponential function
    //////float rand = random(1);
    ///// if(rand<0.01) telomeres *=0.1; //lose some fitness randomly
    if (hitTarget) {
      lifespan *= 2; //lives longer if it is good at finishing
      fitness  *= 1.5;
    }
  }

  //MUTATE FROM DNA CLASS? --> effects the cell's lifespan and or symprob or telomeres
  // Picks a new random Vector
  void mutate() { //m-->mutationRate from tumor/population
    applyForce(new PVector(random(-2, 2), random(-2, 2)));
    //println(xdir);
    lifespan -= 0.4;
    telomeres -=0.5;
    position.x = constrain(position.x, 0, width-1);
    position.y = constrain(position.y, 0, height-1);
    update();
  }

  // Did I make it to the target?
  void checkTarget() {
    float closestTarget = 700;
    for (int i = 0; i <source.length; i++) {
      float d = dist(position.x, position.y, source[i].x, source[i].y);
      if (d < closestTarget) {
        closestTarget = d;
      }
    }
    if (closestTarget < recordDist) recordDist = closestTarget;

    if (closestTarget<1 && !hitTarget) {
      hitTarget = true;
    } else if (!hitTarget) {
      finishTime++;
    }
  }

  //COUDL MAKE IT ROTATE SO IT IS MOE ACCURATE
  void display() {
    //display as a stroke - point
    float x = position.x;
    float y = position.y;
    //Draw Cell Body
    fill(155);
    ellipse(x, y, 30, 20);

    //Draw Cell nucleus
    fill(c);
    ellipse(x, y, 11, 8);

    //Draw Cell Receptors
    stroke(0);
    line(x-15, y, x-20, y-5);
    line(x-15, y-5, x-20, y-7);
    line(x+15, y, x+20, y-5);
  }

  void run(float mRate) {
    if (!hitTarget) {
      step();
    }
    //likelihood of a mutation
    if (random(1) < mRate + 0.2) { //+ 0.2
      mutate();
    }
    display();     // Draw me!
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
    CellWalker cell = new CellWalker(position);
    cell.c = this.c; 
    cell.telomeres = telomeres;
    telomeres--;
    return cell;
  }

  void step() {
    float r = random(1);
    //// A 30% of moving towards a source
    if (r < 0.3) {  
      PVector closestTarget = new PVector (700, 700);
      for (int i = 0; i <source.length; i++) {
        float d = dist(position.x, position.y, source[i].x, source[i].y);
        if (d < closestTarget.mag()) {
          closestTarget = source[i];
        }
      }
      PVector velocity = PVector.sub(closestTarget, position);
      //float ydir = (source.y-position.y);
      velocity.normalize();
      lifespan -= 0.4;
    } else {
      velocity = new PVector(random(-2, 2), random(-2, 2));
    }
    update();
    checkEdges();
    display();
    position.x = constrain(position.x, 0, width-1);
    position.y = constrain(position.y, 0, height-1);
  }

  float getFitness() {
    return fitness;
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }
  void checkEdges(){
  if (position.x > width) { position.x = width - 5;}
  else if (position.x < 0) { position.x = 5;}
  if (position.y > height) { position.x = height - 5;}
  else if (position.y < 0) { position.y = 5;}
  
  }
  
}