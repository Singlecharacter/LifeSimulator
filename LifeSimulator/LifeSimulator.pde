public final SimulationSetup simSetup = new SimulationSetup(NODES | NOISE);

public Map map = new Map();

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
