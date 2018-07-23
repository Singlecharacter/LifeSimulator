public static class GameController
{
  private static ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
  
  private static ArrayList<Integer> keysHeld = new ArrayList<Integer>();
  
  private static ArrayList<Integer> keysPressed = new ArrayList<Integer>();
  
  private static ArrayList<Integer> keysReleased = new ArrayList<Integer>();
  
  private static int ticksPerTick = 1;
  
  private static boolean canTick = true;
  
  public static void RegisterObject(GameObject gameObject)
  {
    gameObjects.add(gameObject);
  }
  
  public static void RemoveObject(GameObject gameObject)
  {
    gameObjects.remove(gameObject);
    gameObject.Destroy();
  }
  
  public static void RemoveAllObjects()
  {
    while(gameObjects.size() > 0)
      RemoveObject(gameObjects.get(0));
  }
  
  public static void Tick()
  {
    if(canTick)
    {
      for(int i = 0; i < ticksPerTick; i++)
      {
        for(int j = 0; j < gameObjects.size(); j++)
        {
          GameObject go = gameObjects.get(j);
          go.Tick();
          go.Draw();
        }
      }
    }
    
    CleanupKeys();
  }
  
  public static void SetTicksPerTick(int ticks)
  {
    ticksPerTick = ticks;
  }
  
  public static int GetTicksPerTick()
  {
    return ticksPerTick;
  }
  
  public static void KeyPressed(int key)
  {
    if(!keysHeld.contains(key))
    {
      keysPressed.add(key);
      keysHeld.add(key);
    }
  }
  
  public static void KeyReleased(int key)
  {
    keysReleased.add(key);
  }
  
  public static boolean IsKeyPressed(int key)
  {
    return keysPressed.contains(key);
  }
  
  public static boolean IsKeyHeld(int key)
  {
    return keysHeld.contains(key);
  }
  
  public static boolean IsKeyReleased(int key)
  {
    return keysReleased.contains(key);
  }
  
  //Private methods
  
  private static void CleanupKeys()
  {
    keysPressed.clear();
    
    for(int i = 0; i < keysHeld.size(); i++)
    {
      if(keysReleased.contains(keysHeld.get(i)))
        keysHeld.remove(i);
    }
    
    keysReleased.clear();
  }
}
