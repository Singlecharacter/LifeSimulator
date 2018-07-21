public static class GameController
{
  private static ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
  
  private static HashMap<Integer, Boolean> keysHeld = new HashMap<Integer, Boolean>();
  
  private static HashMap<Integer, Boolean> keysPressed = new HashMap<Integer, Boolean>();
  
  private static HashMap<Integer, Boolean> keysReleased = new HashMap<Integer, Boolean>();
  
  public static void RegisterObject(GameObject gameObject)
  {
    gameObjects.add(gameObject);
  }
  
  public static void Tick()
  {
    CleanupKeys();
    
    for(GameObject go : gameObjects)
    {
      go.Tick();
      go.Draw();
    }
    
    UpdateKeys();
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
