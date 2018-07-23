void setup()
{
  fullScreen();
  frameRate(FRAMERATE);
  rectMode(CENTER);
  ellipseMode(CENTER);
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
