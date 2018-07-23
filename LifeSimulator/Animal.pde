public abstract class Animal extends TickableGameObject
{
  protected final float maxHealth;
  protected float currentHealth;
  
  protected final float minHealthyR, minHealthyG, minHealthyB,
                        maxHealthyR, maxHealthyG, maxHealthyB;
                  
  protected final int desiredResource;
  
  protected final float rDigestionRate, gDigestionRate, bDigestionRate;
  
  protected final float eatAmount;
                  
  protected final float unhealthyLossRate, healthyGainRate;
                
  protected float r, g, b;
                  
  protected final float rDecreaseRate, gDecreaseRate, bDecreaseRate;
  
  protected boolean isDying;
  protected boolean canEat;
                
  public Animal()
  {
    super();
    
    minHealthyR = MAX_RED * 0.25F;
    minHealthyG = MAX_GREEN * 0.25F;
    minHealthyB = MAX_BLUE * 0.25F;
    
    maxHealthyR = MAX_RED * 0.75F;
    maxHealthyG = MAX_GREEN * 0.75F;
    maxHealthyB = MAX_BLUE * 0.75F;
    
    rDecreaseRate = 1F;
    gDecreaseRate = 1F;
    bDecreaseRate = 1F;
    
    maxHealth = 500F;
    currentHealth = maxHealth;
    
    unhealthyLossRate = 1F;
    healthyGainRate = 1F;
    
    isDying = false;
    canEat = true;
    
    desiredResource = RED_RESOURCE;
    
    rDigestionRate = 1F;
    gDigestionRate = 1F;
    bDigestionRate = 1F;
    
    eatAmount = 5F;
  }
  
  public Animal(String name)
  {
    super(name);
    
    minHealthyR = MAX_RED * 0.25F;
    minHealthyG = MAX_GREEN * 0.25F;
    minHealthyB = MAX_BLUE * 0.25F;
    
    maxHealthyR = MAX_RED;
    maxHealthyG = MAX_GREEN;
    maxHealthyB = MAX_BLUE;
    
    rDecreaseRate = 1F;
    gDecreaseRate = 1F;
    bDecreaseRate = 1F;
    
    maxHealth = 500F;
    currentHealth = maxHealth;
    
    unhealthyLossRate = 1F;
    healthyGainRate = 1F;
    
    isDying = false;
    canEat = true;
    
    desiredResource = RED_RESOURCE;
    
    rDigestionRate = 1F;
    gDigestionRate = 1F;
    bDigestionRate = 1F;
    
    eatAmount = 5F;
  }
  
  public Animal(String name, float minHealthyR, float minHealthyG, float minHealthyB, 
                             float maxHealthyR, float maxHealthyG, float maxHealthyB,
                             float rDecreaseRate, float gDecreaseRate, float bDecreaseRate,
                             float rDigestionRate, float gDigestionRate, float bDigestionRate,
                             float eatAmount,
                             float maxHealth,
                             float unhealthyLossRate,
                             float healthyGainRate,
                             int desiredResource)
  {
    super(name);
    
    this.minHealthyR = minHealthyR;
    this.minHealthyG = minHealthyG;
    this.minHealthyB = minHealthyB;
    
    this.maxHealthyR = maxHealthyR;
    this.maxHealthyG = maxHealthyG;
    this.maxHealthyB = maxHealthyB;
    
    this.rDecreaseRate = rDecreaseRate;
    this.gDecreaseRate = gDecreaseRate;
    this.bDecreaseRate = bDecreaseRate;
    
    this.maxHealth = maxHealth;
    currentHealth = maxHealth;
    
    this.unhealthyLossRate = unhealthyLossRate;
    this.healthyGainRate = healthyGainRate;
    
    isDying = false;
    canEat = true;
    
    this.desiredResource = desiredResource;
    
    this.rDigestionRate = rDigestionRate;
    this.gDigestionRate = gDigestionRate;
    this.bDigestionRate = bDigestionRate;
    
    this.eatAmount = eatAmount;
  }
  
  public void Tick()
  {
    if(!isDying)
      LivingTick();
    else
      DyingTick();
  }
  
  public void LivingTick()
  {
    r = constrain(r - rDecreaseRate, 0F, MAX_RED);
    g = constrain(g - gDecreaseRate, 0F, MAX_GREEN);
    b = constrain(b - bDecreaseRate, 0F, MAX_BLUE);
    
    if(canEat)
    {
      float amountEaten = 0F;
      
      if(map.GetCell(x, y).GetResource(desiredResource) >= eatAmount)
      {
        map.GetCell(x, y).ChangeResource(desiredResource, -eatAmount);
        
        amountEaten = eatAmount;
      }
      else
      {
        amountEaten = map.GetCell(x, y).GetResource(desiredResource);
        map.GetCell(x, y).ChangeResource(desiredResource, -amountEaten);
      }
      
      r = constrain(r + (amountEaten * rDigestionRate), 0F, MAX_RED);
      g = constrain(g + (amountEaten * gDigestionRate), 0F, MAX_GREEN);
      b = constrain(b + (amountEaten * bDigestionRate), 0F, MAX_BLUE);
    }
    
    if(r >= minHealthyR && r <= maxHealthyR)
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    
    if(g >= minHealthyG && g <= maxHealthyG)
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    
    if(b >= minHealthyB && b <= maxHealthyB)
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    
    if(currentHealth == 0F)
    {
      isDying = true;
    }
  }
  
  public void DyingTick()
  {
    //Dump resources into underlying cell
    map.GetCell(x, y).ChangeResource(RED_RESOURCE, r);
    map.GetCell(x, y).ChangeResource(GREEN_RESOURCE, g);
    map.GetCell(x, y).ChangeResource(BLUE_RESOURCE, b);
    
    //Delete self
    GameController.RemoveObject(this);
  }
  
  public void Draw()
  {
    stroke(0F, 0F, 0F);
    fill(MAX_RED, 0F, 0F);
    rect(x, y - CELL_SIZE * 0.85F, CELL_SIZE, 4F);
    fill(0F, MAX_GREEN, 0F);
    rect(x, y - CELL_SIZE * 0.85F, CELL_SIZE * currentHealth / maxHealth, 4F);
  }
}
