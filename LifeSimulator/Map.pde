public class Map
{
  private HashMap<Integer, Cell> cells;
  
  private ArrayList<Animal> animals;
  
  public Map()
  {
    cells = new HashMap<Integer, Cell>();
    animals = new ArrayList<Animal>();
  }
  
  public void AddCell(int index, Cell cell)
  {
    cells.put(index, cell);
  }
  
  public void AddCell(float x, float y, Cell cell)
  {
    AddCell((((int)y / (int)CELL_SIZE) * (int)(MAP_WIDTH / CELL_SIZE)) + ((int)x / (int)CELL_SIZE), cell);
  }
  
  public void AddCell(Cell cell)
  {
    AddCell(cell.GetX(), cell.GetY(), cell);
  }
  
  public Cell GetCell(int index)
  {
    return cells.containsKey(index) ? cells.get(index) : null;
  }
  
  public Cell GetCell(float x, float y)
  {
    return GetCell((((int)y / (int)CELL_SIZE) * (int)(MAP_WIDTH / CELL_SIZE)) + ((int)x / (int)CELL_SIZE));
  }
  
  public void ClearMap()
  {
    cells.clear();
  }
}
