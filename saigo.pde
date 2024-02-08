float cam = 300;//cameraの距離
float x ; //3rd linkの伸び縮み
float jump ;
float k=1;//jump力の倍率
float a=1;//angle1の角速度にかかわる
float u = -100; //targetのx座標位置
float w= 50;//targetのz座標位置
float ww;//targetと光の照射位置のz座標の差


float baseH = 10;

float arm1W = 10;
float arm1D = 10;
float arm1L = 50;

float arm2W = 8;
float arm2D = 8;
float arm2L = arm1L;

float arm3W = 5;
float arm3D = 5;
float arm3L =10;

float angle0z = 0;
float b= 0;
float angle1 ;
float angle3 =0;

float dif = 1.0;

void setup(){
  size(1000, 1000, P3D);
  camera(cam, cam, cam, 0, 0, 0, 0, 0, -1);
  noStroke();  
}

void draw(){
  background(255);
  
  if(keyPressed){
    
    if(key=='o'){ //全体の回転
      angle0z+=dif;
    }
      if(key=='z'){ 
      angle3+=dif;
    }
     if(key=='u'){ 
      u+=1;
    }
     if(key=='w'){ 
       w+=1;
    }
       if(key=='U'){ 
      u+=-1;
    }
      if(key=='W'){ 
       w+=-1;
      }
      
    if(key == 'r'){ //reset
      angle0z = 0;
      angle1 = 0;
      angle3 =0;
      k=0;
      u=-100;
      w=50;
    }
  }
  
  if (keyPressed && key == ' ') {
    if (40< angle1 && angle1 < 60) {
    k += 0.1;
}
  else if ( angle1 <40) {
    k=1;
}
}
  
  //土台
  rotateZ(radians(angle0z));
  translate(0,0,baseH/2);
  fill(150);
  box(50,50,baseH);
  
   //target
  pushMatrix();
  rotateZ(radians(angle3));
  translate(u,0,w+baseH/2);
  fill(255,0,0);
  sphere(10);
  popMatrix();
  
   //支柱(伸縮する)
   pushMatrix();
   translate(0,0,jump/2);
   fill(200);
   box(3,3,jump);
   popMatrix();
  
  // jump
jump =k*50*(1-sin(radians(angle1)));
  translate(0,0,jump);
   fill(200);
   sphere(10);
   
  //1st link
  rotateY(radians(angle1));
  translate(0,0,baseH/2+arm1L/2);
  fill(125);
  box(arm1W,arm1D,arm1L);
  
  //2nd link
  translate(0,0,arm1L/2);
  rotateY(-2*radians(angle1));  
   fill(200);
   sphere(10);
  //go to center of 2nd joint
  translate(0,0,arm2L/2);
  fill(125);
  box(arm2W,arm2D,arm2L);
  
  //3rd link 伸び縮みする
  translate(0, 0, arm2L/2);
  rotateY(radians(angle1));
   fill(200);
   sphere(10);
   // go to center of 3rd joint
  translate(0, 0, 5+x/2);
  fill(200,200,0);
  box(arm3W,arm3D,10+x);
  translate(0, 0, 10+x/2);
  fill(200);
  sphere(10);
  rotateZ(radians(angle3));
  box(10,50,10);
  
   //xの指定
  x=(arm2L+arm3L)*(1-cos(radians(angle1)));
  //角度angle1の変化の仕方
  b +=a;
  angle1=b*b/10;
  if ((angle1>60)){
a=-a;
}  
  
  //レイザー
  ww=2*arm2L*cos(radians(angle1))+jump-w;//
  if(angle1<1){
  translate(0,0,-x-10);
  rotateY(PI+atan(-u/ww));
  
  if(ww<0){
    rotateY(PI);
  }
  translate(0,0,0.5*sqrt(u*u+ww*ww));
  fill(0,255,0);
  box(1,1,sqrt(u*u+ww*ww));
}
 
}
   
