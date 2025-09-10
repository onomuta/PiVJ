Clip1 clip1;
Clip2 clip2;
Clip3 clip3;
Clip4 clip4;
Clip5 clip5;
Clip6 clip6;
Clip7 clip7;
Clip8 clip8;
Clip9 clip9;
Clip10 clip10;
Clip11 clip11;
Clip12 clip12;
Clip13 clip13;
Clip14 clip14;
Clip15 clip15;
Clip16 clip16;
Clip17 clip17;
Clip18 clip18;
Clip19 clip19;
Clip20 clip20;


float[] baseColor ={0.5, 1, 1};
int clip;
float t = 0;

float colorR = 1;
float colorG = 1;
float colorB = 1;

void setup() {
  colorMode(HSB, 100);
  // size(320, 180,P3D);
  size(1280, 720,P3D);
  //fullScreen(P3D);
  noCursor();
  frameRate(60);

  clip1 = new Clip1();
  clip2 = new Clip2();
  clip3 = new Clip3();
  clip4 = new Clip4();
  clip5 = new Clip5();
  clip6 = new Clip6();
  clip7 = new Clip7();
  clip8 = new Clip8();
  clip9 = new Clip9();
  clip10 = new Clip10();
  clip11 = new Clip11();
  clip12 = new Clip12();
  clip13 = new Clip13();
  clip14 = new Clip14();
  clip15 = new Clip15();
  clip16 = new Clip16();
  clip17 = new Clip17();
  clip18 = new Clip18();
  clip19 = new Clip19();
  clip20 = new Clip20();
};

void draw() {
  push();
  colorSelector();

  if (clip == 1) {
    clip1.setup();
    clip1.run();
  } else if (clip==2) {
    clip2.setup();
    clip2.run();
  } else if (clip==3) {
    clip3.setup();
    clip3.run();
  } else if (clip==4) {
    clip4.setup();
    clip4.run();
  } else if (clip==5) {
    clip5.setup();
    clip5.run();
  } else if (clip==6) {
    clip6.setup();
    clip6.run();
  } else if (clip==7) {
    clip7.setup();
    clip7.run();
  } else if (clip==8) {
    clip8.setup();
    clip8.run();
  } else if (clip==9) {
    clip9.setup();
    clip9.run();
  } else if (clip==10) {
    clip10.setup();
    clip10.run();
  } else if (clip==11) {
    clip11.setup();
    clip11.run();
  }else if (clip==12) {
    clip12.setup();
    clip12.run();
  } else if (clip==13) {
    clip13.setup();
    clip13.run();
  } else if (clip==14) {
    clip14.setup();
    clip14.run();
  } else if (clip==15) {
    clip15.setup();
    clip15.run();
  } else if (clip==16) {
    clip16.setup();
    clip16.run();
  } else if (clip==17) {
    clip17.setup();
    clip17.run();
  } else if (clip==18) {
    clip18.setup();
    clip18.run();
  } else if (clip==19) {
    clip19.setup();
    clip19.run();
  } else if (clip==20) {
    clip20.setup();
    clip20.run();
  };
  
  pop();
  t++;
  fill(0);
  rect(10,10,100,14);
  fill(100);
  text("clip" + clip + "   " + frameRate,16,21);
};


void colorSelector() {
  if (colorR == 1 && colorG == 1 && colorB == 1) {
    baseColor[0] = random(1);
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 0 && colorG == 0 && colorB == 0) {
    baseColor[0] = 1;
    baseColor[1] = 0;
    baseColor[2] = 1;
  } else if (colorR == 1 && colorG == 0 && colorB == 0) {
    baseColor[0] = 0;
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 1 && colorG == 1 && colorB == 0) {
    baseColor[0] = 0.15;
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 0 && colorG == 1 && colorB == 0) {
    baseColor[0] = 0.3;
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 0 && colorG == 1 && colorB == 1) {
    baseColor[0] = 0.5;
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 0 && colorG == 0 && colorB == 1) {
    baseColor[0] = 0.65;
    baseColor[1] = 1;
    baseColor[2] = 1;
  } else if (colorR == 1 && colorG == 0 && colorB == 1) {
    baseColor[0] = 0.85;
    baseColor[1] = 1;
    baseColor[2] = 1;
  }
};


void keyPressed() {
  if (key == 'r' || key == 'R') {
    colorR ++;
    colorR = colorR % 2;
  } else if (key == 'g' || key == 'G') {
    colorG ++;
    colorG = colorG % 2;
  } else if (key == 'b' || key == 'B') {
    colorB ++;
    colorB = colorB % 2;
  }
  
  
  if(key == '0'){
    clip=0;
  }else if(key == '1'){
    clip=1;
  }else if(key == '2'){
    clip=2;
  }else if(key == '3'){
    clip=3;
  }else if(key == '4'){
    clip=4;
  }else if(key == '5'){
    clip=5;
  }else if(key == '6'){
    clip=6;
  }else if(key == '7'){
    clip=7;
  }else if(key == '8'){
    clip=8;
  }else if(key == '9'){
    clip=9;
  }else if(key == 'q'){
    clip=12;
  }else if(key == 'w'){
    clip=13;
  }else if(key == 'e'){
    clip=14;
  }else if(key == 'r'){
    clip=15;
  }else if(key == 't'){
    clip=16;
  }else if(key == 'y'){
    clip=17;
  }else if(key == 'u'){
    clip=18;
  }else if(key == 'i'){
    clip=19;
  }else if(key == 'o'){
    clip=20;
  }
}
