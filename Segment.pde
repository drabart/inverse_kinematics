class Segment
{
  private float length;
  private PVector start_point;
  private PVector end_point;
  private float width_low;
  private float width_high;
  
  Segment(PVector start_point, PVector end_point, 
      float width_high, float width_low)
  {
    this.start_point = start_point;
    this.end_point = end_point;
    this.width_low = width_low;
    this.width_high = width_high;
    this.length = end_point.copy().sub(start_point).mag();
  }

  public void move(PVector start_point, PVector end_point)
  {
    this.start_point = start_point;
    // make sure segment is of constant length
    end_point = end_point
      .sub(start_point)
      .setMag(this.length)
      .add(start_point);
    this.end_point = end_point;
  }

  public void move_bw(PVector start_point, PVector end_point)
  {
    this.end_point = end_point;
    // make sure segment is of constant length
    start_point = start_point
      .sub(end_point)
      .setMag(this.length)
      .add(end_point);
    this.start_point = start_point;
  }

  public void move(PVector start_point)
  {
    this.start_point = start_point;
  }

  public PVector getStart()
  {
    return start_point.copy();
  }

  public PVector getEnd()
  {
    return end_point.copy();
  }

  public void render()
  {
    PVector line = PVector.sub(end_point, start_point);
    PVector line_rotated = line.copy();
    line_rotated.rotate(PI / 2.0).normalize();
    PVector p1 = PVector.add(start_point, PVector.mult(line_rotated, width_high * 0.5f));
    PVector p2 = PVector.add(end_point, PVector.mult(line_rotated, width_low * 0.5f));
    PVector p3 = PVector.sub(end_point, PVector.mult(line_rotated, width_low * 0.5f));
    PVector p4 = PVector.sub(start_point, PVector.mult(line_rotated, width_high * 0.5f));
    quad(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y);
  }
  
}
