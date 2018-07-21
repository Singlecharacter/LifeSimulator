public abstract class GameObject
{
  protected String name;
  
  public GameObject()
  {
    this.name = "NONE";
    GameController.RegisterObject(this);
  }
  
  public GameObject(String name)
  {
    this.name = name;
    GameController.RegisterObject(this);
  }
  
  public abstract void Tick();
  
  public abstract void Draw();
}
