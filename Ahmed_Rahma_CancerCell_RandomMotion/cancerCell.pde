class cancerCell {
  //varibales
  float xpos, ypos;
  float tx, ty; //time on the time vs noise graph
  float diameter;
  float stepSize;
  //float xspeed, yspeed;
  //PVector vec1 = new PVector(width, height);

  //constructor, set values for all variables
  cancerCell() {
    xpos = random(0, width);
    ypos = random(0, height);
    tx = 5;
    ty = 10000;
    diameter = 40;
    stepSize = 2;
  }

  //Perlin noise
  void step() {
    xpos = map(noise(tx), 0, 1, 0, width ); 
    ypos = map(noise(ty), 0, 1, 0, height);

    //moving forward in time (time vs noise graph)
    tx += stepSize * (0.01);
    ty += stepSize * (0.01);
  }

  //move x,y position based on a random number -1,0,+1 (* magnitude of step deetermines by stepSize
  void randStep() {
    int xRand = int(random(3))-1; // 0, 1, 2
    xpos += stepSize * xRand ;
    int yRand = int (random(3)) -1 ; // 0, 1, 2
    ypos += stepSize * yRand;
  }

  //displays the cancerCell as a red circle with four lines comign out of it
  void display() {
    fill(200, 0, 0);
    ellipse(xpos, ypos, diameter, diameter);
    fill(0);
    line(xpos + diameter/2, ypos, xpos + diameter, ypos);
    line(xpos - diameter/2, ypos, xpos - diameter, ypos);
    line(xpos, ypos + diameter/2, xpos, ypos + diameter);
    line(xpos, ypos - diameter/2, xpos, ypos - diameter);
  }
}


//void bounce(){ //future direction

//}

//random step
    //xRand = 1;
    //if((xpos += stepSize * xRand) < 0 || (xpos += stepSize * xRand) > width-diameter/2){
    //  xpos += -1* (stepSize * xRand);
    //}else{
    //}
    
    //float xRand = random(-1,1); // 0, 1, 2
    //xpos += xRand ;
    //float yRand = random(-1,1); // 0, 1, 2
    //ypos += yRand;
/*   
 void display() { //using vectors
 fill(200, 0, 0);
 ellipse(vec1.x, vec1.y, diameter, diameter);
 line(vec1.x + diameter/2, vec1.y, vec1.x + diameter, vec1.y);
 line(vec1.x - diameter/2, vec1.y, vec1.x - diameter, vec1.y);
 line(vec1.x, vec1.y + diameter/2, vec1.x, vec1.y + diameter);
 line(vec1.x, vec1.y - diameter/2, vec1.x, vec1.y - diameter);
 }
 float rand = random(tx);
 float yrand = random(ty);
 xpos = map(rand, 0, tx, 0, width); 
 ypos = map(yrand, 0, ty, 0, height);
 */