//red -> purple
color[] rainbow = {color(255,0,0), color(255,127,0), color(255,255,0), color(0,255,0), color(0,0,255), color(75,0,130)};

class Cell {
  int xPos;
  int yPos;
  int cellSize;
  color cellColor;
  int lifeSpan;
  int lifeLeft;
  Boolean active;
  Boolean rainbowFlag;

  //cell object with position and cellSize (uniform)
  Cell(int xPos, int yPos, int cellSize) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.cellSize = cellSize;
    this.rainbowFlag = false;
    this.cellColor = color(255);

    this.lifeSpan = 75;
    this.lifeLeft = this.lifeSpan;
    this.active = false;
  }

  //cell object with rainbowFlag
  Cell(int xPos, int yPos, int cellSize, Boolean rainbowFlag) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.cellSize = cellSize;
    this.rainbowFlag = rainbowFlag;
    if(this.rainbowFlag){
      this.cellColor = rainbow[0];
    }else{
      this.cellColor = color(255);
    }
    
    this.lifeSpan = 75;
    this.lifeLeft = this.lifeSpan;
    this.active = false;
  }

  public void activate() {
    this.active = true;
    this.lifeLeft = this.lifeSpan;
  }

  void deactivate() {
    this.active = false;
  }
  
  void rainbowFlagChange(){
    if(this.rainbowFlag){
      this.rainbowFlag = false;
    }else{
      this.rainbowFlag = true;
    }
  };

  Boolean activeStatus() {
    return this.active;
  }

  int giveLifeLeft() {
    return this.lifeLeft;
  };

  void update() {
    if (this.lifeLeft <= 0) {
      this.deactivate();
    } else {
      this.lifeLeft--;
    }
    
    if(this.rainbowFlag){
      if(this.lifeLeft <= 0){
        this.cellColor = color(0);
      }else if(this.lifeLeft < (this.lifeSpan/6)*1){
        this.cellColor = rainbow[5];
      }else if(this.lifeLeft < (this.lifeSpan/6)*2){
        this.cellColor = rainbow[4];
      }else if(this.lifeLeft < (this.lifeSpan/6)*3){
        this.cellColor = rainbow[3];
      }else if(this.lifeLeft < (this.lifeSpan/6)*4){
        this.cellColor = rainbow[2];
      }else if(this.lifeLeft < (this.lifeSpan/6)*5){
        this.cellColor = rainbow[1];
      }else{
        this.cellColor = rainbow[0];
      }
    }else{
      this.cellColor = color(255);
    }
  }

  void drawCell() {
    int mappedClr = this.lifeLeft;
    if(!rainbowFlag){
      fill(this.cellColor, map(mappedClr, 0, this.lifeSpan, 0, 255));
    }else{
      fill(this.cellColor);
    }
    
    rect(this.xPos, this.yPos, this.cellSize, this.cellSize);
  }
}
