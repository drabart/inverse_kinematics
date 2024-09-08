class Segment
{
  private PVector start_point;
  private PVector end_point;
  private float width_low;
  private float width_high;
  
  Segment(PVector start_point, PVector end_point, float width_low, float width_high)
  {
    this.start_point = start_point;
    this.end_point = end_point;
    this.width_low = width_low;
    this.width_high = width_high;
  }
  
  public void render()
  {
    PVector line = PVector.sub(end_point, start_point);
    PVector line_rotated = line.copy().rotate(PI / 2.0f).normalize();
    PVector p1 = PVector.add(start_point, PVector.mult(line_rotated, width_high * 0.5f));
    PVector p2 = PVector.sub(end_point, PVector.mult(line_rotated, width_low * 0.5f));
    PVector p3 = PVector.sub(end_point, PVector.mult(line_rotated, width_low * 0.5f));
    PVector p4 = PVector.add(start_point, PVector.mult(line_rotated, width_high * 0.5f));
    quad(p1.x, p2.x, p3.x, p4.x, p1.y, p2.y, p3.y, p4.y);
  }
  
}
