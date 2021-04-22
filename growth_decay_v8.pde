//repetitive waves fixed
//similar effect can be achieved by holding an appropriate key, sans R
//this version compensates for the random generation favoring the right and down directions
//this version allows for multiple starting activation points
//this version has minimal speed drops due to limiting the life span of active cells
//this version has an unintended side effect of creating spirals on certain random generations
//spirals can now be intentionally created by changing the activationChance to 70 and reverting back to 60
//toggle activation with A key, causing current cells to die out, making a fading effect
//rainbow enabled! Whether the rain effect occurs is controlled by rainbowFlag. It is currently not a gradient :(

int cellSize = 5;
//frames per second
int speed = 100;
int activationChance = 60;
Boolean growthFlag = true;
Boolean rainbowFlag = true;
ArrayList<ArrayList<Cell>> cells = new ArrayList<ArrayList<Cell>>();

void setup() {
  size(800, 800);
  noStroke();
  frameRate(speed);

  for (int y = 0; y < height; y+=cellSize) {
    ArrayList<Cell> oneD = new ArrayList<Cell>();
    for (int x = 0; x < width; x+=cellSize) {
      oneD.add(new Cell(x, y, cellSize, rainbowFlag));
    }
    cells.add(oneD);
  }
};


void draw() {
  background(0);
  for (int row = 0; row < cells.size(); row++) {
    for (int col = 0; col < cells.get(0).size(); col++) {
      if (growthFlag) {
        if (cells.get(row).get(col).activeStatus()) {
          //chance to activate other cells
          int randChance = round(random(0, 1));
          if (randChance == 0 && cells.get(row).get(col).giveLifeLeft() > activationChance) {

            //up, right, down, left
            Boolean[] openCells = new Boolean[4];
            PVector[] cellPos = new PVector[4];

            //check up
            cellPos[0] = new PVector(col, row-1);

            if (row == 0) {
              openCells[0] = false;
            } else if (cells.get(row - 1).get(col).activeStatus()) {
              openCells[0] = false;
            } else {
              openCells[0] = true;
            }

            //check right
            cellPos[1] = new PVector(col + 1, row);

            if (col == cells.get(0).size() - 1) {
              openCells[1] = false;
            } else if (cells.get(row).get(col + 1).activeStatus()) {
              openCells[1] = false;
            } else {
              openCells[1] = true;
            }

            //check down
            cellPos[2] = new PVector(col, row+1);

            if (row == cells.size() - 1) {
              openCells[2] = false;
            } else if (cells.get(row + 1).get(col).activeStatus()) {
              openCells[2] = false;
            } else {
              openCells[2] = true;
            }

            //check left
            cellPos[3] = new PVector(col - 1, row);

            if (col == 0) {
              openCells[3] = false;
            } else if (cells.get(row).get(col - 1).activeStatus()) {
              openCells[3] = false;
            } else {
              openCells[3] = true;
            }

            for (int i = 0; i < 4; i++) {
              if (openCells[i]) {
                if (i == 0 || i == 3) {
                  randChance = round(random(0, 1));
                } else {
                  randChance = round(random(0, 2));
                }            
                if (randChance == 0) {
                  cells.get(int(cellPos[i].y)).get(int(cellPos[i].x)).activate();
                }
              }
            }
          }
        }
      }
      if (cells.get(row).get(col).activeStatus()){
        cells.get(row).get(col).update();
        cells.get(row).get(col).drawCell();
      }
    }
  }
};


void keyPressed() {
  //space is middle
  if (key == 32) {
    cells.get(floor(cells.size()/2)).get(floor(cells.get(0).size()/2)).activate();
  } else if (keyCode == UP) {
    cells.get(0).get(floor(cells.get(0).size()/2)).activate();
  } else if (keyCode == RIGHT) {
    cells.get(floor(cells.size()/2)).get(cells.get(0).size() - 1).activate();
  } else if (keyCode == DOWN) {
    cells.get(cells.size() - 1).get(floor(cells.get(0).size()/2)).activate();
  } else if (keyCode == LEFT) {
    cells.get(floor(cells.size()/2)).get(0).activate();

    //R key, random spot
  } else if (key == 82 || key == 114) {
    int randRow = floor(random(cells.size()));
    int randCol = floor(random(cells.get(0).size()));
    cells.get(randRow).get(randCol).activate();

    //C key, clears screen
  } else if (key == 67 || key == 99) {
    deactivateAll();

    //A key, toggle activation
  }else if(key == 65 || key == 97){
    if(growthFlag){
      growthFlag = false;
    }else{
      growthFlag = true;
    }
    
    //F key, toggle rainbow
  } else if (key == 70 || key == 102){
    rainbowFlagSwitch();
    //minus, decrease activationChance
  } else if (key == 45) {
    if (activationChance > 60) {
      activationChance -= 5;
      println(activationChance);
    }
    //plus, increase activationChance
  } else if (key == 43) {
    if (activationChance < 70) {
      activationChance += 5;
      println(activationChance);
    }
  }
};


//deactivates all cells
void deactivateAll() {
  for (int row = 0; row < cells.size(); row++) {
    for (int col = 0; col < cells.get(row).size(); col++) {
      cells.get(row).get(col).deactivate();
    }
  }
};

void rainbowFlagSwitch(){
  for (int row = 0; row < cells.size(); row++) {
    for (int col = 0; col < cells.get(row).size(); col++) {
      cells.get(row).get(col).rainbowFlagChange();
    }
  }
};
