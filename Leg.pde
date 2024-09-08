int RELAXATION_ITERATIONS = 10;

class Leg
{
  private ArrayList<Segment> segments;
  private int segmentNumber;
  private float length;
  private float segmentLength;
  private PVector joint;
  private PVector desired;

  Leg(PVector joint, PVector desired, float length, int segmentNumber)
  {
    this.segments = new ArrayList<>();

    this.length = length;
    this.segmentNumber = segmentNumber;
    this.segmentLength = this.length / this.segmentNumber;
    this.joint = joint;
    this.desired = desired;
    
    PVector start = joint.copy();
    PVector desired_heading = desired.copy().sub(joint);

    desired_heading.normalize();
    for(int i = 0; i < this.segmentNumber; i++)
    {
      PVector end = start.copy().add(
        desired_heading.copy().mult(this.segmentLength)
      );

      this.segments.add(new Segment(
        start, 
        end, 
        20.0f,
        15.0f)
      );

      start = end.copy();
    }
  }

  public void move(PVector joint, PVector desired)
  {
    this.joint = joint;
    this.desired = desired;
    PVector anchorPosition = segments.get(this.segmentNumber - 1).getEnd();

    if (PVector.dist(anchorPosition, desired) > this.length / 5.0f)
    {
      this.makeStep();
    }

    this.relax(anchorPosition);
  }

  private void makeStep()
  {
    for (int i = 0; i < RELAXATION_ITERATIONS; i++)
    {
      PVector requiredPosition = this.desired;
      for (int j = this.segmentNumber - 1; j >= 0; j--)
      {
        Segment segment = segments.get(j);
        segment.move_bw(segment.getStart(), requiredPosition);
        requiredPosition = segment.getStart();
      }
    }
  }

  public void relax(PVector anchorPosition)
  {
    for (int i = 0; i < RELAXATION_ITERATIONS; i++)
    {
      PVector requiredPosition = this.joint;
      for (Segment segment: this.segments)
      {
        segment.move(requiredPosition, segment.getEnd());
        requiredPosition = segment.getEnd();
      }
    }
  }
  
  public void render()
  {
    for(Segment segment: this.segments)
    {
      segment.render();
    }
    fill(200, 100, 100);
    circle(this.desired.x, this.desired.y, 10);
    fill(50);
  }
}
