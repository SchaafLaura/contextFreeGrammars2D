import java.util.Map;
RuleSet rules;
int iters = 9;
int dx = 2;
int dy = 2;
int cols = 6;

void setup() {
  size(1224, 1024);
  rules = new RuleSet(dx, dy, cols);
  char[][] iteration = rules.rndm(2, 2);
  iteration[0][0] = (char) 0;
  rules.iteration = iteration;
  for (int i = 0; i < iters; i++) {
    rules.iterate();
  }
}
void draw() {
  background(0);
  image(rules.saveImageOfIteration(rules.iteration, false), 0, 0);
  rules.show();
}
void mousePressed() {
  makeNewRule();
}
void keyPressed() {
  if (keyCode==ENTER)
    rules.makeColors();
  if (keyCode==UP)
    rules.saveImageOfIteration(rules.iteration, true);
  if (key == 'r')
    reseed();
}
void reseed() {
  char[][] iteration = rules.rndm(dx, dy);
  rules.iteration = iteration;
  for (int i = 0; i < iters; i++) {
    rules.iterate();
  }
}
void makeNewRule() {
  rules = new RuleSet(dx, dy, cols);
  reseed();
}
