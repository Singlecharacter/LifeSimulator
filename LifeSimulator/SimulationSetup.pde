public class SimulationSetup
{
  private ArrayList<ResourceNode> nodes = new ArrayList<ResourceNode>();
  
  private final int numberOfNodes = 20;
  
  private final float noiseScale = 0.02F;
  
  private final float minNodeRadius = 100F;
  private final float maxNodeRadius = 500F;
  
  private final float minNodeRStrength = MAX_RED * 0.05F;
  private final float maxNodeRStrength = MAX_RED * 0.75F;
  
  private final float minNodeGStrength = MAX_GREEN * 0.05F;
  private final float maxNodeGStrength = MAX_GREEN * 0.75F;
  
  private final float minNodeBStrength = MAX_BLUE * 0.05F;
  private final float maxNodeBStrength = MAX_BLUE * 0.75F;
  
  private final float gNoiseStartX = random(10000F);
  private final float gNoiseStartY = random(10000F);
  
  private final float rNoiseStartX = random(10000F);
  private final float rNoiseStartY = random(10000F);
  
  private final float bNoiseStartX = random(10000F);
  private final float bNoiseStartY = random(10000F);
  
  private final int generationMethod = NOISE;
  
  private boolean runFirstSimulation = false;
  
  private ArrayList<Cell> cells = new ArrayList<Cell>();
  
  public void SetupSimulation()
  {
    if(runFirstSimulation)
      GameController.RemoveAllObjects();
    
    runFirstSimulation = true;
    
    new RestartObject();
    
    for(int i = 0; i < MAP_WIDTH / CELL_SIZE; i++)
    {
      for(int j = 0; j < MAP_HEIGHT / CELL_SIZE; j++)
      {
        Cell newCell = new Cell("Cell");
        float cellX = ((float)i) * CELL_SIZE + CELL_SIZE / 2F;
        float cellY = ((float)j) * CELL_SIZE + CELL_SIZE / 2F;
        
        println("Creating cell at: (" + cellX + "," + cellY + ")");
        
        newCell.SetPosition(cellX, cellY);
        cells.add(newCell);
      }
    }
    
    println("Created " + cells.size() + " total cells.");
      
    float totalR = 0F;
    float totalG = 0F;
    float totalB = 0F;
    
    if((generationMethod & NOISE) == NOISE)
    {
      println("Generating using noise...");
      
      for(int i = 0; i < cells.size(); i++)
      {
        Cell currentCell = cells.get(i);
        
        float redAmount = noise((rNoiseStartX + currentCell.GetX()) * noiseScale, (rNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_RED;
        float greenAmount = noise((gNoiseStartX + currentCell.GetX()) * noiseScale, (gNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_GREEN;
        float blueAmount = noise((bNoiseStartX + currentCell.GetX()) * noiseScale, (bNoiseStartY + currentCell.GetY()) * noiseScale) * MAX_BLUE;
        
        if(i == 0)
        {
          println("R: " + redAmount);
          println("G: " + greenAmount);
          println("B: " + blueAmount);
        }
        
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
  }
}
