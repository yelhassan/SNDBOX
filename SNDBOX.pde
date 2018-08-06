import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Kinect kinect; 

Minim minim;
 AudioPlayer player;
 AudioInput input;
 
 AudioPlayer[] notes;
 
 AudioPlayer C1;
 AudioPlayer E;
 AudioPlayer Eb;
 AudioPlayer F;
 AudioPlayer G;
 //AudioPlayer C2;
 AudioPlayer C2beat;
 
 AudioPlayer D;
 AudioPlayer A;
  AudioPlayer Ab;
 AudioPlayer B;
 

// GRID OFFSET
int columns = 3;
int rows = 3;
float xoffset;
float yoffset;


int[] depth;

int t1 = 400;
int t2 = 600;

int T = 360;

int count = 0;

// Raw location
PVector loc;

// Interpolated location
PVector lerpedLoc;

PVector[] highest_pixels;
int[] highest_depth;
float depthInMeters;


void setup() {
  size(512,424);
  //size(640, 480, P3D);

//fullScreen(P3D);

  kinect = new Kinect(this);

  kinect.initDepth();

   minim = new Minim(this);
   
   
   
  
   C1 = minim.loadFile("C.mp3");
   D = minim.loadFile("C_2.mp3");
   C2beat = minim.loadFile("E.mp3");
   E = minim.loadFile("D.mp3");
   Eb = minim.loadFile("D_seq.mp3");
   F = minim.loadFile("G_picc.mp3");
   G = minim.loadFile("G_pad.mp3");
   A = minim.loadFile("beat_soft.mp3");
   Ab = minim.loadFile("beat_strong.mp3");
   B = minim.loadFile("cuba.mp3");
   
  AudioPlayer[] notes = {C1, Eb, E, F, G, Ab, A, B};
  
  notes = new AudioPlayer[9];
  notes[0] = C1;
  notes[1] = D;
  notes[2] = Eb;
  notes[3] = E;
  notes[4] = F;
  notes[5] = G;
  notes[6] = Ab;
  notes[7] = A;
  notes[8] = B;


  xoffset = width/columns;
  yoffset = height/rows;
  highest_pixels = new PVector[columns*rows];
  highest_depth = new int[9];
  //depthInMeter = 0;
}


void draw() {
  background(0);

  PImage img = kinect.getDepthImage(); 
  image(img, 0, 0);
  int skip = 20;


  depth = kinect.getRawDepth();
  if (depth == null) return;

  int current_quadrant = 0;
  for (int col = 0; col < columns; col++) {
    for (int row = 0; row < rows; row++) {
      
      int most_shallow = 10000;
      for (int x = int(col*xoffset); x < int((col+1)*xoffset); x+= skip) {
        for (int y = int(row*yoffset); y < int((row+1)*yoffset); y+= skip) {

          int offset =  x + y*kinect.width;
          int rawDepth = depth[offset];
          
          //-------- here we only get the highest
          if(rawDepth < most_shallow){
           most_shallow = rawDepth;
           highest_depth[current_quadrant] = most_shallow;
           highest_pixels[current_quadrant] = new PVector(x, y);
          
        } } }
      
      current_quadrant++; }  }
    
    if (highest_depth[0] < T && C1.isPlaying() == false){
           depthInMeters = 1.0 / (highest_depth[0] * -0.0030711016 + 3.3309495161);
  
           C1.play();
           println("0 q: ", depthInMeters);
          }
          //C1.pause();
     else if (highest_depth[0] > T && C1.isPlaying() == true){
       C1.pause();}
    if (highest_depth[1] < T && E.isPlaying() == false){
            E.play();
            println("1 q: ", highest_depth[1]);
            
          }
     else if (highest_depth[1] > T && Ab.isPlaying() == true){
       E.pause();}
    if (highest_depth[2] < T && Ab.isPlaying() == false){
            Ab.play();
            println("2 q: ", highest_depth[2]);
            
          }
     else if (highest_depth[2] > T && Ab.isPlaying() == true){
       Ab.pause();}
          
    if (highest_depth[3] < T && C2beat.isPlaying() == false){
            C2beat.play();
            println("3 q: ", highest_depth[3]);
            
          }
      else if (highest_depth[3] > T && C2beat.isPlaying() == true){
       C2beat.pause();}
    if (highest_depth[4] < T && F.isPlaying() == false){
            F.play();
            
            
            ////fill(1, 58, 87, 40); 
            //ellipse(height/2, width/2, width/3-30, width/3-30);
            
      
            
            depthInMeters = 1.0 / (highest_depth[4] * -0.0030711016 + 3.3309495161);
            println("4 q: ", highest_depth[4], "meter: ", depthInMeters);
          }
      else if (highest_depth[4] > T && F.isPlaying() == true){
       F.pause();}
    if (highest_depth[5] < T && A.isPlaying() == false){
            A.play();
            println("5 q: ", highest_depth[5]);
            
          }   
        else if (highest_depth[5] > T && A.isPlaying() == true){
       A.pause();}
      if (highest_depth[6] < T && Eb.isPlaying() == false){
            Eb.play();
            println("6 q: ", highest_depth[6]);
            
          } 
        else if (highest_depth[6] > T && Eb.isPlaying() == true){
       Eb.pause();}
      if (highest_depth[7] < T && G.isPlaying() == false){
            G.play();
            println("7 q: ", highest_depth[7]);
            
          }
       else if (highest_depth[7] > T && G.isPlaying() == true){
       G.pause();}
     if (highest_depth[8] < T && B.isPlaying() == false){
            B.play();
            println("8 q: ", highest_depth[8]);
            
          }
           else if (highest_depth[8] > T && B.isPlaying() == true){
       B.pause();}


  for(int i = 0; i < highest_pixels.length; i++){
    if (highest_pixels[i] != null){
   //ellipse(highest_pixels[i].x, highest_pixels[i].y, 10, 10); }
   
    fill(141,184,250);
     ellipse(highest_pixels[i].x, highest_pixels[i].y, 10, 10); }
   
  }

  stroke(255);
  strokeWeight(2);
  for (int x = 0; x < width; x+= xoffset) {
    line(x, 0, x, height);
  }

  for (int y = 0; y < height; y+= yoffset) {
    line(0, y, width, y);
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      t1+=40;
    } else if (keyCode == DOWN) {
      t1-=40;
    }
  }

  println(t1);
}
