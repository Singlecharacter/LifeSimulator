public class Cell extends GameObject
{
  private float r, g, b;
  
  public Cell()
  {
    super();
    r = 0;
    g = 0;
    b = 0;
  }
  
  public Cell(String name)
  {
    super(name);
    r = 0;
    g = 0;
    b = 0;
  }
  
  public Cell(String name, float r, float g, float b)
  {
    super(name);
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public void Draw()
  {
    fill(r, g, b);
    stroke(r, g, b);
    
    rect(x, y, CELL_SIZE, CELL_SIZE);
  }
  
  public void Tick()
  {
    
  }
  
  public void ChangeResource(int resource, float amount)
  {
    if(resource == RED_RESOURCE)
      r = constrain(r + amount, 0F, MAX_RED);
    else if(resource == GREEN_RESOURCE)
      g = constrain(g + amount, 0F, MAX_GREEN);
    else if(resource == BLUE_RESOURCE)
      b = constrain(b + amount, 0F, MAX_BLUE);
  }
  
  public void SetResource(int resource, float amount)
  {
    if(resource == RED_RESOURCE)
      r = constrain(amount, 0F, MAX_RED);
    else if(resource == GREEN_RESOURCE)
      g = constrain(amount, 0F, MAX_GREEN);
    else if(resource == BLUE_RESOURCE)
      b = constrain(amount, 0F, MAX_BLUE);
  }
  
  public void SetAllResources(float r, float g, float b)
  {
    this.r = constrain(r, 0F, MAX_RED);
    this.g = constrain(g, 0F, MAX_GREEN);
    this.b = constrain(b, 0F, MAX_BLUE);
  }
  
  public float GetResource(int resource)
  {
    return resource == RED_RESOURCE ? r :
           resource == GREEN_RESOURCE ? g :
           resource == BLUE_RESOURCE ? b :
           0;
  }
}
