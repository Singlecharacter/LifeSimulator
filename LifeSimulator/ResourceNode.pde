public class ResourceNode
{
  private float r, g, b;
  
  private float x, y;
  
  private float radius;
  
  public ResourceNode(float r, float g, float b, float x, float y, float radius)
  {
    this.r = r;
    this.g = g;
    this.b = b;
    this.x = x;
    this.y = y;
    this.radius = radius;
  }
  
  public float GetResourceStrength(int resource, float x, float y)
  {
    float distance = dist(this.x, this.y, x, y);
    float multiplier = 1F / pow(distance, 2);
    
    if(distance <= radius)
      return resource == RED_RESOURCE ? r * multiplier : 
             resource == GREEN_RESOURCE ? g * multiplier : 
             resource == BLUE_RESOURCE ? b * multiplier : 
             0F;
    else
      return 0F;
  }
}
