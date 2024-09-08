class Spider
{
  private ArrayList<Leg> legs;
  private PVector position;
  private PVector heading;
  private Segment body;
  private float length;
  private float width;

  Spider(PVector position, PVector heading, float length, float width, int legNumber)
  {
    this.position = position;
    this.heading = heading;
    this.length = length;
    this.width = width;

    this.body = new Segment(
      PVector.add(this.position, this.heading.copy().mult(this.length / 2.0f)),
      PVector.sub(this.position, this.heading.copy().mult(this.length / 2.0f)),
      this.width,
      this.width
    );

    this.legs = new ArrayList<>();
    float legBodyPosition = this.length;
    for(int i = 0; i < legNumber; i++)
    {
      legs.add(new Leg(
        PVector.add(
          this.position, 
          PVector.add(
            this.heading.copy().mult(legBodyPosition - this.length / 2.0f), 
            this.heading.copy().rotate(PI / 2.0).mult(this.width / 2.0f)
          )
        ),
        this.length, 
        2
        )
      );
      legs.add(new Leg(
        PVector.add(
          this.position, 
          PVector.sub(
            this.heading.copy().mult(legBodyPosition - this.length / 2.0f), 
            this.heading.copy().rotate(PI / 2.0).mult(this.width / 2.0f)
          )
        ), 
        this.length,
        2
        )
      );
      legBodyPosition -= this.length / (legNumber - 1);
    }
  }
  
  public void render()
  {
    fill(100);
    this.body.render();
    fill(50);
    for(Leg leg: this.legs)
    {
      leg.render(); 
    }
  }
}
