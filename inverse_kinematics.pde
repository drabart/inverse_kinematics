float WIDTH = 800;
float HEIGHT = 600;

Spider spider;

public void settings()
{
  size(int(WIDTH), int(HEIGHT));
}

void setup()
{
  PVector position = new PVector(WIDTH / 2.0f, HEIGHT / 2.0f);
  PVector heading = new PVector(0.0f, 1.0f);
  this.spider = new Spider(position, heading, 150.0f, 100.0f, 2);
}

void draw()
{
  background(255);
  fill(0);
  spider.render();
}
