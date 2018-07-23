public class Walker extends Animal
{
  public Walker()
  {
    super();
  }
  
  public Walker(String name)
  {
    super(name);
  }
  
  public Walker(String name, float minHealthyR, float minHealthyG, float minHealthyB, 
                             float maxHealthyR, float maxHealthyG, float maxHealthyB,
                             float rDecreaseRate, float gDecreaseRate, float bDecreaseRate,
                             float rDigestionRate, float gDigestionRate, float bDigestionRate,
                             float eatAmount,
                             float maxHealth,
                             float unhealthyLossRate,
                             float healthyGainRate,
                             int desiredResource)
  {
    super(name, minHealthyR, minHealthyG, minHealthyB,
                maxHealthyR, maxHealthyG, maxHealthyB,
                rDecreaseRate, gDecreaseRate, bDecreaseRate,
                rDigestionRate, gDigestionRate, bDigestionRate,
                eatAmount,
                maxHealth,
                unhealthyLossRate,
                healthyGainRate,
                desiredResource);
  }
  
  public void Tick()
  {
    super.Tick();
    
    //No more edible resource, time to move
    if(map.GetCell(x, y).GetResource(desiredResource) <= 0F)
    {
      int moveDirection = (int)random(NORTH, WEST + 1);
      
      switch(moveDirection)
      {
        case NORTH:
          if(y - CELL_SIZE >= 0F)
            y -= CELL_SIZE;
          break;
          
        case EAST:
          if(x + CELL_SIZE <= MAP_WIDTH)
            x += CELL_SIZE;
          break;
          
        case SOUTH:
          if(y + CELL_SIZE <= MAP_HEIGHT)
            y += CELL_SIZE;
          break;
          
        case WEST:
          if(x - CELL_SIZE >= 0F)
            x -= CELL_SIZE;
          break;
          
        default:
          break;
      }
    }
  }
  
  public void Draw()
  {
    super.Draw();
    
    stroke(0F, 0F, 0F);
    fill(r, g, b);
    ellipse(x, y, CELL_SIZE, CELL_SIZE);
  }
}
