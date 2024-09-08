private Spider spider;

void setup()
{
  size(800, 600);
  
  this.spider = new Spider(1);
}

void loop()
{
  background(0);
  this.spider.render();
}
