class Spider
{
  private ArrayList<Leg> legs;
  
  Spider(int legNumber)
  {
    for(int i = 0; i < legNumber; i++)
    {
      legs.add(new Leg(1));
    }
  }
  
  public void render()
  {
    for(Leg leg: this.legs)
    {
      leg.render(); 
    }
  }
}
