public class SimulationControlObject extends TickableGameObject
{
  public void Draw(){}
  
  public void Tick()
  {
    if(GameController.IsKeyPressed(LEFT))
    {
      GameController.SetTicksPerTick(constrain(GameController.GetTicksPerTick() - 10, 1, 1000));
    }
    else if(GameController.IsKeyPressed(RIGHT))
    {
      GameController.SetTicksPerTick(GameController.GetTicksPerTick() == 1 ? 10 : constrain(GameController.GetTicksPerTick() + 10, 1, 1000));
    }
  }
}
