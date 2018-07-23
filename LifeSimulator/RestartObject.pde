public class RestartObject extends GameObject
{
  public void Tick()
  {
    if(GameController.IsKeyPressed('R'))
    {
      simSetup.SetupSimulation();
    }
  }
  
  public void Draw(){}
}
