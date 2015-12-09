//your variable declarations here
public void setup() 
{
  //your code here
  size(500, 500);
  background(0);
  for (int i = 0; i < 100; i++)
  {
    space[i] = new Starfield();
  }
  for (int i = 0; i < 20; i++)
  {
    debris.add(new Asteroid());
  }
  // for (int i = 0; i < 1; i++)
  // {
  //   bullets.add(new Bullet());
  // }
} 

Starfield space[] = new Starfield[100];
SpaceShip s = new SpaceShip();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList <Asteroid> debris = new ArrayList<Asteroid>();
ArrayList <Bullet> bullets = new ArrayList<Bullet>();

private boolean spacePressed, aPressed, dPressed, wPressed;
private boolean gameOver = false;
private int pressedCount = 0;
private int timeOne;

public void draw() 
{
  //your code here

  if (!gameOver)
  {
    background(0);
    for (int i = 0; i < 100; i++)
    {
      space[i].show();
    }
    for (int i = 0; i < bullets.size(); i++)
    {
      Bullet b = bullets.get(i);
      b.show();
      b.move();
    }
    for (int i = debris.size()-1; i >= 0; i--)
    {
      // debris[i].setDirectionX(Math.random()*2);
      // debris[i].setDirectionY(Math.random()*2);
      Asteroid a = debris.get(i);
      a.show();
      a.move();
      if (dist(a.getX(), a.getY(), s.getX(), s.getY()) <= 20)
      {
        gameOver = true;
      }
      for (int j = bullets.size()-1; j >= 0; j--)
      {
        Bullet b = bullets.get(j);
        if (dist(a.getX(), a.getY(), b.getX(), b.getY()) <= 15)
        {
          debris.remove(i);
          bullets.remove(j);
        }
      }
      // debris[i].show();
      // debris[i].move();
    }
    s.show();
    if (aPressed)
    {
      s.rotate(-4);
    }
    if (dPressed)
    {
      s.rotate(4);
    }
    if (wPressed)
    {
      s.accelerate(0.2);
    }
    s.move();
    if (spacePressed)
    {
      for (int i = 0; i < 10; i++)
      {
        Particle part = particles.get(i);
        part.show();
        part.move();
        // part.wrap();
        if (part.getTint() < 0)
        {
          spacePressed = false;
          break;
        }
      }
      if (!spacePressed)
      {
        for (int i = 9; i >= 0; i--)
        {
          particles.remove(i);
        }
      }
    }
  }
  if (debris.size() == 0)
  {
    gameOver = true;
  }
  if (gameOver)
  {
    fill(255, 0, 0);
    smooth();
    textSize(64);
    textAlign(CENTER);
    if (debris.size()==0)
    {
      text("YOU WIN", width/2, height/2);
    }
    else 
    {
      text("YOU LOSE", width/2, height/2);
    }
    textSize(32);
    text("Press p to play again", width/2, height/2+50);

  }
}

public class Starfield
{
  private int myX, myY, red, green, blue, myR;
  public Starfield()
  {
    myX = (int)(Math.random()*height);
    myY = (int)(Math.random()*width);
    red = (int)(Math.random()*256);
    green = (int)(Math.random()*256);
    blue = (int)(Math.random()*256);
    myR = (int)(Math.random()*6)+2;
  }
  public void show()
  {
    fill(red, green, blue);
    stroke(red, green, blue);
    ellipse(myX, myY, myR, myR);
  }
}

public class SpaceShip extends Floater //extends Floater  
{   
    // your code here
    public SpaceShip()
    {
      corners = 6;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = 12;
      yCorners[0] = 0;
      xCorners[1] = 0;
      yCorners[1] = -12;
      xCorners[2] = -12;
      yCorners[2] = -12;
      xCorners[3] = -6;
      yCorners[3] = 0;
      xCorners[4] = -12;
      yCorners[4] = 12;
      xCorners[5] = 0;
      yCorners[5] = 12;
      myColor = color(255, 0, 0);
      myCenterX = 250;
      myCenterY = 250;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 0;
    }

    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int)myCenterX;}
    public void setY(int y) {myCenterY = y;}
    public int getY() {return (int)myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
}

public void mousePressed()
{
  bullets.add(new Bullet());
}
public void keyPressed()
{
  if (key == 'a')
  {
    aPressed = true;
    // s.rotate(-10);
  }
  else if (key == 'd')
  {
    dPressed = true;
    // s.rotate(10);
  }
  else if (key == 'w')
  {
    wPressed = true;
    // s.accelerate(0.5);
  }
  else if (key == ' ')
  {
    // if pressed count = 0, run program
    // record time of being pressed
    if (pressedCount == 0 || (frameCount - timeOne >= 120))
    {
      pressedCount+=1;
      timeOne = frameCount;
      // System.out.println(timeOne);
      spacePressed = true;
      s.setDirectionX(0);
      s.setDirectionY(0);
      for (int i = 0; i <10; i++)
      {
        particles.add(new Particle((double)s.getX(), (double)s.getY()));
        // System.out.println(s.getX() + "," + s.getY());
      }
      s.setX(mouseX);
      s.setY(mouseY);
    }
  }
  if (key == 'p' && gameOver)
  {
    gameOver = false;
    background(0);
    for (int i = 0; i < 100; i++)
    {
      space[i] = new Starfield();
    }
    for (int i = debris.size()-1; i < 20; i++)
    {
      debris.add(new Asteroid());
    }  
    s.setX((int)(Math.random()*width));
    s.setY((int)(Math.random()*height));
    s.setDirectionX(0);
    s.setDirectionY(0);
  }
}

public void keyReleased()
{
  if (key == 'a')
  {
    aPressed = false;
  }
  else if (key == 'd')
  {
    dPressed = false;
  }
  else if (key == 'w')
  {
    wPressed = false;
  }
}

public class Asteroid extends Floater
{
  private int rotSpeed;
  public Asteroid()
  {
    rotSpeed = (int)(Math.random()*7)-3;
    corners = 6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 10;
    yCorners[0] = 0;
    xCorners[1] = 0;
    yCorners[1] = -15;
    xCorners[2] = -20;
    yCorners[2] = -5;
    xCorners[3] = -20;
    yCorners[3] = 5;
    xCorners[4] = -10;
    yCorners[4] = 20;
    xCorners[5] = 5;
    yCorners[5] = 20;
    myColor = color(128);
    myCenterX = Math.random()*500;
    myCenterY = Math.random()*500;
    myDirectionX = Math.random()-0.5;
    myDirectionY = Math.random()-0.5;
    myPointDirection = 0;  
  }
  public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

public class Bullet extends Floater
{
  Bullet()
  {
    myCenterX = s.getX();
    myCenterY = s.getY();
    myPointDirection = s.getPointDirection();
    // yes, that means you have to actually point the spaceship 
    // in the direction you want to shoot
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5*Math.cos(dRadians) + s.getDirectionX();
    myDirectionY = 5*Math.sin(dRadians) + s.getDirectionY();
  }
  public void show()
  {
    fill(255, 242, 0);
    ellipse((float)myCenterX, (float)myCenterY, 10, 10);
  }
  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;  
   
    if(myCenterX >width+10 || myCenterX<-10 || myCenterY >height+10 || myCenterY <-10)
    {
      // get the bullets out of the way so they don't nuke asteroids accidentally
      // when the asteroids go outside the bounds of the screen
      myCenterX = 1000;
      myCenterY = 1000;
    } 
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

public class Particle
{
  private int myTint;
  private double moveX, moveY, myX, myY;
  private PImage particleImage = loadImage("sprites/particle.png");
  public Particle(double x, double y)
  {
    myX = x;
    myY = y;
    myTint = 255;
    moveX = (Math.random()*3)-1;
    moveY = (Math.random()*3)-1;
  }
  public void show() 
  {
    tint(255, 0, 0, myTint);
    image(particleImage, (float)myX, (float)myY);
  }
  public void move()
  {
    myX += moveX;
    myY += moveY;
    myTint-=10;
  }
  public int getTint()
  {
    return myTint;
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

 