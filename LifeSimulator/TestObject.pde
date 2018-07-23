public class TestObject extends GameObject
{
  public TestObject()
  {
    super();
  }
  
  public TestObject(String name)
  {
    super(name);
  }
  
  public void Tick()
  {
    if(GameController.IsKeyPressed(' '))
    {
      println("Space pressed!");
    }
    else if(GameController.IsKeyReleased(' '))
    {
      println("Space released!");
    }
    else if(GameController.IsKeyHeld(' '))
    {
      println("Space held!");
    }
  }
  
  public void Draw()
  {
    rect(x - CELL_SIZE / 2F, y - CELL_SIZE / 2F, CELL_SIZE, CELL_SIZE);
  }
}
