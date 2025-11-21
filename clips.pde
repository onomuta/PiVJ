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


//// ---- Scene0 ----
class Scene0 implements Scene {
  int num = 20;
  float colW = width/num;
  float colH = height/num;
  float[] r = new float[num];
  float[] rSpeed = new float[num];
  float[] sw = new float[num];
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    for(int i = 0; i < num; i++){
      r[i] = random(w*2);
      rSpeed[i] = random(4,16);
      sw[i] = random(1,16);
    }
  };
  void render() {
    push();
    rectMode(CORNER);
    drawBackground();
    noFill();
    setColorizeStroke();
    translate(width/2, height/2);

    for(int i = 0; i < num; i++){
      r[i] += rSpeed[i];
      strokeWeight(sw[i]);
      circle(0,0,r[i]);
      if(r[i] > w*2){
        r[i] = 0;
        rSpeed[i] = random(4,16);
        sw[i] = random(1,16);
      }
    }

    pop();
  };
}

//// ---- Scene1 ----
class Scene1 implements Scene {
  int num = 20;
  float colW = width/num;
  float colH = height/num;
  float[] colY = new float[num];
  float[] colYSpeed = new float[num];
  float[] colColor = new float[num];
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    for(int i = 0 ; i < num ; i++) {
      colYSpeed[i] = random(10)+7;
      colY[i] = random(height);
    };
  };
  void render() {
    rectMode(CORNER);
    drawBackground();
    noStroke();

    for(int i = 0; i < num; i++){
      if(colY[i] < 0 - colH -400){
        colYSpeed[i] = random(10)+7;
        colY[i] = height + colH;
      }
      colY[i] = colY[i] - colYSpeed[i];

      pushMatrix();
        translate(colW * i, colY[i]);
        setColorizeFill();
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
  float s;
  void enter() {
    colorMode(RGB,255);
    noStroke();
    s = random(100);
  };
  void render() {
    drawBackground();
    setColorizeStroke();
    setColorizeFill();

    angle += 0.02;
    pushMatrix();
      translate(width/2, height/2);
      rotate(angle);
      
      float p1x =noise(t/100,1 + s)*width/2;
      float p1y =noise(t/100,2 + s)*height/2;
      float p2x =noise(t/100,3 + s)*width/2;
      float p2y =noise(t/100,4 + s)*height/2;
      float p3x =noise(t/100,5 + s)*width/2;
      float p3y =noise(t/100,6 + s)*height/2;

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
    drawBackground();
    noStroke();
    setColorizeFill();
  };
  void render() {
    drawBackground();
    setColorizeFill();
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
  float s;

  void enter() {
    drawBackground();
    setColorizeFill();
    noStroke();
    s = random(100);
  };
  void render() {
    drawBackground();
    setColorizeFill();

    for(int i = 0; i < num; i ++){
      pX[i] = noise(frameCount/30. + i * 1.321,i * 923 + s)*width * 1.4 - width *0.15;
      pY[i] = noise(frameCount/30. + i * 3.123,i*12345 + s) *height * 1.4- height *0.15;
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
    drawBackground();
    noStroke();
    setColorizeFill();
  };
  void render() {
    drawBackground();
    noStroke();
    setColorizeFill();

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
    noStroke();
    setColorizeFill();
  };
  void render() {
    drawBackground();
    noStroke();
    setColorizeFill();

    // float pX = random(width);    
    // float pY = random(height);

    for(int i =0; i < num ; i++){
      for(int j =0; j < height/(width / num) +1 ; j++){
        float pW = random(60);
        float pH = random(20);
        pushMatrix();
          translate( i * width / num , j * width / num);
          translate(noise(frameCount/100.123,i*100 + j*3000)*100,noise(frameCount/78.63,i*200 + j*6000)*100);
          rotate((int)random(2) *PI/2);

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
    drawBackground();
    noStroke();
    setColorizeFill();
    for(int i = 0; i < num; i++){
      YS[i] = random(16)+8;
    };
  };

  void render() {
    drawBackground();
    
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
      setColorizeFill();
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
    noStroke();
  };
  void render() {
    drawBackground();
    rectMode(CENTER);
    setColorizeFill();
    push();
    translate(width/2, height/2);
    
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
    noStroke();
    setColorizeFill();
  };
  void render() {
    rectMode(CORNER);
    drawBackground();    

    cellH = random(1)*random(1)*height/4;
    setColorizeFill();

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
    drawBackground();
    noStroke();
    setColorizeFill();
    for(int i = 0 ; i < num ; i++) {
      colY[i] = random(h);
    };
  };
  void render() {
    drawBackground();
    rectMode(CORNER);
    setColorizeFill();
    for(int i = 0; i < num; i ++){
      rect(0, colY[i], width, colH);
      if(colY[i] < 0 - 20){
        colY[i] = height + 20 + i * 50;
      }
      colY[i] = colY[i] - (3 + i/16);
    }
  };
} 

//// ---- Scene11 ----
class Scene11 implements Scene {
  void enter(){}
  void render(){
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    float i = 0;
    float gap;
    while(i < width){
      gap = random(30);
      float rectH = random(height);
      rect(i,random(h),gap,rectH);   
      i += gap + random(30);
    } 
  }
}

//// ---- Scene12 ----
class Scene12 implements Scene {
  void enter(){}
  void render(){
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    float i = 0;
    while(i < height){
      rect(random(width),i,random((width/8)),9);   
      i += 10;
    }
  }
}

//// ---- Scene13 ----
class Scene13 implements Scene {
  // 四角形の数
  final int NUM_RECTS = 16;
  // 四角形の位置・サイズ・移動速度を保持する配列
  float[] rectX = new float[NUM_RECTS];
  float[] rectY = new float[NUM_RECTS];
  float[] rectW = new float[NUM_RECTS];
  float[] rectH = new float[NUM_RECTS];
  float[] vx = new float[NUM_RECTS];
  float[] vy = new float[NUM_RECTS];

  void enter() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    // 四角形の初期位置・サイズ・速度をランダムに設定
    for (int i = 0; i < NUM_RECTS; i++) {
      rectX[i] = random(width);
      rectY[i] = random(height);
      rectW[i] = random(20, 90); // 小さめに
      rectH[i] = random(20, 90);
      vx[i] = random(-0.5, 0.5); // ゆったり動く
      vy[i] = random(-0.5, 0.5);
    }
  }

  void render() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    for (int i = 0; i < NUM_RECTS; i++) {
      // 位置を更新（ゆったり動く）
      rectX[i] += vx[i];
      rectY[i] += vy[i];
      // 画面端で跳ね返る
      if (rectX[i] < 0 || rectX[i] > width)  vx[i] *= -1;
      if (rectY[i] < 0 || rectY[i] > height) vy[i] *= -1;
      rect(rectX[i], rectY[i], rectW[i], rectH[i]);
    }
  }
}

//// ---- Scene14 ----
class Scene14 implements Scene {
  float time = 0;
  float y = 0;
  
  float cellW;
  float cellH;
  float s;
  void enter() {
    noStroke();

    s = random(100);
    cellW = random(width/40,width/4);
  };
  void render() {
    rectMode(CORNER);
    drawBackground();    
    setColorizeFill();

    cellH = random(1)*random(1)*height/4;

    float x = 0;
    int i = 0;
    while(x < width){
      for(int j = 0; j < 6; j++){
        y=random(height);
        cellH =random(height/40)*random(2)*random(2);
        rect(i*cellW+4, y, cellW-8, cellH);
      }
      x += cellW;
      i++;
    }    
    time = time + 0.1;
  };
}

//// ---- Scene15 ----
class Scene15 implements Scene {
  // 四角形の数
  final int NUM_RECTS = 2000;
  // 四角形の位置・サイズ・移動速度を保持する配列
  float[] rectX = new float[NUM_RECTS];
  float[] rectY = new float[NUM_RECTS];
  float[] rectW = new float[NUM_RECTS];
  float[] rectH = new float[NUM_RECTS];
  float[] vx = new float[NUM_RECTS];
  float[] vy = new float[NUM_RECTS];

  void enter() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    // 四角形の初期位置・サイズ・速度をランダムに設定
    for (int i = 0; i < NUM_RECTS; i++) {
      rectX[i] = random(width);
      rectY[i] = random(height);
      rectW[i] = random(1, 8); // 小さめに
      rectH[i] = random(1, 8);
      // vx[i] = random(-0.5, 0.5); // ゆったり動く
      vx[i] = random(0); // ゆったり動く
      vy[i] = random(-4.5, -0.1);
    }
  }

  void render() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    for (int i = 0; i < NUM_RECTS; i++) {
      // 位置を更新（ゆったり動く）
      rectX[i] += vx[i];
      rectY[i] += vy[i];
      rectW[i] = random(1, 18); // 小さめに
      rectW[i] = random(0, 3)*random(0, 3)*random(0, 3);
      rectH[i] = random(0, 3)*random(0, 3)*random(0, 3);
      // 画面端で跳ね返る
      // if (rectX[i] < 0 || rectX[i] > width)  vx[i] *= -1;
      if (rectY[i] < 0) rectY[i] = height;
      if (rectY[i] > height) rectY[i] = 0;
      rect(rectX[i], rectY[i], rectW[i], rectW[i]);
    }
  }
}

//// ---- Scene16 ----
class Scene16 implements Scene {
  // 四角形の数
  final int NUM_RECTS = 2000;
  // 四角形の位置・サイズ・移動速度を保持する配列
  float[] rectX = new float[NUM_RECTS];
  float[] rectY = new float[NUM_RECTS];
  float[] rectW = new float[NUM_RECTS];
  float[] rectH = new float[NUM_RECTS];
  float[] vx = new float[NUM_RECTS];
  float[] vy = new float[NUM_RECTS];

  void enter() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    // 四角形の初期位置・サイズ・速度をランダムに設定
    for (int i = 0; i < NUM_RECTS; i++) {
      rectX[i] = random(width);
      rectY[i] = random(height);
      rectW[i] = random(1, 3); // 小さめに
      rectH[i] = random(1, 3);
      // vx[i] = random(-0.5, 0.5); // ゆったり動く
      vx[i] = random(0); // ゆったり動く
      vy[i] = random(-0.2, -0.01);
    }
  }

  void render() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    for (int i = 0; i < NUM_RECTS; i++) {
      // 位置を更新（ゆったり動く）
      rectX[i] += vx[i];
      rectY[i] += vy[i];
      // rectW[i] = random(0.5, 3); // 小さめに
      // rectW[i] = random(0.5, 3); // 小さめに
      // rectW[i] = random(0, 3)*random(0, 3)*random(0, 3);
      // rectH[i] = random(0, 3)*random(0, 3)*random(0, 3);
      // 画面端で跳ね返る
      // if (rectX[i] < 0 || rectX[i] > width)  vx[i] *= -1;
      if (rectY[i] < 0) rectY[i] = height;
      if (rectY[i] > height) rectY[i] = 0;
      rect(rectX[i], rectY[i], rectW[i], rectH[i]);
    }
  }
}

//// ---- Scene17 ----
class Scene17 implements Scene {
  // 四角形の数
  final int NUM_RECTS = 400;
  // 四角形の位置・サイズ・移動速度を保持する配列
  float[] rectX = new float[NUM_RECTS];
  float[] rectY = new float[NUM_RECTS];
  float[] rectW = new float[NUM_RECTS];
  float[] rectH = new float[NUM_RECTS];
  float[] vx = new float[NUM_RECTS];
  float[] vy = new float[NUM_RECTS];


  float[] rotateSpeed = new float[NUM_RECTS];
  float[] position  = new float[NUM_RECTS];
  float[] sw = new float[NUM_RECTS];
  float[] sl = new float[NUM_RECTS];



  void enter() {
    rectMode(CENTER);
    drawBackground();
    setColorizeFill();
    noStroke();
    // 四角形の初期位置・サイズ・速度をランダムに設定
    for (int i = 0; i < NUM_RECTS; i++) {
      rotateSpeed[i] = random(-0.03, 0.03);
      position[i] = random(6.28);
      sw[i] = random(0.1,2);
      sl[i] = random(0,1);
    }
  }

  void render() {
    push();

    rectMode(CENTER);
    drawBackground();
    noFill();
    setColorizeStroke();

    translate(width/2, height/2);

    
    for(int i = 0; i < NUM_RECTS; i++){
      push();
      strokeWeight(sw[i]);
      position[i] += rotateSpeed[i];
      rotate(position[i]);
      arc(0,0,i*6,i*6,0,sl[i]);

      pop();
    }



    pop();

    
  }
}

//// ---- Scene18 ----
class Scene18 implements Scene {
  int gridSize = 20;
  int cols, rows;
  float time = 0;
  
  // 各タイルの個別のランダム値
  float[][] tileSeeds;
  float[][] tileSpeeds;
  float[][] tileSizes;
  boolean[][] tileVisible;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    cols = width / gridSize;
    rows = height / gridSize;
    
    // 各タイルのランダム値を初期化
    tileSeeds = new float[cols][rows];
    tileSpeeds = new float[cols][rows];
    tileSizes = new float[cols][rows];
    tileVisible = new boolean[cols][rows];
    
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        tileSeeds[i][j] = random(1000);
        tileSpeeds[i][j] = random(0.5, 3.0);
        tileSizes[i][j] = random(0.3, 1.5);
        tileVisible[i][j] = random(1) < 0.8; // 80%の確率で表示
      }
    }
  }
  
  void render() {
    strokeWeight(1);
    drawBackground();
    time += 0.02;
    
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (!tileVisible[i][j]) continue; // 非表示タイルはスキップ
        
        pushMatrix();
        
        float x = i * gridSize + gridSize / 2;
        float y = j * gridSize + gridSize / 2;
        translate(x, y);
        
        // 各タイルの個別のランダムな動き
        float seed = tileSeeds[i][j];
        float speed = tileSpeeds[i][j];
        float size = tileSizes[i][j];
        
        // ランダムなスケール変化
        float scalePulse = 0.5 + 0.5 * sin(time * speed * 2 + seed);
        scale(size * scalePulse);
        
        // ランダムな色変化
        if (Colorize) {
          colorMode(RGB, 255);
          float hue = (seed * 100 + time * 50) % 360;
          float sat = 50 + 50 * noise(seed + 300, time * 0.1);
          float bright = 100 + 100 * noise(seed + 400, time * 0.1);
          colorMode(HSB, 360, 100, 100);
          fill(hue, sat, bright);
        } else {
          colorMode(RGB, 255);
          float gray = 50 + 205 * noise(seed + 500, time * 0.1);
          fill(gray);
        }
        

        float shapeType = noise(seed + 600, time * 0.05);
        rectMode(CENTER);
        
        if (shapeType < 0.5) {
          setColorizeStroke();
          fillBlack();
        } else{
          setColorizeFill();
          strokeBlack();

        }
        float w = gridSize * 0.6;
        float h = gridSize * 0.6;
        rect(0, 0, w, h);
        // ランダムな確率で追加の装飾
        if (random(1) < 0.1) {
          if (Colorize) {
            fill(255, 255, 255);
          } else {
            fill(255);
          }
          ellipse(0, 0, gridSize * 0.1, gridSize * 0.1);
        }
        
        popMatrix();
      }
    }
  }
}

//// ---- Scene19 ----
class Scene19 implements Scene {
  final int NUM_RECTS = 40;
  float[] rectX = new float[NUM_RECTS];
  float[] rectY = new float[NUM_RECTS];
  float[] rectW = new float[NUM_RECTS];
  float[] rectH = new float[NUM_RECTS];
  float[] targetX = new float[NUM_RECTS];
  float[] targetY = new float[NUM_RECTS];
  float[] targetW = new float[NUM_RECTS];
  float[] targetH = new float[NUM_RECTS];
  float[] vx = new float[NUM_RECTS];
  float[] vy = new float[NUM_RECTS];
  float[] vw = new float[NUM_RECTS];
  float[] vh = new float[NUM_RECTS];
  float[] easeX = new float[NUM_RECTS];
  float[] easeY = new float[NUM_RECTS];
  float[] easeW = new float[NUM_RECTS];
  float[] easeH = new float[NUM_RECTS];
  float[] hue = new float[NUM_RECTS];
  float[] hueSpeed = new float[NUM_RECTS];
  // float[] rotation = new float[NUM_RECTS];
  // float[] rotationSpeed = new float[NUM_RECTS];
  float[] scale = new float[NUM_RECTS];
  float[] scaleTarget = new float[NUM_RECTS];
  float[] scaleEase = new float[NUM_RECTS];
  int[] changeTimer = new int[NUM_RECTS];
  int[] changeInterval = new int[NUM_RECTS];

  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    for (int i = 0; i < NUM_RECTS; i++) {
      rectX[i] = random(width);
      rectY[i] = random(height);
      rectW[i] = random(20, 120);
      rectH[i] = random(20, 120);
      targetX[i] = rectX[i];
      targetY[i] = rectY[i];
      targetW[i] = rectW[i];
      targetH[i] = rectH[i];
      vx[i] = random(-2, 2);
      vy[i] = random(-2, 2);
      vw[i] = random(-0.5, 0.5);
      vh[i] = random(-0.5, 0.5);
      easeX[i] = 0.04;
      easeY[i] = 0.04;
      easeW[i] = 0.04;
      easeH[i] = 0.04;
      scale[i] = 1.0;
      scaleTarget[i] = 1.0;
      changeTimer[i] = 0;
      changeInterval[i] = int(random(20, 60)); // フレーム間隔でターゲット変更


      changeTimer[i] = (int)random(20);
      targetX[i] = random(width);
      targetY[i] = random(height);
      targetW[i] = random(20, 120);
      targetH[i] = random(20, 120);
      scaleTarget[i] = random(0.3, 1.8);
    }
  }

  void render() {
    drawBackground();
    rectMode(CENTER);
    setColorizeStroke();
    noFill(); 
    
    for (int i = 0; i < NUM_RECTS; i++) {
      // ターゲット変更タイマー
      changeTimer[i]++;
      if (changeTimer[i] >= changeInterval[i]) {
        changeTimer[i] = 0;
        changeInterval[i] = int(random(0, 60));
        
        // 新しいターゲットを設定
        targetX[i] = random(width);
        targetY[i] = random(height);
        targetW[i] = random(20, 120);
        targetH[i] = random(20, 120);
        scaleTarget[i] = random(0.3, 1.8);
        
        // 速度をランダムに変更
        vx[i] = random(-3, 3);
        vy[i] = random(-3, 3);
        vw[i] = random(-1, 1);
        vh[i] = random(-1, 1);
        // rotationSpeed[i] = random(-0.1, 0.1);
      }
      
      // イージングでターゲットに向かって移動
      rectX[i] += (targetX[i] - rectX[i]) * easeX[i];
      rectY[i] += (targetY[i] - rectY[i]) * easeY[i];
      rectW[i] += (targetW[i] - rectW[i]) * easeW[i];
      rectH[i] += (targetH[i] - rectH[i]) * easeH[i];
      scale[i] += (scaleTarget[i] - scale[i]) * scaleEase[i];
      
      // 画面端での跳ね返り（オプション）
      if (rectX[i] < 0 || rectX[i] > width) {
        vx[i] *= -1;
        targetX[i] = random(width);
      }
      if (rectY[i] < 0 || rectY[i] > height) {
        vy[i] *= -1;
        targetY[i] = random(height);
      }
      // 描画
      pushMatrix();
      translate(rectX[i], rectY[i]);
      scale(scale[i]);
      rect(0, 0, rectW[i], rectH[i]);
      popMatrix();
    }
  }
}

//// ---- Scene20 ----
class Scene20 implements Scene {
  final int NUM_BOIDS = 250;
  Boid[] boids = new Boid[NUM_BOIDS];
  
  // 群れのパラメータ
  float separation = 25;    // 分離力
  float alignment = 20;     // 整列力
  float cohesion = 30;      // 結合力
  float maxSpeed = 3;       // 最大速度
  float maxForce = 0.1;     // 最大力
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // ボイドの初期化
    for (int i = 0; i < NUM_BOIDS; i++) {
      boids[i] = new Boid(random(width), random(height));
    }
  }

  void render() {
    drawBackground();
    setColorizeFill();
    noStroke();
    
    // ボイドの更新と描画
    for (int i = 0; i < NUM_BOIDS; i++) {
      boids[i].update(boids, separation, alignment, cohesion, maxSpeed, maxForce);
      boids[i].render();
    }
  }
  
  // ボイドクラス
  class Boid {
    PVector position;
    PVector velocity;
    PVector acceleration;
    float size;
    float hue;
    float hueSpeed;
    
    Boid(float x, float y) {
      position = new PVector(x, y);
      velocity = PVector.random2D();
      velocity.mult(random(0.5, 2));
      acceleration = new PVector(0, 0);
      size = random(8, 16);
      hue = random(360);
      hueSpeed = random(0.5, 2);
    }
    
    void update(Boid[] boids, float sep, float ali, float coh, float maxSpd, float maxFrc) {
      // 群れの力を計算
      PVector separate = separate(boids, sep);
      PVector align = align(boids, ali);
      PVector cohesion = cohesion(boids, coh);
      
      // 力を適用
      separate.mult(1.5);
      align.mult(1.0);
      cohesion.mult(1.0);
      
      acceleration.add(separate);
      acceleration.add(align);
      acceleration.add(cohesion);
      
      // 速度と位置を更新
      velocity.add(acceleration);
      velocity.limit(maxSpd);
      position.add(velocity);
      acceleration.mult(0);
      
      // 画面端で反対側に移動
      if (position.x < 0) position.x = width;
      if (position.x > width) position.x = 0;
      if (position.y < 0) position.y = height;
      if (position.y > height) position.y = 0;
      
      // 色の変化
      hue += hueSpeed;
      if (hue >= 360) hue = 0;
    }
    
    PVector separate(Boid[] boids, float desiredSeparation) {
      PVector steer = new PVector(0, 0);
      int count = 0;
      
      for (Boid other : boids) {
        float d = PVector.dist(position, other.position);
        if (d > 0 && d < desiredSeparation) {
          PVector diff = PVector.sub(position, other.position);
          diff.normalize();
          diff.div(d);
          steer.add(diff);
          count++;
        }
      }
      
      if (count > 0) {
        steer.div(count);
        steer.normalize();
        steer.mult(maxSpeed);
        steer.sub(velocity);
        steer.limit(maxForce);
      }
      
      return steer;
    }
    
    PVector align(Boid[] boids, float neighborDist) {
      PVector sum = new PVector(0, 0);
      int count = 0;
      
      for (Boid other : boids) {
        float d = PVector.dist(position, other.position);
        if (d > 0 && d < neighborDist) {
          sum.add(other.velocity);
          count++;
        }
      }
      
      if (count > 0) {
        sum.div(count);
        sum.normalize();
        sum.mult(maxSpeed);
        PVector steer = PVector.sub(sum, velocity);
        steer.limit(maxForce);
        return steer;
      } else {
        return new PVector(0, 0);
      }
    }
    
    PVector cohesion(Boid[] boids, float neighborDist) {
      PVector sum = new PVector(0, 0);
      int count = 0;
      
      for (Boid other : boids) {
        float d = PVector.dist(position, other.position);
        if (d > 0 && d < neighborDist) {
          sum.add(other.position);
          count++;
        }
      }
      
      if (count > 0) {
        sum.div(count);
        return seek(sum);
      } else {
        return new PVector(0, 0);
      }
    }
    
    PVector seek(PVector target) {
      PVector desired = PVector.sub(target, position);
      desired.normalize();
      desired.mult(maxSpeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxForce);
      return steer;
    }
    
    void render() {
      pushMatrix();
      translate(position.x, position.y);
      rotate(velocity.heading());
      
      noFill();
      setColorizeStroke();
      
      // ボイドの形状（三角形）
      // beginShape();
      // vertex(size, 0);
      // vertex(-size/2, -size/3);
      // vertex(-size/2, size/3);
      // endShape(CLOSE);
      line(0,0,size/2,0);
      circle(0, 0, size/2);
      
      // 軌跡の描画
      // ellipse(0, 0, size/2, size/2);
      
      popMatrix();
    }
  }
}

//// ---- Scene21 ----
class Scene21 implements Scene {
  final int MAX_RIPPLES = 40;
  float[] rippleX = new float[MAX_RIPPLES];
  float[] rippleY = new float[MAX_RIPPLES];
  float[] rippleRadius = new float[MAX_RIPPLES];
  float[] rippleAlpha = new float[MAX_RIPPLES];
  boolean[] rippleActive = new boolean[MAX_RIPPLES];
  int rippleIndex = 0;
  int rainTimer = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    
    // 波紋配列の初期化
    for (int i = 0; i < MAX_RIPPLES; i++) {
      rippleActive[i] = false;
    }
    
    rainTimer = 0;
  }

  void render() {
    drawBackground();
    noStroke();
    noFill();
    
    // 波紋の更新と描画
    for (int i = 0; i < MAX_RIPPLES; i++) {
      if (rippleActive[i]) {
        rippleRadius[i] += 1.5;
        rippleAlpha[i] -= 2;
        
        if (rippleAlpha[i] <= 0) {
          rippleActive[i] = false;
        } else {
          // 波紋の描画
          pushMatrix();
          translate(rippleX[i], rippleY[i]);
          setColorizeStroke();
          strokeWeight(2);
          ellipse(0, 0, rippleRadius[i], rippleRadius[i]);
          popMatrix();
        }
      }
    }
    
    // 新しい波紋の生成
    rainTimer++;
    if (rainTimer >= 5) {
      rainTimer = 0;
      
      // 次の波紋スロットを見つける
      while (rippleActive[rippleIndex]) {
        rippleIndex = (rippleIndex + 1) % MAX_RIPPLES;
      }
      
      // 新しい波紋を作成
      rippleX[rippleIndex] = random(width);
      rippleY[rippleIndex] = random(height);
      rippleRadius[rippleIndex] = 0;
      rippleAlpha[rippleIndex] = 255;
      rippleActive[rippleIndex] = true;
    }
  }
}

//// ---- Scene22 ----
class Scene22 implements Scene {
  final int GRID_SIZE = 20;
  final int COLS = 16*4; // width / GRID_SIZE
  final int ROWS = 9*4;  // height / GRID_SIZE
  boolean[][] grid = new boolean[COLS][ROWS];
  boolean[][] nextGrid = new boolean[COLS][ROWS];
  int[][] age = new int[COLS][ROWS]; // セルの年齢
  int[][] hue = new int[COLS][ROWS]; // セルの色相
  int[][] positionAge = new int[COLS][ROWS]; // 同じ位置での生存時間
  int generation = 0;
  int lastPatternChange = 0;
  int patternChangeInterval = 3000; // パターン変更間隔
  int minCells = 30; // 最小セル数（これ以下になったらランダムな点を追加）
  int maxPositionAge = 40; // 同じ位置での最大生存時間
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // グリッドの初期化
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        grid[i][j] = false;
        nextGrid[i][j] = false;
        age[i][j] = 0;
        hue[i][j] = 0;
        positionAge[i][j] = 0;
      }
    }
    
    // 初期パターンの生成
    generateRandomPattern();
    generation = 0;
    lastPatternChange = 0;
  }

  void render() {
    drawBackground();
    noStroke();
    
    // ライフゲームのルールを適用
    updateLife();
    
    // 生きているセル数をカウント
    int livingCells = countLivingCells();
    
    // 生きているセルが一定数以下の場合、ランダムな点を追加
    if (livingCells < minCells) {
      addRandomSeeds();
    }
    
    // グリッドの描画
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (grid[i][j]) {
          // セルの年齢に応じて色を変化
          int cellAge = age[i][j];
          
          pushMatrix();
          translate(i * GRID_SIZE, j * GRID_SIZE);
          
          setColorizeFill();
          
          // セルの形状（年齢に応じて変化）
          if (cellAge < 5) {
            rect(0, 0, GRID_SIZE, GRID_SIZE);
          } else if (cellAge < 10) {
            ellipse(GRID_SIZE/2, GRID_SIZE/2, GRID_SIZE, GRID_SIZE);
          } else {
            // 古いセルは複雑な形状
            beginShape();
            vertex(GRID_SIZE/2, 0);
            vertex(GRID_SIZE, GRID_SIZE/2);
            vertex(GRID_SIZE/2, GRID_SIZE);
            vertex(0, GRID_SIZE/2);
            endShape(CLOSE);
          }
          
          popMatrix();
        }
      }
    }
    
    // 定期的に新しいパターンを生成
    generation++;
    if (generation - lastPatternChange > patternChangeInterval) {
      generateRandomPattern();
      lastPatternChange = generation;
    }
  }
  
  void updateLife() {
    // 次の世代を計算
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        int neighbors = countNeighbors(i, j);
        
        if (grid[i][j]) {
          // 生きているセル
          positionAge[i][j]++; // 同じ位置での生存時間を増加
          
          // 同じ位置で一定時間以上生き続けている場合は死ぬ
          if (positionAge[i][j] > maxPositionAge) {
            nextGrid[i][j] = false;
            age[i][j] = 0;
            positionAge[i][j] = 0;
          } else if (neighbors == 2 || neighbors == 3) {
            nextGrid[i][j] = true;
            age[i][j]++;
          } else {
            nextGrid[i][j] = false;
            age[i][j] = 0;
            positionAge[i][j] = 0;
          }
        } else {
          // 死んでいるセル
          positionAge[i][j] = 0; // 死んでいるセルの位置年齢をリセット
          
          if (neighbors == 3) {
            nextGrid[i][j] = true;
            age[i][j] = 1;
            positionAge[i][j] = 1; // 新しいセルの位置年齢を1に設定
            hue[i][j] = int(random(360)); // 新しいセルにランダムな色相
          } else {
            nextGrid[i][j] = false;
            age[i][j] = 0;
          }
        }
      }
    }
    
    // グリッドを更新
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        grid[i][j] = nextGrid[i][j];
      }
    }
  }
  
  int countNeighbors(int x, int y) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        
        int nx = x + i;
        int ny = y + j;
        
        // 境界チェック（トーラス状）
        if (nx < 0) nx = COLS - 1;
        if (nx >= COLS) nx = 0;
        if (ny < 0) ny = ROWS - 1;
        if (ny >= ROWS) ny = 0;
        
        if (grid[nx][ny]) {
          count++;
        }
      }
    }
    return count;
  }
  
  int countLivingCells() {
    int count = 0;
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (grid[i][j]) {
          count++;
        }
      }
    }
    return count;
  }
  
  void generateRandomPattern() {
    // ランダムなパターンを生成
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (random(1) < 0.3) { // 30%の確率で生きているセル
          grid[i][j] = true;
          age[i][j] = 1;
          positionAge[i][j] = 1;
          hue[i][j] = int(random(360));
        } else {
          grid[i][j] = false;
          age[i][j] = 0;
          positionAge[i][j] = 0;
        }
      }
    }
  }
  
  void addRandomSeeds() {
    // ランダムな位置に少数のセルを追加
    int numSeeds = int(random(30, 80)); // 3-7個のセルを追加
    for (int n = 0; n < numSeeds; n++) {
      int x = int(random(COLS));
      int y = int(random(ROWS));
      
      // 既に生きているセルでない場合のみ追加
      if (!grid[x][y]) {
        grid[x][y] = true;
        age[x][y] = 1;
        positionAge[x][y] = 1;
        hue[x][y] = int(random(360));
      }
    }
  }
}

//// ---- Scene23 ----
class Scene23 implements Scene {
  final int NUM_PARTICLES = 120;
  Particle[] particles = new Particle[NUM_PARTICLES];
  float maxConnectionDistance = 80;
  float minConnectionDistance = 20;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // パーティクルの初期化
    for (int i = 0; i < NUM_PARTICLES; i++) {
      particles[i] = new Particle();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    // パーティクルの更新
    for (int i = 0; i < NUM_PARTICLES; i++) {
      particles[i].update();
    }
    
    // パーティクル同士の線を描画
    for (int i = 0; i < NUM_PARTICLES; i++) {
      for (int j = i + 1; j < NUM_PARTICLES; j++) {
        float distance = dist(particles[i].x, particles[i].y, particles[j].x, particles[j].y);
        
        if (distance < maxConnectionDistance && distance > minConnectionDistance) {
          pushMatrix();
          setColorizeStroke();
          strokeWeight(1);
          line(particles[i].x, particles[i].y, particles[j].x, particles[j].y);
          popMatrix();
        }
      }
    }
    
    // パーティクルの描画
    for (int i = 0; i < NUM_PARTICLES; i++) {
      particles[i].render();
    }
  }
  
  // パーティクルクラス
  class Particle {
    float x, y;
    float vx, vy;
    float size;
    float noiseOffsetX, noiseOffsetY;
    float noiseSpeed;
    
    Particle() {
      x = random(width);
      y = random(height);
      vx = random(-1, 1);
      vy = random(-1, 1);
      size = random(2, 6);
      noiseOffsetX = random(1000);
      noiseOffsetY = random(1000);
      noiseSpeed = random(0.01, 0.03);
    }
    
    void update() {
      // ノイズを使った不規則な動き
      float noiseX = noise(noiseOffsetX) * 2 - 1;
      float noiseY = noise(noiseOffsetY) * 2 - 1;
      
      vx += noiseX * 0.1;
      vy += noiseY * 0.1;
      
      // 速度の制限
      vx = constrain(vx, -2, 2);
      vy = constrain(vy, -2, 2);
      
      // 位置を更新
      x += vx;
      y += vy;
      
      // 画面端で反対側から出てくる（トーラス状）
      if (x < 0) {
        x = width;
      } else if (x > width) {
        x = 0;
      }
      if (y < 0) {
        y = height;
      } else if (y > height) {
        y = 0;
      }
      
      // ノイズオフセットを更新
      noiseOffsetX += noiseSpeed;
      noiseOffsetY += noiseSpeed;
      
    }
    
    void render() {
      pushMatrix();
      translate(x, y);
      setColorizeFill();
      // パーティクルの描画
      ellipse(0, 0, size, size);

      popMatrix();
    }
  }
}

//// ---- Scene24 ----
class Scene24 implements Scene {
  final int TILE_SIZE = 60;
  final int COLS = 22; // width / TILE_SIZE
  final int ROWS = 12; // height / TILE_SIZE
  float time = 0;
  int[][] tileTypes; // タイルの種類を保存する配列
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // タイルの種類をランダムに決定
    tileTypes = new int[COLS][ROWS];
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        tileTypes[i][j] = (int)random(4); // 0-3のランダムな値
      }
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        pushMatrix();
        
        float x = i * TILE_SIZE + TILE_SIZE / 2;
        float y = j * TILE_SIZE + TILE_SIZE / 2;
        translate(x, y);
        
        // 保存されたタイルの種類を使用
        int tileType = tileTypes[i][j];
        
        // 各タイルに固定のシード値を使用（安定したアニメーション）
        float seed1 = i * 0.1 + j * 0.15;
        float seed2 = i * 0.12 + j * 0.18;
        float seed3 = i * 0.08 + j * 0.22;
        float seed4 = i * 0.14 + j * 0.11;
        
        float wave1 = sin(time * 2.5 + seed1) * 0.3;
        float wave2 = cos(time * 2.2 + seed2) * 0.3;
        float wave3 = sin(time * 4.0 + seed3) * 0.2;
        float pulse = sin(time * 5.0 + seed4) * 0.2 + 0.8;
        
        // タイルの描画
        switch(tileType) {
          case 0:
            drawRotatingSquare(wave1, wave2, pulse);
            break;
          case 1:
            drawPulsingCircle(wave1, wave2, pulse);
            break;
          case 2:
            drawWavingLines(wave1, wave2, wave3, pulse);
            break;
          case 3:
            drawSpinningDiamond(wave1, wave2, pulse);
            break;
        }
        
        popMatrix();
      }
    }
  }
  
  void drawRotatingSquare(float anim1, float anim2, float pulse) {
    // パルス効果でサイズが大きく変化（グリッド内に収める）
    float baseSize = TILE_SIZE * 0.4;
    float size = baseSize + anim2 * 8 + pulse * 10;
    size = constrain(size, TILE_SIZE * 0.2, TILE_SIZE * 0.8); // グリッド内に制限
    
    fillBlack();
    rectMode(CENTER);
    rect(0, 0, size, size);
    
    // 内側の小さな四角
    setColorizeStroke();
    noFill();
    rect(0, 0, size * 0.2, size * 0.2);
    
    // 外側の枠
    setColorizeStroke();
    strokeWeight(1);
    rect(0, 0, size * 1.2, size * 1.2);
  }
  
  void drawPulsingCircle(float anim1, float anim2, float pulse) {
    // 複数の円が異なる速度で脈動（グリッド内に収める）
    setColorizeFill();
    float radius1 = TILE_SIZE * 0.15 + anim1 * 6 + pulse * 8;
    radius1 = constrain(radius1, TILE_SIZE * 0.1, TILE_SIZE * 0.35);
    ellipse(0, 0, radius1 * 2, radius1 * 2);
    
    // 中間の円
    setColorizeStroke();
    noFill();
    fillBlack();
    float radius2 = TILE_SIZE * 0.2 + anim2 * 4 + pulse * 6;
    radius2 = constrain(radius2, TILE_SIZE * 0.15, TILE_SIZE * 0.35);
    ellipse(0, 0, radius2 * 2, radius2 * 2);
    
    // 外側の円（回転なし）
    float radius3 = TILE_SIZE * 0.25 + anim2 * 3;
    radius3 = constrain(radius3, TILE_SIZE * 0.2, TILE_SIZE * 0.4);
    ellipse(0, 0, radius3 * 2, radius3 * 2);
  }
  
  void drawWavingLines(float anim1, float anim2, float anim3, float pulse) {
    setColorizeStroke();
    strokeWeight(1 + pulse);
    
    // より複雑な波打つ線
    for (int i = 0; i < 5; i++) {
      float y = (i - 2) * 6 + anim1 * 8;
      float wave = sin(time * 6 + i * 1.5 + anim2 * 2) * 4;
      float lineWidth = TILE_SIZE * 0.6 + pulse * 10;
      
      line(-lineWidth/2, y + wave, lineWidth/2, y + wave);
    }
    
    // 中央の点（脈動）
    setColorizeFill();
    float dotSize = 2 + anim2 * 2 + pulse * 2;
    dotSize = constrain(dotSize, 1, 4);
    ellipse(0, 0, dotSize, dotSize);
    
    // 十字（回転なし）
    setColorizeStroke();
    strokeWeight(1);
    line(-6, 0, 6, 0);
    line(0, -6, 0, 6);
  }
  
  void drawSpinningDiamond(float anim1, float anim2, float pulse) {
    // サイズが脈動（グリッド内に収める）
    float baseSize = TILE_SIZE * 0.2;
    float size = baseSize + anim2 * 5 + pulse * 8;
    size = constrain(size, TILE_SIZE * 0.15, TILE_SIZE * 0.35);
    
    setColorizeFill();
    beginShape();
    vertex(0, -size);
    vertex(size, 0);
    vertex(0, size);
    vertex(-size, 0);
    endShape(CLOSE);
    
    // 内側の小さなダイヤモンド
    setColorizeStroke();
    noFill();
    fillBlack();
    float innerSize = size * 0.5;
    beginShape();
    vertex(0, -innerSize);
    vertex(innerSize, 0);
    vertex(0, innerSize);
    vertex(-innerSize, 0);
    endShape(CLOSE);
    
    // 外側の点（回転なし、グリッド内に収める）
    setColorizeFill();
    for (int i = 0; i < 4; i++) {
      float angle = i * PI / 2;
      float x = cos(angle) * size * 1.2;
      float y = sin(angle) * size * 1.2;
      ellipse(x, y, 2 + pulse, 2 + pulse);
    }
  }
}

//// ---- Scene25 ----
class Scene25 implements Scene {
  final int NUM_CURVES = 8;
  float time = 0;
  float[] curveSeeds = new float[NUM_CURVES];
  float[] curveSpeeds = new float[NUM_CURVES];
  float[] curveAmplitudes = new float[NUM_CURVES];
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // 各カーブのパラメータを初期化（振幅をさらに2倍に）
    for (int i = 0; i < NUM_CURVES; i++) {
      curveSeeds[i] = random(1000);
      curveSpeeds[i] = random(0.5, 2.0);
      curveAmplitudes[i] = random(200, 600); // 100-300から200-600に変更
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    pushMatrix();
    translate(width/2, height/2);
    
    // 複数のベジェ曲線でカオスな塊を作成
    for (int i = 0; i < NUM_CURVES; i++) {
      drawChaoticBezier(i);
    }
    
    popMatrix();
  }
  
  void drawChaoticBezier(int curveIndex) {
    float seed = curveSeeds[curveIndex];
    float speed = curveSpeeds[curveIndex];
    float amplitude = curveAmplitudes[curveIndex];
    
    // ベジェ曲線の制御点を動的に計算
    float angle1 = time * speed + seed;
    float angle2 = time * speed * 1.3 + seed + 100;
    float angle3 = time * speed * 0.8 + seed + 200;
    float angle4 = time * speed * 1.1 + seed + 300;
    
    // 制御点の位置（さらに2倍のスケール）
    float x1 = cos(angle1) * amplitude * (0.5 + 0.5 * sin(time * 2 + seed));
    float y1 = sin(angle1) * amplitude * (0.5 + 0.5 * cos(time * 1.5 + seed));
    float x2 = cos(angle2) * amplitude * (0.3 + 0.7 * sin(time * 1.8 + seed + 50));
    float y2 = sin(angle2) * amplitude * (0.3 + 0.7 * cos(time * 2.2 + seed + 50));
    float x3 = cos(angle3) * amplitude * (0.4 + 0.6 * sin(time * 1.2 + seed + 100));
    float y3 = sin(angle3) * amplitude * (0.4 + 0.6 * cos(time * 1.7 + seed + 100));
    float x4 = cos(angle4) * amplitude * (0.6 + 0.4 * sin(time * 2.5 + seed + 150));
    float y4 = sin(angle4) * amplitude * (0.6 + 0.4 * cos(time * 1.9 + seed + 150));
    
    // ベジェ曲線の描画（線の太さは元のまま）
    setColorizeStroke();
    strokeWeight(2 + sin(time * 3 + seed) * 2); // 元の2-4に戻す
    noFill();
    
    beginShape();
    vertex(x1, y1);
    bezierVertex(x2, y2, x3, y3, x4, y4);
    endShape();
    
    // 制御点の描画（円のサイズは2倍のまま）
    setColorizeFill();
    ellipse(x1, y1, 8, 8);
    ellipse(x2, y2, 6, 6);
    ellipse(x3, y3, 6, 6);
    ellipse(x4, y4, 8, 8);
    
    // 追加の装飾線（線の太さは元のまま）
    if (curveIndex % 2 == 0) {
      setColorizeStroke();
      strokeWeight(1); // 元の1に戻す
      line(x1, y1, x2, y2);
      line(x3, y3, x4, y4);
    }
  }
}

//// ---- Scene26 ----
class Scene26 implements Scene {
  final int NUM_WAVES = 8;
  final int POINTS_PER_WAVE = 200;
  float time = 0;
  float centerX, centerY;
  Wave[] waves = new Wave[NUM_WAVES];
  boolean showIndividualWaves = false;
  boolean showCombined = true;
  boolean animate = true;
  int waveMode = 0; // 0: 正弦波, 1: ノイズ波, 2: 複合波
  float globalAmplitude = 100;
  float globalFrequency = 1.0;
  color[] waveColors = new color[NUM_WAVES];
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    centerX = width / 2;
    centerY = height / 2;
    
    // 波の初期化
    initializeWaves();
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    // 波の更新
    updateWaves();
    
    // 波の描画
    if (showCombined) {
      drawCombinedWaves();
    }
    
    if (showIndividualWaves) {
      drawIndividualWaves();
    }
    
  }
  
  void initializeWaves() {
    for (int i = 0; i < NUM_WAVES; i++) {
      float frequency = 0.5 + i * 0.3;
      float amplitude = 30 + i * 10;
      float phase = i * TWO_PI / NUM_WAVES;
      float speed = 0.5 + i * 0.2;
      
      waveColors[i] = color(
        (i * 45) % 360,
        200 + sin(i * 0.5) * 55,
        150 + cos(i * 0.3) * 105
      );
      
      waves[i] = new Wave(frequency, amplitude, phase, speed, waveColors[i]);
    }
  }
  
  void updateWaves() {
    for (int i = 0; i < NUM_WAVES; i++) {
      waves[i].update(time, globalAmplitude, globalFrequency);
    }
  }
  
  void drawCombinedWaves() {
    // 複数の波を重ね合わせた複雑なパターン
    beginShape();
    
    for (int i = 0; i < POINTS_PER_WAVE; i++) {
      float x = map(i, 0, POINTS_PER_WAVE - 1, 0, width);
      float y = centerY;
      
      // 全ての波を重ね合わせ
      for (int j = 0; j < NUM_WAVES; j++) {
        y += waves[j].getValueAt(x, i);
      }
      
      // カオス的な変調
      if (animate) {
        float chaos = sin(time * 2 + i * 0.1) * 20;
        y += chaos;
      }
    
      setColorizeFill();
      vertex(x, y);
    }
    
    endShape();
  }
  
  void drawIndividualWaves() {
    // 個別の波を描画
    for (int i = 0; i < NUM_WAVES; i++) {
      Wave wave = waves[i];
      
      setColorizeStroke();
      stroke(wave.color1);
      strokeWeight(2);
      noFill();
      
      beginShape();
      for (int j = 0; j < POINTS_PER_WAVE; j++) {
        float x = map(j, 0, POINTS_PER_WAVE - 1, 0, width);
        float y = centerY + wave.getValueAt(x, j);
        vertex(x, y);
      }
      endShape();
    }
  }
  

  void keyPressed() {
    if (key >= '1' && key <= '3') {
      waveMode = key - '1';
      initializeWaves();
    } else if (key == 'i' || key == 'I') {
      showIndividualWaves = !showIndividualWaves;
    } else if (key == 'c' || key == 'C') {
      showCombined = !showCombined;
    } else if (key == '+' || key == '=') {
      globalAmplitude = min(globalAmplitude + 10, 200);
    } else if (key == '-') {
      globalAmplitude = max(globalAmplitude - 10, 20);
    } else if (key == 'a' || key == 'A') {
      animate = !animate;
    }
  }
  
  // 波クラス
  class Wave {
    float frequency;
    float amplitude;
    float phase;
    float speed;
    color color1;
    float[] values = new float[POINTS_PER_WAVE];
    
    Wave(float freq, float amp, float ph, float spd, color c) {
      frequency = freq;
      amplitude = amp;
      phase = ph;
      speed = spd;
      color1 = c;
    }
    
    void update(float time, float globalAmp, float globalFreq) {
      for (int i = 0; i < POINTS_PER_WAVE; i++) {
        float x = map(i, 0, POINTS_PER_WAVE - 1, 0, width);
        values[i] = getValueAt(x, i, time, globalAmp, globalFreq);
      }
    }
    
    float getValueAt(float x, int index) {
      return getValueAt(x, index, time, globalAmplitude, globalFrequency);
    }
    
    float getValueAt(float x, int index, float time, float globalAmp, float globalFreq) {
      float value = 0;
      
      switch(waveMode) {
        case 0: // 正弦波
          value = sin(x * frequency * 0.01 + phase + time * speed) * amplitude;
          break;
          
        case 1: // ノイズ波
          value = (noise(x * 0.01 + phase, time * speed) - 0.5) * amplitude * 2;
          break;
          
        case 2: // 複合波
          float sine = sin(x * frequency * 0.01 + phase + time * speed) * amplitude;
          float noise = (noise(x * 0.01 + phase, time * speed) - 0.5) * amplitude * 0.5;
          float saw = ((x * frequency * 0.01 + phase + time * speed) % TWO_PI) / TWO_PI * amplitude - amplitude/2;
          value = sine + noise + saw * 0.3;
          break;
      }
      
      // グローバル変調
      value *= globalAmp / 100.0;
      value *= globalFreq;
      
      // カオス的な変調
      if (animate) {
        float chaos = sin(time * 3 + index * 0.2) * 10;
        value += chaos;
      }
      
      return value;
    }
  }
}

//// ---- Scene27 ----
class Scene27 implements Scene {
  final int NUM_TRIANGLES = 240;
  Triangle[] triangles = new Triangle[NUM_TRIANGLES];
  float time = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();

    // 三角形の初期化
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i] = new Triangle();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    // 三角形の更新と描画
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i].update();
      triangles[i].draw();
    }
  }
  
  // 三角形クラス
  class Triangle {
    // 各頂点を個別に管理
    float v1x, v1y;
    float v2x, v2y;
    float v3x, v3y;
    
    // 三角形全体の速度（全頂点共通）
    float speed;
    
    float alpha;
    boolean isInitial; // 初回生成かどうか
    
    // 点滅効果
    float flickerTimer;
    float flickerInterval;
    boolean isVisible;
    
    Triangle() {
      isInitial = true;
      reset();
    }
    
    void reset() {
      // 三角形の中心位置
      float centerX = random(width);
      float centerY;
      
      // 初回生成時はランダムな位置、リセット時は画面下部の範囲外
      if (isInitial) {
        centerY = random(height);
        isInitial = false;
      } else {
        centerY = height + random(50, 150);
      }
      
      float size = random(20, 80);
      
      // 3つの頂点をランダムな形で配置（中心からの距離は一定範囲内）
      float angle1 = random(TWO_PI);
      float angle2 = random(TWO_PI);
      float angle3 = random(TWO_PI);
      
      float radius1 = random(size * 0.3, size * 0.7);
      float radius2 = random(size * 0.3, size * 0.7);
      float radius3 = random(size * 0.3, size * 0.7);
      
      v1x = centerX + cos(angle1) * radius1;
      v1y = centerY + sin(angle1) * radius1;
      v2x = centerX + cos(angle2) * radius2;
      v2y = centerY + sin(angle2) * radius2;
      v3x = centerX + cos(angle3) * radius3;
      v3y = centerY + sin(angle3) * radius3;
      
      // 全頂点共通の速度
      speed = random(1, 4);
      
      alpha = 255;
      
      // 点滅効果の初期化
      flickerInterval = random(2, 40); // ランダムな点滅間隔
      flickerTimer = 0;
      isVisible = random(1) < 0.5;
    }
    
    void update() {
      // 各頂点が同じ速度で上に移動
      v1y -= speed;
      v2y -= speed;
      v3y -= speed;
      
      // 点滅効果の更新
      flickerTimer++;
      if (flickerTimer >= flickerInterval) {
        isVisible = !isVisible;
        flickerTimer = 0;
        if (!isVisible) {
          // 次の点滅間隔をランダムに設定
          flickerInterval = random(60, 380);
        }
        else {
          flickerInterval = random(20, 80);
        }
      }
      
      // 3つの頂点全てが画面外に出たらリセット
      if (v1y < -100 && v2y < -100 && v3y < -100) {
        reset();
      }
      
      // フェードアウト（画面上部で薄くなる）
      float avgY = (v1y + v2y + v3y) / 3;
      if (avgY < height * 0.3) {
        alpha = map(avgY, 0, height * 0.3, 0, 255);
      } else {
        alpha = 255;
      }
    }
    
    void draw() {
      // 点滅効果：見えない時は描画しない
      if (!isVisible) {
        return;
      }
      
      // 三角形の描画
      noFill();
      setColorizeStroke();
      strokeWeight(2);
      
      beginShape();
      vertex(v1x, v1y);
      vertex(v2x, v2y);
      vertex(v3x, v3y);
      endShape(CLOSE);
    }
  }
}

//// ---- Scene28 ----
class Scene28 implements Scene {
  final int NUM_TRIANGLES = 240;
  Triangle[] triangles = new Triangle[NUM_TRIANGLES];
  float time = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
 
    // 三角形の初期化
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i] = new Triangle();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    // 三角形の更新と描画
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i].update();
      triangles[i].draw();
    }
  }
  
  // 三角形クラス
  class Triangle {
    // 各頂点を個別に管理
    float v1x, v1y;
    float v2x, v2y;
    float v3x, v3y;
    
    // 三角形全体の速度（全頂点共通）
    float speed;
    
    float alpha;
    boolean isInitial; // 初回生成かどうか
    
    // 点滅効果
    float flickerTimer;
    float flickerInterval;
    boolean isVisible;
    
    Triangle() {
      isInitial = true;
      reset();
    }
    
    void reset() {
      // 三角形の中心位置
      float centerX = random(width);
      float centerY;
      
      // 初回生成時はランダムな位置、リセット時は画面下部の範囲外
      if (isInitial) {
        centerY = random(height);
        isInitial = false;
      } else {
        centerY = height + random(50, 150);
      }
      
      float size = random(20, 80);
      
      // 3つの頂点をランダムな形で配置（中心からの距離は一定範囲内）
      float angle1 = random(TWO_PI);
      float angle2 = random(TWO_PI);
      float angle3 = random(TWO_PI);
      
      float radius1 = random(size * 0.3, size * 0.7);
      float radius2 = random(size * 0.3, size * 0.7);
      float radius3 = random(size * 0.3, size * 0.7);
      
      v1x = centerX + cos(angle1) * radius1;
      v1y = centerY + sin(angle1) * radius1;
      v2x = centerX + cos(angle2) * radius2;
      v2y = centerY + sin(angle2) * radius2;
      v3x = centerX + cos(angle3) * radius3;
      v3y = centerY + sin(angle3) * radius3;
      
      // 全頂点共通の速度
      speed = random(1, 4);
      
      alpha = 255;
      
      // 点滅効果の初期化
      flickerInterval = random(2, 40); // ランダムな点滅間隔
      flickerTimer = 0;
      isVisible = random(1) < 0.8;
    }
    
    void update() {
      // 各頂点が同じ速度で上に移動
      v1y -= speed;
      v2y -= speed;
      v3y -= speed;
      
      // 点滅効果の更新
      flickerTimer++;
      if (flickerTimer >= flickerInterval) {
        isVisible = !isVisible;
        flickerTimer = 0;
        if (!isVisible) {
          // 次の点滅間隔をランダムに設定
          flickerInterval = random(4, 8);
        }
        else {
          flickerInterval = random(20, 200);
        }
      }
      
      // 3つの頂点全てが画面外に出たらリセット
      if (v1y < -100 && v2y < -100 && v3y < -100) {
        reset();
      }
      
      // フェードアウト（画面上部で薄くなる）
      float avgY = (v1y + v2y + v3y) / 3;
      if (avgY < height * 0.3) {
        alpha = map(avgY, 0, height * 0.3, 0, 255);
      } else {
        alpha = 255;
      }
    }
    
    void draw() {
      // 点滅効果：見えない時は描画しない
      if (!isVisible) {
        return;
      }
      
      // 三角形の描画
      noFill();
      setColorizeStroke();
      strokeWeight(2);
      
      beginShape();
      vertex(v1x, v1y);
      vertex(v2x, v2y);
      vertex(v3x, v3y);
      endShape(CLOSE);
    }
  }
}

//// ---- Scene29 ----
class Scene29 implements Scene {
  final int NUM_POINTS = 240;
  final int MAX_CONNECTIONS = 60;
  Point[] points = new Point[NUM_POINTS];
  Connection[] connections = new Connection[MAX_CONNECTIONS];
  int connectionIndex = 0;
  float time = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
 
    // 点の初期化
    for (int i = 0; i < NUM_POINTS; i++) {
      points[i] = new Point();
    }
    
    // 接続の初期化
    for (int i = 0; i < MAX_CONNECTIONS; i++) {
      connections[i] = new Connection();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.01;
    
    // 点の更新
    for (int i = 0; i < NUM_POINTS; i++) {
      points[i].update();
    }
    
    // 新しいランダムな接続を作成
    createRandomConnections();
    
    // 接続の更新と描画
    for (int i = 0; i < MAX_CONNECTIONS; i++) {
      connections[i].update();
      connections[i].draw(points);
    }
    
    // 点の描画
    for (int i = 0; i < NUM_POINTS; i++) {
      points[i].draw();
    }
  }
  
  void createRandomConnections() {
    // 毎フレーム、いくつかのランダムな点のペアを接続
    int numNewConnections = 2; // 20から5に削減
    
    for (int i = 0; i < numNewConnections; i++) {
      int index1 = int(random(NUM_POINTS));
      int index2 = int(random(NUM_POINTS));
      
      if (index1 != index2) {
        Point p1 = points[index1];
        Point p2 = points[index2];
        
        // 距離が近い場合のみ接続を作成
        float distance = dist(p1.x, p1.y, p2.x, p2.y);
        if (distance < 200) {
          connections[connectionIndex].create(index1, index2, 4);
          connectionIndex = (connectionIndex + 1) % MAX_CONNECTIONS;
        }
      }
    }
  }
  
  // 接続クラス
  class Connection {
    int point1Index, point2Index;
    int lifetime;
    boolean active;
    
    Connection() {
      active = false;
    }
    
    void create(int p1, int p2, int life) {
      point1Index = p1;
      point2Index = p2;
      lifetime = life;
      active = true;
    }
    
    void update() {
      if (active) {
        lifetime--;
        if (lifetime <= 0) {
          active = false;
        }
      }
    }
    
    void draw(Point[] points) {
      if (!active) return;
      
      Point p1 = points[point1Index];
      Point p2 = points[point2Index];
      
      float distance = dist(p1.x, p1.y, p2.x, p2.y);
      if (distance < 200) {
        setColorizeStroke();
        strokeWeight(1.5);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }
  
  // 点クラス
  class Point {
    float x, y;
    float speed;
    float size;
    float alpha;
    boolean isInitial;
    
    Point() {
      isInitial = true;
      reset();
    }
    
    void reset() {
      x = random(width);
      
      // 初回生成時はランダムな位置、リセット時は画面下部の範囲外
      if (isInitial) {
        y = random(height);
        isInitial = false;
      } else {
        y = height + random(5, 10);
      }
      
      speed = random(1, 2);
      size = random(2, 4);
      alpha = 255;
    }
    
    void update() {
      // 上に移動
      y -= speed;
      
      // 画面外に出たらリセット
      if (y < -100) {
        reset();
      }
      

    }
    
    void draw() {
      setColorizeFill();
    strokeWeight(0);
      ellipse(x, y, size, size);
    }
  }
}

//// ---- Scene30 ----
class Scene30 implements Scene {
  final int NUM_GLITCH_BLOCKS = 30;
  GlitchBlock[] blocks = new GlitchBlock[NUM_GLITCH_BLOCKS];
  float time = 0;
  int glitchTimer = 0;
  int glitchInterval = 5;
  boolean isGlitching = false;
  
  // RGB分離エフェクト
  float rgbShiftX = 0;
  float rgbShiftY = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();
    
    // グリッチブロックの初期化
    for (int i = 0; i < NUM_GLITCH_BLOCKS; i++) {
      blocks[i] = new GlitchBlock();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    // グリッチタイマー
    glitchTimer++;
    if (glitchTimer >= glitchInterval) {
      glitchTimer = 0;
      isGlitching = random(1) < 0.3; // 30%の確率でグリッチ
      
      // RGB分離の強度をランダムに
      if (isGlitching) {
        rgbShiftX = random(-10, 10);
        rgbShiftY = random(-5, 5);
      } else {
        rgbShiftX = 0;
        rgbShiftY = 0;
      }
    }
    
    // グリッチブロックの更新と描画
    for (int i = 0; i < NUM_GLITCH_BLOCKS; i++) {
      blocks[i].update();
      blocks[i].draw();
    }
    
    // デジタルノイズ
    if (isGlitching) {
      drawDigitalNoise();
    }
    
    // RGB分離エフェクト
    if (abs(rgbShiftX) > 0 || abs(rgbShiftY) > 0) {
      drawRGBShift();
    }
  }
  
  void drawDigitalNoise() {
    // ランダムなピクセルノイズ
    setColorizeFill();
    
    for (int i = 0; i < 100; i++) {
      float x = random(width);
      float y = random(height);
      float size = random(1, 5);
      
      fill(255, random(100, 255));
      rect(x, y, size, size);
    }
  }
  
  void drawRGBShift() {
    // RGB分離エフェクト（矩形で近似）
    setColorizeFill();
    
    for (int i = 0; i < 5; i++) {
      float x = random(width);
      float y = random(height);
      float w = random(50, 200);
      float h = random(2, 10);
      
      // R チャンネル
      fill(255, 0, 0, 100);
      rect(x + rgbShiftX, y, w, h);
      
      // G チャンネル
      fill(0, 255, 0, 100);
      rect(x, y, w, h);
      
      // B チャンネル
      fill(0, 0, 255, 100);
      rect(x - rgbShiftX, y + rgbShiftY, w, h);
    }
  }
  
  // グリッチブロッククラス
  class GlitchBlock {
    float x, y, w, h;
    float vx, vy;
    float lifetime;
    float maxLifetime;
    boolean active;
    int glitchType; // 0: 横ずれ, 1: 縦ずれ, 2: ブロックノイズ
    
    GlitchBlock() {
      reset();
    }
    
    void reset() {
      x = random(width);
      y = random(height);
      w = random(50, 300);
      h = random(5, 30);
      vx = random(-5, 5);
      vy = random(-2, 2);
      lifetime = 0;
      maxLifetime = random(10, 30);
      active = random(1) < 0.5;
      glitchType = int(random(3));
    }
    
    void update() {
      if (!active) {
        // ランダムに再アクティブ化
        if (random(1) < 0.02) {
          reset();
          active = true;
        }
        return;
      }
      
      lifetime++;
      
      // 動き
      x += vx;
      y += vy;
      
      // 画面端で跳ね返る
      if (x < 0 || x + w > width) {
        vx *= -1;
        x = constrain(x, 0, width - w);
      }
      if (y < 0 || y + h > height) {
        vy *= -1;
        y = constrain(y, 0, height - h);
      }
      
      // 寿命が尽きたら非アクティブ化
      if (lifetime > maxLifetime) {
        active = false;
      }
      
      // ランダムにグリッチタイプを変更
      if (random(1) < 0.05) {
        glitchType = int(random(3));
      }
    }
    
    void draw() {
      if (!active) return;
      
      pushMatrix();
      
      switch(glitchType) {
        case 0: // 横ずれ
          drawHorizontalGlitch();
          break;
        case 1: // 縦ずれ
          drawVerticalGlitch();
          break;
        case 2: // ブロックノイズ
          drawBlockNoise();
          break;
      }
      
      popMatrix();
    }
    
    void drawHorizontalGlitch() {
      setColorizeFill();
      
      // 複数の水平バーを描画
      for (int i = 0; i < 3; i++) {
        float offsetX = random(-20, 20);
        float barY = y + i * h / 3;
        rect(x + offsetX, barY, w, h / 3);
      }
      
      // 外枠
      setColorizeStroke();
      noFill();
      strokeWeight(1);
      rect(x, y, w, h);
    }
    
    void drawVerticalGlitch() {
      setColorizeFill();
      
      // 複数の垂直バーを描画
      int numBars = int(w / 20);
      for (int i = 0; i < numBars; i++) {
        float offsetY = random(-10, 10);
        float barX = x + i * 20;
        rect(barX, y + offsetY, 20, h);
      }
      
      // 外枠
      setColorizeStroke();
      noFill();
      strokeWeight(1);
      rect(x, y, w, h);
    }
    
    void drawBlockNoise() {
      setColorizeFill();
      
      // ランダムなブロックノイズ
      int numBlocks = int(w * h / 100);
      for (int i = 0; i < numBlocks; i++) {
        float blockX = x + random(w);
        float blockY = y + random(h);
        float blockSize = random(2, 8);
        
        if (random(1) < 0.5) {
          fill(255);
        } else {
          fill(0);
        }
        
        rect(blockX, blockY, blockSize, blockSize);
      }
      
      // 外枠
      setColorizeStroke();
      noFill();
      strokeWeight(1);
      rect(x, y, w, h);
    }
  }
}

//// ---- Scene31 ----
class Scene31 implements Scene {
  final int NUM_TRIANGLES = 40;
  Triangle[] triangles = new Triangle[NUM_TRIANGLES];
  float time = 0;
  
  void enter() {
    drawBackground();
    noStroke();
    setColorizeFill();

    // 三角形の初期化
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i] = new Triangle();
    }
  }

  void render() {
    drawBackground();
    noStroke();
    
    time += 0.02;
    
    // 三角形の更新と描画
    for (int i = 0; i < NUM_TRIANGLES; i++) {
      triangles[i].update();
      triangles[i].draw();
    }
  }
  
  // 三角形クラス
  class Triangle {
    float x, y;
    float size;
    float speed;
    float wobbleX, wobbleY;
    float wobbleSpeed;
    float rotation;
    float rotationSpeed;
    float alpha;
    
    Triangle() {
      reset();
    }
    
    void reset() {
      x = random(width);
      y = random(height);
      size = random(20, 80);
      speed = random(1, 4);
      wobbleX = random(TWO_PI);
      wobbleY = random(TWO_PI);
      wobbleSpeed = random(0.02, 0.08);
      rotation = random(TWO_PI);
      rotationSpeed = random(-0.03, 0.03);
      alpha = 255;
    }
    
    void update() {
      // 上に移動
      y -= speed;
      
      // 左右に揺れる
      wobbleX += wobbleSpeed;
      wobbleY += wobbleSpeed;
      
      // 回転
      rotation += rotationSpeed;
      
      // 画面外に出たらリセット
      if (y < -100) {
        reset();
        y = height+40;
      }
      
      // フェードアウト（画面上部で薄くなる）
      if (y < height * 0.3) {
        alpha = map(y, 0, height * 0.3, 0, 255);
      } else {
        alpha = 255;
      }
    }
    
    void draw() {
      pushMatrix();
      
      // 位置に移動
      float wobbleOffsetX = sin(wobbleX) * 20;
      float wobbleOffsetY = cos(wobbleY) * 10;
      translate(x + wobbleOffsetX, y + wobbleOffsetY);
      
      // 回転
      rotate(rotation);
      
      // 三角形の描画
      noFill();
      setColorizeStroke();
      strokeWeight(2);
      
      beginShape();
      // 各頂点に微妙な動きを追加
      float v1x = 0 + sin(time * 2 + rotation) * 3;
      float v1y = -size/2 + cos(time * 1.5 + rotation) * 3;
      float v2x = -size/2 + sin(time * 1.8 + rotation + 1) * 3;
      float v2y = size/2 + cos(time * 2.2 + rotation + 1) * 3;
      float v3x = size/2 + sin(time * 2.5 + rotation + 2) * 3;
      float v3y = size/2 + cos(time * 1.7 + rotation + 2) * 3;
      
      vertex(v1x, v1y);
      vertex(v2x, v2y);
      vertex(v3x, v3y);
      endShape(CLOSE);
      
      // // 内側の小さな三角形（逆向き）
      // setColorizeFill();
      // beginShape();
      // vertex(v1x * 0.4, v1y * 0.4);
      // vertex(v2x * 0.4, v2y * 0.4);
      // vertex(v3x * 0.4, v3y * 0.4);
      // endShape(CLOSE);
      
      popMatrix();
    }
  }
}
