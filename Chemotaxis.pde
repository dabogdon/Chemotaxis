Bacteria[] altas=new Bacteria[100];
Food[] meats=new Food[(int)(Math.random()*31)+40];
int bactX=0;
int bactY=0;
boolean bactHunger=true;
int deathTime;
int deadCount=100;
int fedCount=0;
int foodInit=meats.length;
int foodRemain=meats.length;
void setup() {
  size(500, 500);
  for (int i=0; i<altas.length; i++)//instantiate Bacteria
    altas[i]=new Bacteria();
  for (int i=0; i<meats.length; i++)//instantiate Food
    meats[i]=new Food();
}

void draw() {
  background(0);
  deathTime=millis();
  for (int i=0; i<meats.length; i++) {//draw food
    meats[i].show();
  }
  for (int i=0; i<altas.length; i++) {//draw & move bacteria
    altas[i].show();
    altas[i].move();
    if (altas[i].hungry==true) {//check if starving to death
      altas[i].die();
    }
  }

  for (int i=0; i<altas.length; i++) {//check if bacteriae are touching food
    bactX=altas[i].myX;
    bactY=altas[i].myY;
    bactHunger=altas[i].hungry;
    for (int j=0; j<meats.length; j++) {//if bacteriae are touching food, they eat it
      if (dist(meats[j].myX, meats[j].myY, bactX, bactY)<10&&bactHunger==true&&meats[j].eaten==false) {
        meats[j].eat();
        altas[i].fed();
      }
    }
  }
  if (deathTime>=16000) {
    println("--RESULTS--");
    println(fedCount + " fed");
    println(foodInit + " initial nutrients");
    println(foodRemain + " nutrients remaining");
    println(deadCount + " dead");
  }
}

class Food {
  int myX, myY;
  boolean eaten;
  Food() {
    eaten=false;
    myX=(int)(Math.random()*451);
    myY=(int)(Math.random()*451);
  }
  void show() {
    if (eaten==false) {
      fill(204, 153, 102);
      ellipse(myX, myY, 10, 10);
    }
    if (eaten==true) {/*draw nothing*/}
  }
  void eat() {
    println("nom (x,y): ("+myX+","+myY+")");//print where food was eaten
    //println(deathTime);
    eaten=true;
    foodRemain-=1;//change counters
    fedCount+=1;
    deadCount-=1;
  }
}
class Bacteria {
  int myX, myY, myColor, fedColor;
  boolean hungry, dead;
  Bacteria() {
    hungry=true;
    dead=false;
    myX=(int)(Math.random()*501); 
    myY=(int)(Math.random()*501);
    myColor=(int)(Math.random()*156)+100;
  }
  void move() {
    if (dead==true) {/*dont move*/}
    if (hungry==true&&dead==false) {
      myX+=(int)(Math.random()*11)-5;
      myY+=(int)(Math.random()*11)-5;
    }
    if (hungry==false&&dead==false) {
      myX+=(int)(Math.random()*3)-1;
      myY+=(int)(Math.random()*3)-1;
    }
  }
  void show() {
    if (hungry==true) {//grey
      fill(myColor);
    }
    if (hungry==false) {//green
      fill(0, myColor, 51);
    }
    if (dead==true) {//red
      fill(myColor, 0, 0);
    }
    ellipse(myX, myY, 25, 25);
  }
  void fed() {
    hungry=false;
  }
  void die() {
    if (deathTime>=15000) {
      dead=true;
    }
    if (deathTime>=16000) {
      noLoop();
    }
  }
}
