cancerCell leuk = new cancerCell();
cancerCell[] leuks; 
float foodx;
float foody;
float foodDiam;
float medicinex;
float mediciney;
float medicineDiam;

void setup() {
  size(400, 400);
  background(200);
  foodDiam = 50;
  medicineDiam = 50;
  //makes sure the square is only within the bounds
  foodx = random(foodDiam/2, width-foodDiam/2);  
  foody = random(foodDiam/2, height-foodDiam/2);
  medicinex = random(medicineDiam/2, width - medicineDiam/2);
  mediciney = random(medicineDiam/2, height-medicineDiam/2); 
  leuks = new cancerCell[10]; 

  for (int num = 0; num <10; num++) {
    leuks[num] = new cancerCell();
  }
}

void draw() {
  //fill(#67d7fc);
  fill(#7af3ff);
  rectMode(CENTER);
  rect(foodx, foody, foodDiam, foodDiam);
  //if mouse pressed, choose random stepSize between 0 and 10
  fill(#a9f218);
  rect(medicinex, mediciney, medicineDiam, medicineDiam);
  fill(0);

  for (int num = 0; num <10; num++) {
    leuks[num].display();
    if (mousePressed) {
      float rand = random(10);  
      leuks[num].stepSize = rand;
    }
    float rand = random(1);
    if (rand >= 0.7) 
      leuks[num].randStep();
    else if (rand > 0.25)
      leuks[num].foodStep();
    else
      leuks[num].medicineStep();
  }
}