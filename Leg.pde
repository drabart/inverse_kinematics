class Leg
{
  private ArrayList<Segment> segments;
  private float length;

  Leg(PVector begin, float length, int segmentNumber)
  {
    this.length = length;
    PVector start = begin.copy();
    this.segments = new ArrayList<>();
    for(int i = 0; i < segmentNumber; i++)
    {
      PVector end = start.copy().add(
        new PVector(this.length / segmentNumber, 0.0f)
      );
      
      this.segments.add(new Segment(
        start, 
        end, 
        20.0f,
        15.0f));

      start = end.copy();
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
