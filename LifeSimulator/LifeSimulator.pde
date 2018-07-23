public final SimulationSetup simSetup = new SimulationSetup();

void setup()
{
  fullScreen();
  frameRate(FRAMERATE);
  rectMode(CENTER);
  ellipseMode(CENTER);
  colorMode(RGB, MAX_RED, MAX_GREEN, MAX_BLUE);
  
  simSetup.SetupSimulation();
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
