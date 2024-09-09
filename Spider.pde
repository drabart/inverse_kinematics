class Spider
{
  private ArrayList<Leg> right_legs;
  private ArrayList<Leg> left_legs;
  private PVector position;
  private PVector heading;
  private Segment body;
  private float length;
  private float width;
  private float legLength;
  private int legNumber;

  Spider(PVector position, PVector heading, float length, float width, float legLength, int legNumber)
  {
    this.position = position;
    this.heading = heading;
    this.length = length;
    this.width = width;
    this.legNumber = legNumber;
    this.legLength = legLength;

    this.body = new Segment(
      PVector.add(this.position, this.heading.copy().mult(this.length / 2.0f)),
      PVector.sub(this.position, this.heading.copy().mult(this.length / 2.0f)),
      this.width,
      this.width
    );

    this.left_legs = new ArrayList<>();
    this.right_legs = new ArrayList<>();
    float legBodyPosition = this.length;
    for(int i = 0; i < this.legNumber; i++)
    {
      PVector left_joint = joint_position(legBodyPosition, true);
      PVector right_joint = joint_position(legBodyPosition, false);

      PVector left_desired = desired_position(left_joint);
      PVector right_desired = desired_position(right_joint);

      left_legs.add(new Leg(
        left_joint,
        left_desired,
        this.legLength, 
        3
        )
      );
      right_legs.add(new Leg(
        right_joint,
        right_desired,
        this.legLength,
        3
        )
      );
      legBodyPosition -= this.length / (this.legNumber - 1);
    }
  }

  public PVector joint_position(float legBodyPosition, boolean left)
  {
    PVector joint = PVector.add(
      this.position,
      PVector.add(
        this.heading.copy().mult(legBodyPosition - this.length / 2.0f), 
        this.heading.copy().rotate(PI / 2.0).mult(this.width / 2.0f).mult(left ? 1 : -1)
      )
    );

    return joint;
  }

  public PVector desired_position(PVector joint)
  {
    PVector desired_heading = joint.copy();
    desired_heading.sub(this.position).setMag(this.legLength * 0.9f);
    PVector desired = joint.copy();
    desired.add(desired_heading);
    
    return desired;
  }

  public float getX() 
  {
    return this.position.x;
  }

  public float getY()
  {
    return this.position.y;
  }

  public void move(PVector delta_position)
  {
    this.heading.add(delta_position.copy().normalize().mult(0.01)).normalize();
    PVector move = this.heading.copy();
    move.mult(delta_position.mag());
    println(move);
    this.position.add(move);

    this.body.move(
      PVector.add(this.position, this.heading.copy().mult(this.length / 2.0f)),
      PVector.sub(this.position, this.heading.copy().mult(this.length / 2.0f))
    );
    
    float legBodyPosition = this.length;
    for(Leg leg: this.left_legs)
    {
      PVector joint = joint_position(legBodyPosition, true);
      PVector desired = desired_position(joint);

      leg.move(
        joint,
        desired
      ); 
      legBodyPosition -= this.length / (this.legNumber - 1);
    }

    legBodyPosition = this.length;
    for(Leg leg: this.right_legs)
    {
      PVector joint = joint_position(legBodyPosition, false);
      PVector desired = desired_position(joint);

      leg.move(
        joint,
        desired
      ); 
      legBodyPosition -= this.length / (this.legNumber - 1);
    }
  }
  
  public void render()
  {
    fill(100);
    this.body.render();
    fill(50);
    for(Leg leg: this.left_legs)
    {
      leg.render(); 
    }
    for(Leg leg: this.right_legs)
    {
      leg.render(); 
    }
  }
}
