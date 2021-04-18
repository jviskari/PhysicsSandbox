/*Vectors fun. (c) Joonas Viskari 2021 */


/*Physics Sandbox*/
Sandbox sandbox;

void setup()
{
  frameRate(50);
  size(640,480);
  
  sandbox = new Sandbox(this);
  sandbox.add(new PhysObject(new PVector(50,50)));
  sandbox.add(new PhysObject(new PVector(200,200))); 
  sandbox.add(new PhysObject(new PVector(300,300))); 
  sandbox.add(new PhysObject(new PVector(100,300))); 
}

void draw()
{
  background(0);
  sandbox.update();
}

class PhysObject
{
    PVector p;
    PVector a;
    PVector v;
    float mass;
    
    PhysObject(PVector p)
    {
        this.p = new PVector(p.x, p.y); 
        this.a = new PVector(0.0,0);
        this.v = new PVector(0,0);
        mass = 1;
    }
    
    void update()
    {
      v = v.add(a);
      p = p.add(v);                  
    }
    
    void setAcceleration(PVector a)
    {
        this.a = a; 
    }
    
}

class Sandbox
{
    final float g = 0.0;    //gravity value
    final float k = 0.0001; //spring constant
    PApplet parent;
    ArrayList<PhysObject> objects;

    Sandbox(PApplet parent)
    {
        this.parent = parent;
        objects = new ArrayList<PhysObject>();
    }
    
    void add(PhysObject o)
    {
        objects.add(o);  
    }
    
    void update()
    {
      for (PhysObject o : objects)
      {
        moveObject(o);
        drawObject(o);
      }        
    } 
    
    void moveObject(PhysObject o)
    {
        PVector gravity = new PVector(0,g);
        PVector dir = new PVector(mouseX, mouseY);
        PVector p = o.p;
        
        float d = dist(dir.x, dir.y, p.x, p.y);
        float maxDist = dist(0, 0, width, height);
        float gray = map(d, 0, maxDist, 0, 255);
     
        strokeWeight(5);    
        stroke(gray,255-gray,0);
        parent.line(o.p.x, o.p.y, dir.x, dir.y );  
       
        //vector from object to pointer
        dir = dir.sub(p);
        //f=kx
        //ma=kx  : m=1
        //a=kx;
        
        dir.mult(k);
       
        dir = dir.add(gravity);
       
        o.setAcceleration(dir);
        o.update();
    }
    
    void drawObject(PhysObject o)
    {
        /*ship heading is same as accleration vector
        Ship ship = new Ship(o.p, o.a.heading());
        strokeWeight(2); 
        ship.setCanvas(parent);
        ship.draw();         
    }    
}


/* Visualization of object*/
class Ship
{
  PApplet canvas;
  
  PVector p0;
  PVector p1;
  PVector p2;
  PVector p3; 
  float r;
  float angle;

  void setCanvas(PApplet pa)
  {
      canvas = pa;
  }
     
  Ship(PVector p, float rads)
  {
      setPosAndAngle(p,rads); 
  }

  void setPosAndAngle(PVector p, float rads)
  {
    r = 20;
    angle = rads;
    p0 = new PVector(p.x, p.y);
    p1 = PVector.fromAngle((angle));
    p1.setMag(r);
    p1=p1.add(p0);

    p2 = PVector.fromAngle((angle+radians(90+45)));
    p2.setMag(r);
    p2=p2.add(p0);

    p3 = PVector.fromAngle((angle-radians(90+45)));
    p3.setMag(r);
    p3=p3.add(p0);       
  }

  void circle(PVector c, float r)
  {
      canvas.circle(c.x,c.y,r);
  }
  
  void line(PVector p1, PVector p2)
  {
      canvas.line(p1.x,p1.y,p2.x,p2.y);
  }

  void draw()
  {
    fill(255,0,0);
    circle(p0,10);
    
    stroke(255,0,0);
    noFill();
    circle(p0,r*2);
    fill(0,255,0);
    circle(p1,10);
    circle(p2,10);
    circle(p3,10);
    
    line(p0,p1);
    line(p0,p2);
    line(p0,p3);
    
    triangle(p1.x, p1.y,
             p2.x, p2.y,
             p3.x, p3.y);    
  }
  
  void setAngleRad(float angle)
  {
      setPosAndAngle(this.p0,angle);
  }
  
  
  void setHeadingTo(PVector dir)
  {
      canvas.line(p0.x,p0.y,dir.x,dir.y);
      dir=dir.sub(p0);
      setAngleRad(dir.heading());
  }
         
}
