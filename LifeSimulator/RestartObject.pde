public class RestartObject extends TickableGameObject
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
