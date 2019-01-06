import java.util.Iterator;

class Tumor {
  //int total = 1;
  //Tumor is essentially an ArrayList of type CellWalker
  ArrayList<CellWalker> cellArr = new ArrayList<CellWalker>();
  float prolif = 0.02;
  float mutationRate;          // Mutation rate
  int generations;             // Number of generations

  //Initialize the population
  Tumor(float m) {
    mutationRate = m;
    generations = 0;
    //add 10 cells to begin population
    for (int i = 0; i< 10; i++) {
      PVector position = new PVector(width/2, height);
      cellArr.add(new StemCell(position));
    }
  }

  boolean isPSDead() {
    return (cellArr.size() <= 0);
  }

  void live() {
    for (int i = 0; i < cellArr.size(); i++) {
      // If it finishes, mark it down as done!
      cellArr.get(i).checkTarget();
      cellArr.get(i).run(mutationRate);
    }
  }

  //anything finished??
  boolean targetReached() {
    for (int i = 0; i < cellArr.size(); i++) {
      if (cellArr.get(i).hitTarget) {
        cellArr.get(i).fitness(); 
        return true;
      }
    }
    return false;
  }

  void run() {
    ArrayList<CellWalker> bornArr = new ArrayList<CellWalker>();
    Iterator<CellWalker> cellIt = cellArr.iterator();
    ArrayList<CellWalker> deadArr = new ArrayList<CellWalker>();
    while (cellIt.hasNext()) {
      //for (Iterator<CellWalker> cellIt = cellArr.iterator(); cellIt.hasNext();) {
      CellWalker currentCell = cellIt.next();
      currentCell.run(mutationRate);

      //if CellWalker still has telomeres, it has a prolif probability of reproducing
      //a cell that will be added to the array
      if (currentCell.telomeres > 0) {
        if (random(1) < prolif) {
          CellWalker newCell = currentCell.reproduce();
          newCell.c = currentCell.c; 
          bornArr.add(newCell);
          //newCell.run();
        }
      }
      currentCell.telomeres --; //decrease telomeres by 1 each iteration
      if (currentCell.isDead()) { 
        deadArr.add(currentCell);
        cellIt.remove();
      } // if cell is dead, remove
    }
    generations++;
    cellArr.addAll(bornArr);
    cellArr.removeAll(deadArr);
  }

  int getGenerations() {
    return generations;
  }
  // Calculate fitness for each creature
  void fitness() {
    for (int i = 0; i < cellArr.size(); i++) {
      cellArr.get(i).fitness();
    }
  }
}