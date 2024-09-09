float WIDTH = 1400;
float HEIGHT = 1000;

Spider spider;

public void settings()
{
  size(int(WIDTH), int(HEIGHT));
}

void setup()
{
  PVector position = new PVector(WIDTH / 2.0f, HEIGHT / 2.0f);
  PVector heading = new PVector(0.0f, 1.0f);
  this.spider = new Spider(position, heading, 100.0f, 75.0f, 150.0f, 4);
}

void draw()
{
  float deltaTime = 1.0f / frameRate;

  background(255);

  PVector deltaMove = new PVector((mouseX - spider.getX()) * 0.2f, (mouseY - spider.getY()) * 0.2f);
  deltaMove.mult(deltaTime);

  spider.move(deltaMove);

  spider.render();
}
