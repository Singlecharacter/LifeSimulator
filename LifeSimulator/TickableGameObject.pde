public abstract class TickableGameObject extends GameObject
{
  public TickableGameObject()
  {
    super();
  }
  
  public TickableGameObject(String name)
  {
    super(name);
  }
  
  public abstract void Tick();
}
