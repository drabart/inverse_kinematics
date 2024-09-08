class Leg
{
  private ArrayList<Segment> segments;
  
  Leg(int segmentNumber)
  {
    for(int i = 0; i < segmentNumber; i++)
    {
      this.segments.add(new Segment(new PVector(0.0f, 0.0f), new PVector(100.0f, 100.0f), 30.0f, 50.0f));
    }
  }
  
  public void render()
  {
    for(Segment segment: this.segments)
    {
      segment.render();
    }
  }
}
