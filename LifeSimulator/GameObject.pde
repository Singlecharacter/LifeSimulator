public abstract class GameObject
{
  public final String name;
  
  protected float x, y;
  
  public GameObject()
  {
    this.name = "NONE";
    this.x = 0;
    this.y = 0;
    GameController.RegisterObject(this);
  }
  
  public GameObject(String name)
  {
    this.name = name;
    GameController.RegisterObject(this);
  }
  
  public void SetX(float value)
  {
    this.x = value;
  }
  
  public float GetX()
  {
    return x;
  }
  
  public void SetY(float value)
  {
    this.y = value;
  }
  
  public float GetY()
  {
    return y;
  }
  
  public void SetPosition(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  public abstract void Tick();
  
  public abstract void Draw();
}
