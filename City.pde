//For the past 18 years, my home has been the beautiful and lively 
//city of Seoul, South Korea. The city is a brilliant combination of 
//the world’s most high tech innovations with South Korea’s culture 
//and preserved nature. An example of this combination is the light 
//show on the Han River. Although recently constructed, it quickly 
//became a beloved pastime to visit the Han River with my family and 
//friends and watch the Banpo Bridge Water Fountain colored with 
//dazzling lights. Before the fountain however, I used to love to sit 
//on the edge of the water and watch the city lights paint the sky and 
//water. It was my own light show. 
//I wanted to emulate this experience and create a program that can 
//paint the night sky with city lights. When the program is first opened, 
//it is nothing but a dark starry night. The two red dots blinking next 
//to the stars are metaphors for the aviation lights on top of tall 
//buildings. The middle section of the canvas are filled with windows 
//of buildings. While moving your cursor, if it touches a window, it will 
//light up. Instead of drawing literal buildings, I wanted to make up the 
//building with lit up windows because at night, that is all you can see. 
//As more windows light up, the bottom section, which represents the river, 
//begins to sparkle from the reflected light of the buildings. 

ArrayList<Windows> windows = new ArrayList<Windows>();
float rTime;
float tTime;
boolean rCycle;
int trailSize = 100;
float mx[] = new float[trailSize];
float my[] = new float[trailSize];
color mc[] = new color[trailSize];
void setup() {
  size(400, 600);
  //smooth();
  frameRate(60);
  background(0);
  //noCursor();
  noStroke();
  //windows
  //building 1
  for(int i = 0; i < 50; i+=10){
    for(int j = 272; j < (3*height)/4; j+=8){
      windows.add(new Windows(i, j, 7, 5));
    }
  }
  //building 2
  for(int i = 75; i < 140; i+=10){
    for(int j = 250; j < (3*height)/4; j+=8){
      windows.add(new Windows(i, j, 7, 5));
    }
  }
  //building 3
  for(int i = 90; i < 200; i+=10){
    for(int j = 350; j < (3*height)/4; j+=8){
      windows.add(new Windows(i, j, 7, 5));
    }
  }
  //building 4
  for(int i = 220; i < 320; i+=8){
    for(int j = 220; j < (3*height)/4; j+=6){
      windows.add(new Windows(i, j, 6, 4));
    }
  }
  //building 5
  for(int i = 340; i < 400; i+=12){
    for(int j = 300; j < (3*height)/4; j+=10){
      windows.add(new Windows(i, j, 9, 7));
    }
  }
}

void draw(){
  //stars
  tTime++;
  if(tTime%500==0){
    fill(0,100);
    rect(0,0,width,height);
  }
  else {
    fill(0,7);
    rect(0,0,width,height);
    fill(0,150);
    rect((3*height)/4,0,width,height/4);
  }
  int transp = 255;
  float radius = random(5);
  color c = color(random(250, 255), random(250, 255), random(250, 255));
  transp -= 20;
  fill(c, transp);
  ellipse(random(width), random((3*height)/4), radius, radius);
  
  //buildings
  if(rTime <= 10 && rTime >=0 && !rCycle){
    fill(color(255,0,0),15);
    ellipse(270,100,8,8);
    ellipse(270,150,10,10);
    rTime += 0.1;
    if(rTime >= 10){
      rCycle = true;
    }
    
  }
  else{
    fill(0,10);
    ellipse(270,100,8,8);
    ellipse(270,150,10,10);
    rTime -= 0.1;
    if(rTime < 1){
      rCycle = false;
    }
  }
  
  //windows
  for(Windows b : windows){
    if(abs(mouseX - (b.wWidth/2 + b.xpos)) < b.wWidth/2
    && abs(mouseY - (b.wHeight/2 + b.ypos)) < b.wHeight/2
    && b.state == 0 && b. state != 1){
      b.turnOn();
    }
    else if(abs(mouseX - (b.wWidth/2 + b.xpos)) < b.wWidth/2
    && abs(mouseY - (b.wHeight/2 + b.ypos)) < b.wHeight/2
    && b.state == 1){
      b.turnOff();
    }
    b.run();
  }
  

  //cursor
  //fill(color(random(0,255)),50);
  //ellipse(mouseX, mouseY, 5,5);
 
}

class Windows {
  final int ON = 1;
  final int OFF = 0;
  int state;
  float xpos, ypos;
  int wWidth, wHeight;
  color c;
  int transp;
  
  Windows(float xpos, float ypos, int wWidth, int wHeight){
    this.xpos = xpos;
    this.ypos = ypos;
    this.wWidth = wWidth;
    this.wHeight = wHeight;
    state = OFF;
  }
  
  void run(){
    update();
    display();
  }
  
  void turnOn(){
    c = color(random(160,255),random(70,170),random(0,140));
    state = ON;
  }
  
  void turnOff(){
    c = color(0);
    state = OFF;
  }
  
  void update(){
    
    //glow
  }
  void display(){
    fill(c);
    rect(xpos, ypos, wWidth, wHeight);
    if((int)random(0,50) == 1){
      fill(c, 35);
      rect(xpos+random(-5,5), random((3*height)/4, height), wWidth, wHeight);
    }
    else{
      fill(0,7);
      rect(xpos+random(-5,5), random((3*height)/4, height), wWidth, wHeight);
    }
  }
  
}