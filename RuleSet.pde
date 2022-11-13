class RuleSet {
  HashMap<Character, char[][]> rules;
  int dimX;
  int dimY;
  char[] chars;
  HashMap<Character, Integer> colorMap;
  public char[][] iteration;
  int numOfRules;

  public RuleSet(int dimX, int dimY, int numOfRules) {
    this.numOfRules = numOfRules;
    this.dimX = dimX;
    this.dimY = dimY;
    this.rules = new HashMap<Character, char[][]>();
    char[] chars = new char[numOfRules];
    this.chars = chars;
    for (int i = 0; i < numOfRules; i++) {
      chars[i] = (char) i;
    }
    for (int i = 0; i < numOfRules; i++) {
      char[][] currRule = new char[dimX][dimY];
      for (int x = 0; x < dimX; x++) {
        for (int y = 0; y < dimX; y++) {
          currRule[x][y] = chars[(int) random(0, numOfRules)];
        }
      }
      rules.put(chars[i], currRule);
    }
  }
  public void iterate(){
    iteration = nextIteration(iteration);
  }
  public RuleSet(HashMap<Character, char[][]> rules, int dimX, int dimY) {
    this.rules = rules;
    this.dimX = dimX;
    this.dimY = dimY;
  }
  public char[][] nextIteration(char[][] previousIteration) {
    int dimXPrev = previousIteration.length;
    int dimYPrev = previousIteration[0].length;
    char[][] next = new char[dimXPrev * dimX][dimYPrev * dimY];
    for (int i = 0; i < dimXPrev; i++) {
      for (int j = 0; j < dimYPrev; j++) {
        char c = previousIteration[i][j];
        char[][] currentRule = rules.get(c);
        for (int x = 0; x < dimX; x++) {
          for (int y = 0; y < dimY; y++) {
            int xInNextIteration = i * dimX + x;
            int yInNextIteration = j * dimY + y;
            next[xInNextIteration][yInNextIteration] = currentRule[x][y];
          }
        }
      }
    }
    return next;
  }
  public char[][] rndm(int w, int h){
    char[][] ret = new char[w][h];
    for(int i = 0; i < w; i++){
      for(int j = 0; j < h; j++){
        ret[i][j] = chars[(int)random(0, numOfRules)];
      }
    }
    return ret;
  }
  public void makeColors() {
    colorMap = new HashMap<Character, Integer>();
    for (int i = 0; i < chars.length; i++) {
      colorMap.put(chars[i], color(random(0, 255), random(0, 255), random(0, 255)));
    }
  }
  public PGraphics saveImageOfIteration(char[][] iteration, Boolean save) {
    if (colorMap == null)
      makeColors();
    PGraphics toSave = createGraphics(iteration.length, iteration[0].length);
    toSave.beginDraw();
    toSave.loadPixels();
    for (int i = 0; i < toSave.width; i++) {
      for (int j = 0; j < toSave.height; j++) {
        char c = iteration[i][j];
        toSave.pixels[i + j * toSave.width] = colorMap.get(c);
      }
    }
    toSave.updatePixels();
    toSave.endDraw();
    if (save)
      toSave.save("rnd" + iteration.length + random(0, 100000000) + ".png");
    return toSave;
  }
  public void show() {
    fill(255);
    circle(1050, 50, 20);
  }
  public void saveImageOfIteration(char[][] iteration, HashMap<Character, Integer> colorMap) {
    PGraphics toSave = createGraphics(iteration.length, iteration[0].length);
    toSave.beginDraw();
    toSave.loadPixels();
    for (int i = 0; i < toSave.width; i++) {
      for (int j = 0; j < toSave.height; j++) {
        char c = iteration[i][j];
        toSave.pixels[i + j * toSave.width] = colorMap.get(c);
      }
    }
    toSave.updatePixels();
    toSave.endDraw();
    toSave.save("###" + iteration.length + ".png");
  }
}
