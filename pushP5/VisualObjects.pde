// ============================================
// モーションクラス集
// 各キータイプごとの個別クラス
// ============================================

// タイプ0: 直線移動 + 軌跡エフェクト
class VisualObject0 extends VisualObjectBase {
  float vx, vy;
  ArrayList<PVector> trail;
  int num;

  VisualObject0(float startX, float startY) {
    super(startX, startY);
    //c = color(255, 50, 50);
    c = color(255);
    size = 30;
    vx = random(-64, 64);
    vy = random(-64, 64);
    trail = new ArrayList<PVector>();
    num = floor(random(9999));
    lifetime = 60;
  }

  void update() {
    super.update();
    if (!active) return;

    x += vx;
    y += vy;

    // 軌跡を追加
    trail.add(new PVector(x, y));
    if (trail.size() > 24) {
      trail.remove(0);
    }

    // 画面端で反射
    if (x < 0 || x > width ) {
      vx *= -1;
    }
    if (y < 0 || y > height) {
      vy *= -1;
    }
    num = num + age;
  }

  void display() {
    if (!active) return;

    // 軌跡を描画
    if (trail != null && trail.size() > 1) {
      for (int i = 0; i < trail.size() - 1; i++) {
        stroke(255);
        strokeWeight(4);
        if (i < trail.size() - 1) {
          line(trail.get(i).x, trail.get(i).y,
            trail.get(i+1).x, trail.get(i+1).y);
        }
      }
    }

    // 円を描画
    pushMatrix();
    translate(x, y);
    stroke(255);
    noFill();
    ellipse(0, 0, size, size);
    popMatrix();
    
 
    fill(255);
    textSize(32);
    text(age, x,y);
   
    
  }
}

// タイプ1: 重力落下 + バウンス
class VisualObject1 extends VisualObjectBase {
  float vx, vy;
  float gravity;

  VisualObject1(float startX, float startY) {
    super(startX, startY);
    c = color(255);
    size = height/40;
    vx = random(-30, 30);
    x = random(width);
    vy = 0;
    y = 0;
    gravity = 0.7;
    lifetime = 200;
  }

  void update() {
    super.update();
    if (!active) return;

    vy += gravity;
    x += vx;
    y += vy;

    // 地面でバウンス
    if (y > height - size/2) {
      y = height - size/2;
      vy *= -0.8;
      vx *= 0.99;
    }
    if (x < size/2 || x > width - size/2) {
      vx *= -0.9;
      x = constrain(x, size/2, width - size/2);
    }
    if (y < size/2) {
      y = size/2;
      vy *= -0.8;
    }
  }

  void display() {
    if (!active) return;
    float alpha = getAlpha();

    pushMatrix();
    translate(x, y);
    fill(red(c), green(c), blue(c), alpha);
    noStroke();
    rotate(age * 0.1);
    rectMode(CENTER);
    rect(0, 0, size, size);

    // バウンス時のエフェクト
    float bounceEffect = abs(vy) * 5;
    if (bounceEffect > 10) {
      noFill();
      stroke(red(c), green(c), blue(c), alpha * 0.5);
      strokeWeight(2);
      ellipse(0, 0, size + bounceEffect, size + bounceEffect);
    }
    popMatrix();
  }
}

// タイプ2:
class VisualObject2 extends VisualObjectBase {
  float centerX, centerY;
  float angle;
  float radius;

  VisualObject2(float startX, float startY) {
    super(startX, startY);
    c = color(50, 255, 50);
    size = 35;
    centerX = startX;
    centerY = startY;
    angle = 0;
    radius = 5;
    y=height;
  }

  void update() {
    //super.update();
    //if (!active) return;

    angle += 0.1;
    radius += 0.5;
    x = centerX + cos(angle) * radius;
    y = y - height/50;
    if (y < 0) {
      active = false;
    }
  }

  void display() {
    fill(255);
    noStroke();
    rectMode(CENTER);
    rect(width/2, y, width, height/80);
  }
}

// タイプ3: 振動（サイン波）
class VisualObject3 extends VisualObjectBase {
  float centerX, centerY;
  float angle;
  float radius;

  VisualObject3(float startX, float startY) {
    super(startX, startY);
    c = color(50, 255, 50);
    size = 35;
    centerX = startX;
    centerY = startY;
    angle = 0;
    radius = 5;
    y=height;
    x = floor(random(12)) * width/12 + width/12/2;
  }

  void update() {
    //super.update();
    //if (!active) return;

    angle += 0.1;
    radius += 0.5;
    //x = centerX + cos(angle) * radius;
    y = y - height/30;
    if (y < 0) {
      active = false;
    }
  }

  void display() {
    fill(255);
    noStroke();
    rectMode(CENTER);
    rect(x, y, width/12, height/40);
  }
}

// タイプ4: 円形軌道
class VisualObject4 extends VisualObjectBase {
  float centerX, centerY;
  float angle;
  float startAngle;
  float speed;
  float radius;

  VisualObject4(float startX, float startY) {
    super(startX, startY);
    c = color(255, 50, 255);
    size = 16;
    centerX = width/2;
    centerY = height/2;
    angle = atan2(startY - centerY, startX - centerX);
    startAngle = angle;
    radius = floor(random(12))*40+40;
    speed = random(0.12)+0.04;
  }

  void update() {
    //super.update();
    //if (!active) return;

    if (angle > startAngle + TWO_PI) {
      active = false;
    }
    angle += speed;
    x = centerX + cos(angle) * radius;
    y = centerY + sin(angle) * radius;
  }

  void display() {
    if (!active) return;

    // 軌道線を描画
    noFill();
    stroke(255);
    strokeWeight(2);
    //ellipse(centerX, centerY, radius * 2, radius * 2);
    arc(centerX, centerY,radius * 2, radius * 2, startAngle, angle);

    // 六角形を描画
    pushMatrix();
    translate(x, y);
    fill(255);
    noStroke();
    rotate(angle * 3);
    drawHexagon(0, 0, size/2);
    popMatrix();
  }

  void drawHexagon(float x, float y, float radius) {
    beginShape();
    for (int i = 0; i < 6; i++) {
      float angle = TWO_PI * i / 6;
      vertex(x + cos(angle) * radius, y + sin(angle) * radius);
    }
    endShape(CLOSE);
  }
}

// タイプ5: ジグザグ移動（複数の矩形）
class VisualObject5 extends VisualObjectBase {
  float baseY;
  float vx;
  float frequency;
  int rectCount = 5; // 矩形の数
  float[] rectXs; // 各矩形のX座標
  float[] rectYs; // 各矩形のY座標
  float[] rectBaseYs; // 各矩形の基準Y座標
  float[] rectVxs; // 各矩形のX速度
  float spacing; // 矩形間の間隔

  VisualObject5(float startX, float startY) {
    super(startX, startY);
    c = color(255);
    size = height/40;
    baseY = random(height);
    vx = random(12, 40);
    frequency = 0.1;
    x = 0;
    y = baseY;

    // 複数の矩形を初期化
    rectXs = new float[rectCount];
    rectYs = new float[rectCount];
    rectBaseYs = new float[rectCount];
    rectVxs = new float[rectCount];
    spacing = width / (rectCount + 1);

    for (int i = 0; i < rectCount; i++) {
      rectXs[i] = -spacing * (rectCount - i); // 左側から順に配置
      rectBaseYs[i] = random(height);
      rectYs[i] = rectBaseYs[i];
      rectVxs[i] = vx + random(-5, 5); // 各矩形に少し違う速度
    }
  }

  void update() {
    super.update();
    if (!active) return;

    // 各矩形を更新
    for (int i = 0; i < rectCount; i++) {
      rectXs[i] += rectVxs[i];
      rectYs[i] = rectBaseYs[i] + sin((age + i * 10) * frequency) * 100;

      // 画面外に出たら先頭に戻す（循環）
      if (rectXs[i] > width + size/2) {
        rectXs[i] = -spacing * rectCount;
      }
    }

    // すべての矩形が画面外に出たら非アクティブに
    boolean allOut = true;
    for (int i = 0; i < rectCount; i++) {
      if (rectXs[i] < width + size/2) {
        allOut = false;
        break;
      }
    }
    if (allOut) {
      active = false;
    }
  }

  void display() {
    if (!active) return;

    fill(255);
    noStroke();

    // 複数の矩形を描画
    for (int i = 0; i < rectCount; i++) {
      pushMatrix();
      translate(rectXs[i], rectYs[i]);
      rotate((age + i * 10) * 0.05);
      beginShape();
      vertex(0, -size/2);
      vertex(size/2, 0);
      vertex(0, size/2);
      vertex(-size/2, 0);
      endShape(CLOSE);
      popMatrix();
    }
  }
}

// タイプ6: 減衰する動き（摩擦）
class VisualObject6 extends VisualObjectBase {
  float centerX, centerY;
  float angle;
  float radius;

  VisualObject6(float startX, float startY) {
    super(startX, startY);
    c = color(50, 255, 50);
    size = 0;
    centerX = startX;
    centerY = startY;
    angle = 0;
    radius = 1;
    y=height;
  }

  void update() {
    //super.update();
    //if (!active) return;

    angle += 0.1;
    radius = radius*1.2;
    x = centerX + cos(angle) * radius;
    y = y - height/50;
    if (y < 0) {
      active = false;
    }
  }

  void display() {
    rectMode(CENTER);
    noFill();
    stroke(255);
    strokeWeight(6);
    ellipse(width/2, height/2, radius,radius);

  }
}

// タイプ7: 4×4マスの矩形が別々の方向に移動
class VisualObject7 extends VisualObjectBase {
  int gridSize = 8; // 4×4グリッド
  float[] rectXs; // 各矩形のX座標
  float[] rectYs; // 各矩形のY座標
  float[] rectVxs; // 各矩形のX速度
  float[] rectVys; // 各矩形のY速度
  float rectSize; // 各矩形のサイズ
  float gridSpacingX; // グリッドのX間隔
  float gridSpacingY; // グリッドのY間隔
  float startGridX; // グリッドの開始X位置
  float startGridY; // グリッドの開始Y位置

  VisualObject7(float startX, float startY) {
    super(startX, startY);
    c = color(255);
    rectSize = width / 80; // 矩形サイズ
    gridSpacingX = height / 24;
    gridSpacingY = height / 24;
    startGridX = width / 2 - (gridSize - 1) * gridSpacingX / 2;
    startGridY = height / 2 - (gridSize - 1) * gridSpacingY / 2;
    
    // 4×4 = 16個の矩形を初期化
    rectXs = new float[gridSize * gridSize];
    rectYs = new float[gridSize * gridSize];
    rectVxs = new float[gridSize * gridSize];
    rectVys = new float[gridSize * gridSize];
    
    // 各矩形の初期位置と速度を設定
    int index = 0;
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        // 初期位置（グリッド状に配置）
        rectXs[index] = startGridX + col * gridSpacingX;
        rectYs[index] = startGridY + row * gridSpacingY;
        
        // 各矩形に異なる方向の速度を設定
        float angle = random(TWO_PI); // ランダムな方向
        float speed = random(2, 0.05); // ランダムな速度
        rectVxs[index] = cos(angle) * speed;
        rectVys[index] = sin(angle) * speed;
        
        index++;
      }
    }
    
    x = 0;
    y = 0;
  }

  void update() {
    super.update();
    if (!active) return;

    // 各矩形を更新
    for (int i = 0; i < gridSize * gridSize; i++) {
      rectXs[i] += rectVxs[i]*age/2;
      rectYs[i] += rectVys[i]*age/2;
      
    }
    rectSize -= 0.5; 
  }

  void display() {
    if (!active) return;
    
    fill(255);
    noStroke();
    rectMode(CENTER);
    
    // 4×4の各矩形を描画
    for (int i = 0; i < gridSize * gridSize; i++) {
      rect(rectXs[i], rectYs[i], rectSize, rectSize);
    }
  }
}

// タイプ8: ランダムウォーク
class VisualObject8 extends VisualObjectBase {
  float vx, vy;

  VisualObject8(float startX, float startY) {
    super(startX, startY);
    c = color(255, 100, 150);
    size = 40;
    vx = random(-1, 1);
    vy = random(-1, 1);
  }

  void update() {
    super.update();
    if (!active) return;

    vx += random(-0.2, 0.2);
    vy += random(-0.2, 0.2);
    vx = constrain(vx, -3, 3);
    vy = constrain(vy, -3, 3);
    x += vx;
    y += vy;

    
  }

  void display() {
    if (!active) return;
    float alpha = getAlpha();

    pushMatrix();
    translate(x, y);
    noFill();
    stroke(255);
    strokeWeight(8);
    beginShape();
    for (int i = 0; i < 24; i++) {
      float a = TWO_PI * i / 24;
      float noise = noise(i*123, age * 5) * height/4;
      float r = size/2 + noise+age*age;
      vertex(cos(a) * r, sin(a) * r);
    }
    endShape(CLOSE);
    popMatrix();
  }
}

// タイプ9: 円形に拡散するパーティクル
class VisualObject9 extends VisualObjectBase {
  float ly, ry;

  VisualObject9(float startX, float startY) {
    super(startX, startY);
    ly = random(height);
    ry = random(height);
  }

  void update() {
    super.update();
    if (!active) return;
    lifetime -= age*4;

  }

  void display() {
    if (!active) return;
    fill(255);
    //text(lifetime,100,100);
    noFill();
    stroke(255);
    strokeWeight(lifetime);
    line(-100,ly,width+100,ry);
  }
}

// タイプxx: 円形に拡散するパーティクル
//class VisualObjectXX extends VisualObjectBase {
//  float vx, vy;

//  VisualObject9(float startX, float startY) {
//    super(startX, startY);
//    c = color(255);
//    size = 34;
//    float angle = random(TWO_PI);
//    vx = cos(angle) * random(0.5, 2);
//    vy = random(-10, 10);
//    x = random(width);
//  }

//  void update() {
//    super.update();
//    if (!active) return;

//    x += vx;
//    y += vy;
//    vx =0;
//    vy *= 0.99;
//  }

//  void display() {
//    if (!active) return;

//    pushMatrix();
//    translate(x, y);
//    fill(255);
//    noStroke();
//    ellipse(0, 0, size, size);

//    // 拡散する小さなパーティクル
//    for (int i = 0; i < 8; i++) {
//      float a = TWO_PI * i / 8;
//      float dist = age * 5.5;
//      float px = cos(a) * dist;
//      float py = sin(a) * dist;
//      float particleSize = 24 - dist * 0.05;
//      if (particleSize > 2) {
//        fill(255);
//        ellipse(px, py, particleSize, particleSize);
//      }
//    }
//    popMatrix();
//  }
//}
