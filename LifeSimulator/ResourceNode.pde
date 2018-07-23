public class ResourceNode
{
  private float rStrength, gStrength, bStrength;
  
  private float x, y;
  
  private float radius;
  
  public ResourceNode(float rStrength, float gStrength, float bStrength, float x, float y, float radius)
  {
    this.rStrength = rStrength;
    this.gStrength = gStrength;
    this.bStrength = bStrength;
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
  
  public float GetResourceStrength(int resource, float x, float y)
  {
    float distance = dist(this.x, this.y, x, y);
    float multiplier = (radius - distance) / radius;
    
    if(distance <= radius)
      return resource == RED_RESOURCE ? rStrength * multiplier : 
             resource == GREEN_RESOURCE ? gStrength * multiplier : 
             resource == BLUE_RESOURCE ? bStrength * multiplier : 
             0F;
    else
      return 0F;
  }
}
