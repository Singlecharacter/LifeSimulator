public abstract class GameObject
{
  public final String name;
  
  private boolean destroyed;
  
  protected float x, y;
  
  public GameObject()
  {
    this.name = "NONE";
    this.x = 0;
    this.y = 0;
    GameController.RegisterObject(this);
    destroyed = false;
  }
  
  public GameObject(String name)
  {
    this.name = name;
    GameController.RegisterObject(this);
    destroyed = false;
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
  
  public void Destroy()
  {
    destroyed = true;
  }
  
  public boolean Destroyed()
  {
    return destroyed;
  }
  
  public abstract void Draw();
}
