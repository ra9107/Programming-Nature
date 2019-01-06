cancerCell[] leuks; 
attractor blood;
float rand;

/*

Extra credit: You are a researcher studying neuron cell guidance. 
Create a path you want your neuron to take to get to a source of nutrients. 
Setup different ECMs in your background to “guide” your neuron to take that path
to the source. Keep a record of how many times your neuron reaches the source 
without straying off the path. 

*/

void setup() {
  size(500, 300);
  leuks = new cancerCell[25]; 
  //initialize each cancer cell in array
  for (int num = 0; num < leuks.length; num++) {
    leuks[num] = new cancerCell();
  }
  blood = new attractor();//blood vessel 
}

void draw() {
  background(200);
  rand = random(1);
  ECMb();
  //ECMb();
  //ECMc();
  blood.display();

  println(frameCount);//count frames to make graph
  for (int num = 0; num < leuks.length; num++) {
    PVector attractForce = blood.attract(leuks[num]);//force of bloodvessel attraction
    leuks[num].applyForce(attractForce);//apply atrractor's force
    leuks[num].display();
    leuks[num].update();

    PVector leuksPos = leuks[num].position.copy();
    float radius = (blood.diam)/2;
    //cells experience drag once inside blood vessel
    if ((leuksPos.x < radius) && (leuksPos.y > 150 - radius && leuksPos.y < 150 + radius)) {
      leuks[num].drag(blood);
      //stop();//stop once the cells reach the bloodvessel to get frame count
    }
  }
}

//ECMs (a, b, c) each have friction and a random vector that's applied as a force
//on the cell affecting the direction of movement

void ECMa() {
  fill(52, 240, 249); //blue EMC
  rect(0, 0, width, height);

  //rect(width/2, height/2, 50, 50); //EXTRA CREDIT
  //only apply friction and stuff when its inside the ECM
  //counter for how many times it goes inside the ECM

  //for loop setting the friction and a random force applied (when its in the ECM)
  for (int num = 0; num <leuks.length; num++) {
    float coeff = 0.05; //friction coefficient
    PVector friction = leuks[num].velocity.copy(); //copy the velocity of cell
    friction.mult(-1); //bc friciton is opposite of velocity
    friction.normalize();
    friction.mult(coeff);
    leuks[num].applyForce(friction);
    //applies a random force
    if (rand<0.1) { //1% chnace of random force beign applied to change direction
      float randx = random(-0.8, -0.1);
      float randy = random(-0.8, -0.1);
      leuks[num].applyForce(new PVector(randx, randy));
    }
  }
}

void ECMb() {
  fill(150, 249, 52); //green EMC
  rect(0, 0, width, height);

  //rect(width - 100, height/4, 50, 50); //EXTRA CREDIT


  //for loop setting the friction and apply 
  for (int num = 0; num <leuks.length; num++) {
    float coeff = 0.2;  
    PVector friction = leuks[num].velocity.copy(); //copy the velocity 
    friction.mult(-1);
    friction.normalize();
    friction.mult(coeff);
    leuks[num].applyForce(friction);
    //applies a random force
    if (rand<0.1) { 
      float randx = random(-0.8, 0.8);
      float randy = random(-0.8, 0.8);
      leuks[num].applyForce(new PVector(randx, randy));
    }
  }
}

void ECMc() {
  fill(203, 52, 249); //purple EMC
  rect(0, 0, width, height);

  //rect(width/5, height/5, 50, 50); //EXTRA CREDIT

  //for loop setting the friction and apply 
  for (int num = 0; num <leuks.length; num++) {
    float coeff = 0.3; 
    PVector friction = leuks[num].velocity.copy(); //copy the velocity 
    friction.mult(-1);
    friction.normalize();
    friction.mult(coeff);
    leuks[num].applyForce(friction);
    //applies a random force
    if (rand<0.1) { 
      float randx = random(0.1, 0.75);
      float randy = random(-0.1, -0.75);
      leuks[num].applyForce(new PVector(randx, randy));
    }
  }
}