class StemCell extends CellWalker {

  StemCell(PVector p) {
    super(p);
    lifespan = 255;
    telomeres = 255;
    symprob = random(0.3);
  }

  void display() {
    //display as a stroke - point
    float x = position.x;
    float y = position.y;
    //Draw Cell Body
    fill(0, 160, 160);
    ellipse(x, y, 30, 20);

    //Draw Cell nucleus
    float eyeR = int(lifespan);
    float eyeG = int(lifespan);
    float eyeB = 255;
    //fill(eyeR, eyeG, eyeB); //nucleus depends on random variables
    fill(c);
    ellipse(x, y, 11, 8);

    //Draw Cell Receptors
    stroke(0);
    //receptors depend on old mouse position
    line(x-15, y, x-20, y-5);
    line(x-15, y-5, x-20, y-7);
    line(x+15, y, x+20, y-5);
  }
  
  // reproduce either a stemCell or a cellWalker
  CellWalker reproduce() {
    CellWalker newCell;
    if (random(1) <= symprob) {
      //add a new StemCell to the grid
      newCell = new StemCell(position);
    } else {
      //add a new CellWalker to the grid
      newCell = new CellWalker(position);
      //newCell.telomeres = telomeres;
    }
    newCell.symprob = this.symprob;
    telomeres--;
    return newCell;
  }
}