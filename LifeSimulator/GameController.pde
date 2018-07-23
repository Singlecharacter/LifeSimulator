public static class GameController
{
  private static ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
  
  private static HashMap<Integer, Boolean> keysHeld = new HashMap<Integer, Boolean>();
  
  private static HashMap<Integer, Boolean> keysPressed = new HashMap<Integer, Boolean>();
  
  private static HashMap<Integer, Boolean> keysReleased = new HashMap<Integer, Boolean>();
  
  private static int ticksPerTick = 1;
  
  private static boolean removeAllObjects = false;
  
  private static ArrayList<GameObject> objectsToRemove = new ArrayList<GameObject>();
  
  public static void RegisterObject(GameObject gameObject)
  {
    gameObjects.add(gameObject);
  }
  
  public static void RemoveObject(GameObject gameObject)
  {
    objectsToRemove.add(gameObject);
  }
  
  public static void RemoveAllObjects()
  {
    removeAllObjects = true;
  }
  
  public static void Tick()
  {
    CleanupKeys();
    
    if(removeAllObjects)
      gameObjects.clear();
      
    for(GameObject go : objectsToRemove)
      gameObjects.remove(go);
      
    objectsToRemove.clear();
    
    for(int i = 0; i < ticksPerTick; i++)
    {
      for(GameObject go : gameObjects)
      {
        go.Tick();
        go.Draw();
      }
    }
    
    UpdateKeys();
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
    if(!keysHeld.containsKey(key))
    {
      keysPressed.put(key, false);
    }
    
    keysHeld.put(key, true);
  }
  
  public static void KeyReleased(int key)
  {
    keysReleased.put(key, false);
    keysHeld.remove(key);
  }
  
  public static boolean IsKeyPressed(int key)
  {
    return keysPressed.containsKey(key);
  }
  
  public static boolean IsKeyHeld(int key)
  {
    return keysHeld.containsKey(key);
  }
  
  public static boolean IsKeyReleased(int key)
  {
    return keysReleased.containsKey(key);
  }
  
  //Private methods
  
  private static void CleanupKeys()
  {
    for(int key : keysPressed.keySet())
    {
      if(keysPressed.get(key))
      {
        keysPressed.remove(key);
      }
    }
    
    for(int key : keysReleased.keySet())
    {
      if(keysReleased.get(key))
      {
        keysReleased.remove(key);
      }
    }
  }
  
  private static void UpdateKeys()
  {
    for(int key : keysPressed.keySet())
    {
      keysPressed.put(key, true);
    }
    
    for(int key : keysReleased.keySet())
    {
      keysReleased.put(key, true);
    }
  }
}
