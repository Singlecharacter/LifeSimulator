public class SimulationSetup
{  
  private final int numberOfNodes = 20;
  
  private final int numberOfWalkers = 100;
  
  private final float noiseScale = 0.02F;
  
  private final float minNodeRadius = 100F;
  private final float maxNodeRadius = 500F;
  
  private final float noiseMultiplier = 0.75F;
  
  private final float minNodeRStrength = MAX_RED * 0.05F;
  private final float maxNodeRStrength = MAX_RED * 0.45F;
  
  private final float minNodeGStrength = MAX_GREEN * 0.05F;
  private final float maxNodeGStrength = MAX_GREEN * 0.45F;
  
  private final float minNodeBStrength = MAX_BLUE * 0.05F;
  private final float maxNodeBStrength = MAX_BLUE * 0.45F;
  
  private final float minEatAmount = 5F;
  private final float maxEatAmount = 35F;
  
  private final float minMinHealthyResourceMultiplier = 0.05F;
  private final float maxMinHealthyResourceMultiplier = 0.25F;
  
  private final float minMaxHealthyResourceMultiplier = 1F;
  private final float maxMaxHealthyResourceMultiplier = 1F;
  
  private final float minResourceDecreaseRate = 3F;
  private final float maxResourceDecreaseRate = 20F;
  
  private final float minResourceDigestionRate = 0.25F;
  private final float maxResourceDigestionRate = 1.5F;
  
  private final float minMaxHealth = 200F;
  private final float maxMaxHealth = 700F;
  
  private final float minUnhealthyLossRate = 1F;
  private final float maxUnhealthyLossRate = 2F;
  
  private final float minHealthyGainRate = 1F;
  private final float maxHealthyGainRate = 2F;
  
  private final int generationMethod;
  
  private ArrayList<Cell> cells = new ArrayList<Cell>();
  
  public SimulationSetup(int generationMethod)
  {
    this.generationMethod = generationMethod;
  }
  
  public void SetupSimulation()
  {
    map.ClearMap();
    cells.clear();
    
    GameController.RemoveAllObjects();
    
    new RestartObject();
    new SimulationControlObject();
    
    for(int i = 0; i < MAP_WIDTH / CELL_SIZE; i++)
    {
      for(int j = 0; j < MAP_HEIGHT / CELL_SIZE; j++)
      {
        Cell newCell = new Cell("Cell");
        float cellX = ((float)i) * CELL_SIZE + CELL_SIZE / 2F;
        float cellY = ((float)j) * CELL_SIZE + CELL_SIZE / 2F;
        
        newCell.SetPosition(cellX, cellY);
        cells.add(newCell);
        map.AddCell(newCell);
      }
    }
    
    println("Created " + cells.size() + " total cells.");
      
    float totalR = 0F;
    float totalG = 0F;
    float totalB = 0F;
    
    if((generationMethod & NOISE) == NOISE)
    {
      float gNoiseStartX = random(10000F);
      float gNoiseStartY = random(10000F);
  
      float rNoiseStartX = random(10000F);
      float rNoiseStartY = random(10000F);
  
      float bNoiseStartX = random(10000F);
      float bNoiseStartY = random(10000F);
      
      println("Generating using noise...");
      
      for(int i = 0; i < cells.size(); i++)
      {
        Cell currentCell = cells.get(i);
        
        float redAmount = noise((rNoiseStartX + currentCell.GetX()) * noiseScale, (rNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_RED * noiseMultiplier;
        float greenAmount = noise((gNoiseStartX + currentCell.GetX()) * noiseScale, (gNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_GREEN * noiseMultiplier;
        float blueAmount = noise((bNoiseStartX + currentCell.GetX()) * noiseScale, (bNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_BLUE * noiseMultiplier;
        
        currentCell.ChangeResource(RED_RESOURCE, redAmount);
        currentCell.ChangeResource(GREEN_RESOURCE, greenAmount);
        currentCell.ChangeResource(BLUE_RESOURCE, blueAmount);
        
        totalR += redAmount;
        totalG += greenAmount;
        totalB += blueAmount;
      }
      
      println("Average R after noise: " + totalR / cells.size());
      println("Average G after noise: " + totalG / cells.size());
      println("Average B after noise: " + totalB / cells.size());
    }
    
    if((generationMethod & NODES) == NODES)
    {
      ArrayList<ResourceNode> nodes = new ArrayList<ResourceNode>();
      
      println("Generating using " + numberOfNodes + " nodes...");
      
      for(int i = 0; i < numberOfNodes; i++)
      {
        float nodeX = random(0F, MAP_WIDTH);
        float nodeY = random(0F, MAP_HEIGHT);
        float nodeRadius = random(minNodeRadius, maxNodeRadius);
        float nodeRStrength = random(minNodeRStrength, maxNodeRStrength);
        float nodeGStrength = random(minNodeGStrength, maxNodeGStrength);
        float nodeBStrength = random(minNodeBStrength, maxNodeBStrength);
        
        println("Creating node at (" + nodeX + "," + nodeY + ") with radius " + nodeRadius + " and strength (" + nodeRStrength + "," + nodeGStrength + "," + nodeBStrength + ")");
        
        nodes.add(new ResourceNode(nodeRStrength, 
                                   nodeGStrength, 
                                   nodeBStrength, 
                                   nodeX, 
                                   nodeY, 
                                   nodeRadius));
      }
      
      for(int i = 0; i < cells.size(); i++)
      {
        Cell currentCell = cells.get(i);
        for(int j = 0; j < nodes.size(); j++)
        {
          ResourceNode currentNode = nodes.get(j);
          
          float redAmount = currentNode.GetResourceStrength(RED_RESOURCE, currentCell.GetX(), currentCell.GetY());
          float greenAmount = currentNode.GetResourceStrength(GREEN_RESOURCE, currentCell.GetX(), currentCell.GetY());
          float blueAmount = currentNode.GetResourceStrength(BLUE_RESOURCE, currentCell.GetX(), currentCell.GetY());
          
          currentCell.ChangeResource(RED_RESOURCE, redAmount);
          currentCell.ChangeResource(GREEN_RESOURCE, greenAmount);
          currentCell.ChangeResource(BLUE_RESOURCE, blueAmount);
          
          totalR += redAmount;
          totalG += greenAmount;
          totalB += blueAmount;
        }
      }
      
      println("Average R after nodes: " + totalR / cells.size());
      println("Average G after nodes: " + totalG / cells.size());
      println("Average B after nodes: " + totalB / cells.size());
    }
    
    //Generate walkers
    for(int i = 0; i < numberOfWalkers; i++)
    {
      float walkerX = (int)random(0F, MAP_WIDTH);
      float walkerY = (int)random(0F, MAP_HEIGHT);
      
      float adjustedX = (int)walkerX - ((int)walkerX) % (int)CELL_SIZE;
      adjustedX += CELL_SIZE / 2F;
      
      float adjustedY = (int)walkerY - ((int)walkerY) % (int)CELL_SIZE;
      adjustedY += CELL_SIZE / 2F;
      
      println("Spawning walker at: (" + adjustedX + "," + adjustedY + ")");
      
      Walker w = new Walker("Walker", random(minMinHealthyResourceMultiplier, maxMinHealthyResourceMultiplier) * MAX_RED, random(minMinHealthyResourceMultiplier, maxMinHealthyResourceMultiplier) * MAX_GREEN, random(minMinHealthyResourceMultiplier, maxMinHealthyResourceMultiplier) * MAX_BLUE,
                                      random(minMaxHealthyResourceMultiplier, maxMaxHealthyResourceMultiplier) * MAX_RED, random(minMaxHealthyResourceMultiplier, maxMaxHealthyResourceMultiplier) * MAX_GREEN, random(minMaxHealthyResourceMultiplier, maxMaxHealthyResourceMultiplier) * MAX_BLUE,
                                      random(minResourceDecreaseRate, maxResourceDecreaseRate), random(minResourceDecreaseRate, maxResourceDecreaseRate), random(minResourceDecreaseRate, maxResourceDecreaseRate),
                                      random(minResourceDigestionRate, maxResourceDigestionRate), random(minResourceDigestionRate, maxResourceDigestionRate), random(minResourceDigestionRate, maxResourceDigestionRate),
                                      random(minEatAmount, maxEatAmount),
                                      random(minMaxHealth, maxMaxHealth),
                                      random(minUnhealthyLossRate, maxUnhealthyLossRate),
                                      random(minHealthyGainRate, maxHealthyGainRate),
                                      (int)random(RED_RESOURCE, BLUE_RESOURCE + 1));
      
      w.SetPosition(adjustedX, adjustedY);
    }
  }
}
