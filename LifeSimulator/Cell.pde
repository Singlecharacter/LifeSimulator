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
    {
      r += amount;
      
      if(r < 0F)
        r = 0F;
      else if(r > MAX_RED)
        r = MAX_RED;
    }
    else if(resource == GREEN_RESOURCE)
    {
      g += amount;
      
      if(g < 0F)
        g = 0F;
      else if(g > MAX_GREEN)
        g = MAX_GREEN;
    }
    else if(resource == BLUE_RESOURCE)
    {
      b += amount;
      
      if(b < 0F)
        b = 0F;
      else if(b > MAX_BLUE)
        b = MAX_BLUE;
    }
  }
}
