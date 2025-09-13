//// ---- Sample Scenes ----
//class SceneA implements Scene {
//float t;
//void enter() { t = 0; }
//void render() {
//noStroke(); fill(255);
//float r = 120 + 60*sin(t);
//ellipse(width*0.5, height*0.5, r, r);
//drawLabel("Scene A : N→/→, P←/←, 1/2/3 jump");
//}
//}




//void enter() {}
//void render() {}


//// ---- Scene1 ----
class Scene1 implements Scene {
  int num = 20;
  float colW = width/num;
  float colH = height/num;
  float[] colY = new float[num];
  float[] colYSpeed = new float[num];
  float[] colColor = new float[num];
  void enter() {
    background(0);
    noStroke();
    fill(100);
    for(int i = 0 ; i < num ; i++) {
      colYSpeed[i] = random(10)+7;
      colY[i] = random(height);
    };
  };
  void render() {
    rectMode(CORNER);
    background(0);
    noStroke();

    colorMode(HSB,100);
    for(int i = 0; i < num; i++){
      if(colY[i] < 0 - colH -400){
        colYSpeed[i] = random(10)+7;
        colY[i] = height + colH;
      }
      colY[i] = colY[i] - colYSpeed[i];

      pushMatrix();
        translate(colW * i, colY[i]);
        // fill(20, 60, 100);
        fill(100);
        scale(0.8);
        translate(20,0);
        beginShape(QUADS);
          vertex(0,  random(400));
          vertex( colW,  random(400));
          vertex( colW, 0);
          vertex(0, 0);
        endShape();
      popMatrix();
    };
  };
}

//// ---- Scene2 ----
class Scene2 implements Scene {
  float angle = 0;
  void enter() {
    colorMode(RGB,255);
    background(0);
    noStroke();
  };
  void render() {
    stroke(255);
    fill(255);

    angle += 0.03;
    pushMatrix();
      translate(width/2, height/2);
      rotate(angle);
      
      float p1x =noise(t/100,1)*width/2;
      float p1y =noise(t/100,2)*height/2;
      float p2x =noise(t/100,3)*width/2;
      float p2y =noise(t/100,4)*height/2;
      float p3x =noise(t/100,5)*width/2;
      float p3y =noise(t/100,6)*height/2;

      for(int i = 0; i < 30; i++){
        rotate(TWO_PI/30);

        circle(p1x, p1y, 8);
        circle(p2x, p2y, 8);
        circle(p3x, p3y, 8);
        line( p1x, p1y, p2x, p2y);
        line(p3x, p3y, p2x, p2y);
        line(p1x, p1y, p3x, p3y);
      };
    popMatrix();
  };
} 




//// ---- Scene3 ----
class Scene3 implements Scene {
  int num = 8;
  float colH = 20;
  float[] colY = new float[num];
  void enter() {
    background(0);
    noStroke();
    fill(100);
  };
  void render() {
    colorMode(HSB,100);

    fill(100);
    if(colY[0] < 0 - 20){
      colY[0] = height + 20;
    }
    colY[0] = colY[0] - 10;
    
    pushMatrix();
      translate(0, colY[0]);
      beginShape(QUADS);
        vertex(0,  20);
        vertex( width,  20);
        vertex( width, 0);
        vertex(0, 0);
      endShape();
    popMatrix();
    
  };
}

//// ---- Scene4 ----
class Scene4 implements Scene {
  int num = 8;
  float[] pX = new float[num];
  float[] pY = new float[num];

  void enter() {
    background(0);
    fill(100);
    noStroke();
  };
  void render() {
    colorMode(HSB,100);
    background(0);
    fill(100);

    for(int i = 0; i < num; i ++){
      pX[i] = noise(frameCount/30. + i * 1.321,i * 923)*width * 1.4 - width *0.15;
      pY[i] = noise(frameCount/30. + i * 3.123,i*12345) *height * 1.4- height *0.15;
    }

    beginShape();
    for(int i = 0; i < num; i ++){
      vertex(pX[i], pY[i]);
    }
    endShape();
    
    beginShape();
    for(int i = 0; i < num; i ++){
      vertex(width -pX[i], pY[i]);
    }
    endShape();
  };
}
//// ---- Scene5 ----
class Scene5 implements Scene {
  int frame = 0;
  void enter() {
    background(0);
    noStroke();
    fill(100);
  };
  void render() {
    colorMode(HSB,100);
    background(0);
    noStroke();
    fill(100);

    float pW = random(400);    
    float pH = random(400);    
    float pX = random(width);    
    float pY = random(height);

    pushMatrix();
      translate(pX, pY);
      beginShape(QUADS);
        vertex(-pW/2,  -pH/2);
        vertex( pW/2, -pH/2);
        vertex( pW/2, pH/2);
        vertex(-pW/2, pH/2);
      endShape();
    popMatrix();
     pushMatrix();
      translate(pX, pY);
      beginShape(QUADS);
        vertex(-pW/2,  -pH/2);
        vertex( pW/2, -pH/2);
        vertex( pW/2, pH/2);
        vertex(-pW/2, pH/2);
      endShape();
    popMatrix();
  };
}

//// ---- Scene6 ----
class Scene6 implements Scene {


  int num = 10;
  void enter() {
    background(0);
    noStroke();
    fill(100);
  };
  void render() {
    colorMode(HSB,100);
    noStroke();
    fill(100);

    // float pW = random(400);    
    // float pH = random(400);    
    float pX = random(width);    
    float pY = random(height);


    for(int i =0; i < num ; i++){
      for(int j =0; j < height/(width / num) +1 ; j++){
        float pW = random(60);
        float pH = random(20);
        fill(100);
        pushMatrix();
          translate( i * width / num , j * width / num);

          translate(noise(frameCount/100.123,i*100 + j*3000)*100,noise(frameCount/78.63,i*200 + j*6000)*100);

          rotate((int)random(2) *PI/2);

          // fill(0, (int)random(2) *  60,100);
          

          beginShape(QUADS);
            vertex(-pW, -pH);
            vertex( pW, -pH);
            vertex( pW, pH);
            vertex(-pW, pH);
          endShape();
        popMatrix();
      }
    }
  };
} 
//// ---- Scene7 ----
class Scene7 implements Scene {
  int num = 8;
  float YS[] = new float[num];
  float colW = width/8;
  float colH = 10;
  float colY[] = new float[num];
  float[] colHue = new float[num];

  void enter() {
    background(0);
    noStroke();
    fill(100);
    for(int i = 0; i < num; i++){
      YS[i] = random(16)+8;
    };
  };

  void render() {
    colorMode(HSB,100);
    background(0);
    
    for(int i = 0; i < num; i++){
      if(colY[i] < 0 - colH){
        YS[i] = (random(16)+8);
      }
      if(colY[i] > height - colH){
        YS[i] = -(random(16)+8);
      }
      colY[i] = colY[i] + YS[i];

      if(random(1) < 0.1){
        colY[i] = random(height);
      }
      fill(100);      
      pushMatrix();
      translate( width/num * i + (width/num/2), colY[i]);
      beginShape(QUADS);
        vertex(-70, -colH + random(80));
        vertex( 70, -colH + random(80));
        vertex( 70, colH + random(80));
        vertex(-70, colH + random(80));
      endShape();
      popMatrix();
    };
  };
}

//// ---- Scene8 ----
class Scene8 implements Scene {
  void enter() {
    background(0);
    noStroke();
  };
  void render() {
    colorMode(HSB,100);
    rectMode(CENTER);
    fill(100);
    push();
    translate(width/2, height/2);
    // translate(0, height/2);
    
    for(int i =0; i < 10; i ++){
      push();
      float x = random(-width, width);
      float y = random(-h/4, h/4);
      float w = random(width/2);
      float h = random(height/40);
      rotate(radians(frameCount *1));
      for(int j =0; j < 6; j ++){
        rotate(radians(60));
        rect(x,y,w,h);
      }
      pop();
    }

    pop();
  };

}

//// ---- Scene9 ----
class Scene9 implements Scene {
  float time = 0;
  float y = 0;
  
  float cellW = width/40;
  float cellH = height/8;
  void enter() {
    colorMode(HSB,100);
    background(0);
    noStroke();
    fill(100);
  };
  void render() {
    rectMode(CORNER);
    colorMode(HSB,100);
    fill(100);
    background(0);    

    cellH = random(1)*random(1)*height/4;
    // for(int i = 0; i< 8; i ++){
    //   y = (sin(time + i/2.)+1) * (height - cellH) /2;
    //   rect(i*cellW+4, y, cellW-8, cellH);
    // }    

    float x = 0;
    int i = 0;
    while(x < width){
      y = (sin(-time + i/8.)+1) * (height - cellH) /2;
      rect(i*cellW+4, y, cellW-8, cellH);
      x += cellW;
      i++;
    }    
    time = time + 0.1;

  };

}

//// ---- Scene10 ----
class Scene10 implements Scene {
  int num = 20;
  float colH = 4;
  float[] colY = new float[num];
  void enter() {
    background(0);
    noStroke();
    fill(100);
    for(int i = 0 ; i < num ; i++) {
      colY[i] = random(h);
    };
  };
  void render() {
    rectMode(CORNER);
    colorMode(HSB,100);
    fill(100);
    for(int i = 0; i < num; i ++){
      rect(0, colY[i], width, colH);
      if(colY[i] < 0 - 20){
        colY[i] = height + 20 + i * 50;
      }
      colY[i] = colY[i] - (3 + i/16);
    }
    // colY[0] = colY[0] - 10;
    // rect(0, colY[0], width, 20);
  };
} 


//// ---- Scene11 ----
class Scene11 implements Scene {
  void enter(){}
  void render(){
    rectMode(CENTER);
    colorMode(RGB,255);
    background(0);
    fill(255);
    noStroke();
    float i = 0;
    float gap;
    while(i < height){
      gap = random(80);
      float rectW = random(width);
      rect(random(width),i,rectW,gap);   
      i += gap;
    } 
  }
}

//// ---- Scene12 ----
class Scene12 implements Scene {
  void enter(){}
  void render(){
    rectMode(CENTER);
    colorMode(RGB,255);
    background(0);
    fill(255);
    noStroke();
    float i = 0;
    while(i < height){
      rect(random(width),i,random((width/8)),9);   
      i += 10;
    }
  }
}
