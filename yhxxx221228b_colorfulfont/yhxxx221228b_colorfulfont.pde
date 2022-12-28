import geomerative.*;
import processing.pdf.*;
String word = "Colorful";
float y = 0;
float yspeed=5;
boolean savePDF;

void setup() {
  size(800, 600);
  background(0);
}

void draw() {

  if(savePDF){
    beginRecord(PDF,"output/colorful font.pdf");
  }
  
  background(0);
  translate(width/2, 300);
  noFill();
  strokeWeight(3);

  RG.init(this);
  RFont font = new RFont( "FreeSans.ttf", 200, CENTER);
  RCommand.setSegmentLength(10);
  RGroup grp = font.toGroup(word);
  grp = grp.toPolygonGroup();
  RPoint[] pnts = grp.getPoints();
  float noiseSeed = 0;

  for ( int i = 0; i < pnts.length; i++ ) {
    float d = noise(noiseSeed)*25;
    stroke(map(i,0,pnts.length,50,250));
    //triangle(pnts[i].x, -(pnts[i].y+y-20),pnts[i].x+d/2, -(pnts[i].y+d+Y-20),pnts[i].x-d/2, -(pnts[i].y+d+Y-20));
    ellipse(pnts[i].x, -(pnts[i].y+y-20), d, d);
    frameRate(5);
    
    stroke(random(0, 255), random(0, 255), random(0, 255),map(i,0,pnts.length,300,100));
    frameRate(5);
    //triangle(pnts[i].x, pnts[i].y,pnts[i].x+d/2, pnts[i].y+d,pnts[i].x-d/2, pnts[i].y+d);
    ellipse(pnts[i].x, pnts[i].y+y, d, d);
   
    y=y+yspeed;
    if (y>500||y<100) {
      yspeed=yspeed*-1;
    }
    noiseSeed += 1;
  }
  
   if(savePDF){
    endRecord();
    savePDF=false;
  }
}

void keyPressed(){
  if(key=='s')savePDF=true;
}
