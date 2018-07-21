void setup()
{
  fullScreen();
  frameRate(144);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  new TestObject("Object 1");
}

void draw()
{
  GameController.Tick();
}

void keyPressed()
{
  GameController.KeyPressed(keyCode);
}

void keyReleased()
{
  GameController.KeyReleased(keyCode);
}
