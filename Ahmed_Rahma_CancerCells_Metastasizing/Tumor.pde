import java.util.Iterator;

class Tumor {
  //int total = 1;
  //Tumor is essentially an ArrayList of type CellWalker
  ArrayList<CellWalker> cellArr = new ArrayList<CellWalker>();
  float prolif = 0.02;

  Tumor(PVector p) {
    //for(int i = 0; i< total; i++){
    cellArr.add(new CellWalker(p));
    cellArr.add(new StemCell(p));
  }

  boolean isPSDead() {
    return (cellArr.size() <= 0);
  }

  void run() {
    ArrayList<CellWalker> bornArr = new ArrayList<CellWalker>();
    Iterator<CellWalker> cellIt = cellArr.iterator();
    while (cellIt.hasNext()) {
      //for (Iterator<CellWalker> cellIt = cellArr.iterator(); cellIt.hasNext();) {
      CellWalker currentCell = cellIt.next();
      currentCell.run();

      //if CellWalker still has telomeres, it has a prolif probability of reproducing
      //a cell that will be added to the array
      if (currentCell.telomeres > 0) {
        if (random(1) < prolif) {
          CellWalker newCell = currentCell.reproduce();
          bornArr.add(newCell);
          //newCell.run();
        }
      }
      currentCell.telomeres --; //decrease telomeres by 1 each iteration
      if(currentCell.isDead()){ cellIt.remove();} // if cell is dead, remove
    }
    cellArr.addAll(bornArr);
  }
}