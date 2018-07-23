public abstract class Animal extends GameObject
{
  protected float maxHealth, currentHealth;
  
  protected float minHealthyR, minHealthyG, minHealthyB,
                  maxHealthyR, maxHealthyG, maxHealthyB;
                  
  protected float unhealthyLossRate, healthyGainRate;
                
  protected float r, g, b;
                  
  protected float rDecreaseRate, gDecreaseRate, bDecreaseRate;
  
  protected boolean isDying;
                
  public Animal()
  {
    super();
    
    minHealthyR = 0F;
    minHealthyG = 0F;
    minHealthyB = 0F;
    
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
  }
  
  public Animal(String name)
  {
    super(name);
    
    minHealthyR = 0F;
    minHealthyG = 0F;
    minHealthyB = 0F;
    
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
  }
  
  public Animal(String name, float minHealthyR, float minHealthyG, float minHealthyB, 
                             float maxHealthyR, float maxHealthyG, float maxHealthyB,
                             float rDecreaseRate, float gDecreaseRate, float bDecreaseRate,
                             float maxHealth,
                             float unhealthyLossRate)
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
    
    isDying = false;
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
    
    if(r >= minHealthyR && r <= maxHealthyR)
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    
    if(g >= minHealthyG && g <= maxHealthyG)
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    
    if(b >= minHealthyB && b <= maxHealthyB)
    {
      currentHealth = constrain(currentHealth - unhealthyLossRate, 0F, maxHealth);
    }
    else
    {
      currentHealth = constrain(currentHealth + healthyGainRate, 0F, maxHealth);
    }
    
    if(currentHealth == 0F)
    {
      isDying = true;
    }
  }
  
  public void DyingTick()
  {
    GameController.RemoveObject(this);
  }
}
