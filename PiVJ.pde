import java.util.*;

// ------ Config ------
final String KEYSET = "123456789"; // 9キー
final int BANKS = 3;
final int SCENES_PER_BANK = 9;

// ------ Globals ------
SceneManager sm;
HotkeySwitcher hk;
Scene[] scenes; // グローバル変数として宣言

float t = 0;
float w, h;

// 機能フラグ
boolean Colorize = false;
boolean disableBackground = false;
boolean forceBlackColor = false;

color primaryColor = color(230, 110, 20);

void setup() {
  size(1280, 720, P3D);  // 必要に応じて解像度を下げる（例：1024x576）
  // fullScreen(P3D);
  frameRate(60);
  noCursor();
  w = width;
  h = height;
  
  // シーンの初期化
  initializeScenes();
  
  sm = new SceneManager(scenes);
  sm.start(0);
  hk = new HotkeySwitcher(sm, scenes, KEYSET);
  
  // 矢印キー割当
  hk.registerCoded(LEFT,  () -> sm.prev());
  hk.registerCoded(RIGHT, () -> sm.next());
  hk.registerCoded(UP,    () -> hk.prevBank());
  hk.registerCoded(DOWN,  () -> hk.nextBank());
}

void draw() {
  drawBackground();
  sm.render();
  
  // HUD表示を間引き
  // if (frameCount % 6 == 0) {
  //   drawHUD();
  // }
  t++;
}

void keyPressed() {
  if (key != CODED) {
    handleNumberKeys();
    handleFunctionKeys();
  } else {
    hk.tryInvokeByCode(keyCode);
  }
}

void keyReleased() {
  if (key != CODED) {
    handleKeyRelease();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e < 0) {
    hk.nextBank();
  } else if (e > 0) {
    hk.prevBank();
  }
}

// ------ 初期化関数 ------
void initializeScenes() {
  int total = KEYSET.length() * BANKS;
  scenes = new Scene[total]; // グローバル変数に代入
  
  // デフォルトでVisualSceneを設定
  for (int i = 0; i < total; i++) {
    scenes[i] = new VisualScene(i);
  }
  
  // 実際のシーンを割り当て
  assignScenes();
}

void assignScenes() {
  // バンク1 (0-8): 基本シーン
  scenes[0] = new Scene0();
  scenes[1] = new Scene1();
  scenes[2] = new Scene2();
  scenes[3] = new Scene3();
  scenes[4] = new Scene4();
  scenes[5] = new Scene5();
  scenes[6] = new Scene6();
  scenes[7] = new Scene7();
  scenes[8] = new Scene8();
  
  // バンク2 (9-17): 中級シーン
  scenes[9] = new Scene9();
  scenes[10] = new Scene10();
  scenes[11] = new Scene11();
  scenes[12] = new Scene12();
  scenes[13] = new Scene13();
  scenes[14] = new Scene14();
  scenes[15] = new Scene15();
  scenes[16] = new Scene16();
  scenes[17] = new Scene17();
  
  // バンク3 (18-26): 上級シーン
  scenes[18] = new Scene18();
  scenes[19] = new Scene19();
  scenes[20] = new Scene20();
  scenes[21] = new Scene21();
  scenes[22] = new Scene22();
  scenes[23] = new Scene23();
  // 残りはVisualSceneのまま
}

// ------ キー処理関数 ------
void handleNumberKeys() {
  if (key >= '1' && key <= '9') {
    int keyIndex = key - '1';
    int bank = hk.getBank();
    int sceneIndex = bank * SCENES_PER_BANK + keyIndex;
    
    if (sceneIndex < sm.count()) {
      sm.switchTo(sceneIndex);
    }
  }
}

void handleFunctionKeys() {
  switch(key) {
    case 'q':
      disableBackground = true;
      break;
    case 'w':
      Colorize = !Colorize;  // eからwに変更
      break;
    case 'e':
      forceBlackColor = true;  // wからeに変更
      break;
    case 'l':
      hk.nextBank();
      break;
    case 'k':
      hk.prevBank();
      break;
  }
}

void handleKeyRelease() {
  switch(key) {
    case 'q':
      disableBackground = false;
      break;
    case 'e':  // wからeに変更
      forceBlackColor = false;
      break;
  }
}

// ------ 描画関数 ------
void drawBackground() {
  if (!disableBackground) {
    background(0);
  }
}

void drawHUD() {
  colorMode(RGB, 255);
  pushStyle();
  fill(255);
  textAlign(LEFT, TOP);
  textSize(14);
  
  int bank = hk.getBank();
  int totalBk = hk.getBankCount();
  int currentScene = sm.getIndex();
  
  // 基本情報
  text("Bank " + (bank + 1) + "/" + totalBk + " | Scene " + currentScene, 12, 12);
  
  // キー操作説明
  text("1-9: Scene | Q: BG | W: Color | E: Black | L/K: Bank | Scroll: Bank", 12, 28);
  
  // 状態表示
  drawStatusInfo();
  
  popStyle();
}

void drawStatusInfo() {
  int y = 48;
  
  // Colorize状態
  y += 20;
  if (Colorize) {
    fill(255, 0, 0);
    text("Colorize: ON (W)", 12, y);
  } else {
    fill(255);
    text("Colorize: OFF (W)", 12, y);
  }
  
  // 背景状態
  y += 20;
  if (disableBackground) {
    fill(0, 255, 0);
    text("Background: OFF (Q)", 12, y);
  } else {
    fill(255);
    text("Background: ON (Q)", 12, y);
  }
  
  // 黒色描画状態
  y += 20;
  if (forceBlackColor) {
    fill(255, 255, 0);
    text("Black Color: ON (E)", 12, y);
  } else {
    fill(255);
    text("Black Color: OFF (E)", 12, y);
  }
}

// ------ 色設定関数 ------
void setColorizeFill() {
  if (forceBlackColor) {
    colorMode(RGB, 255);
    fill(0);
  } else if (Colorize) {
    colorMode(RGB, 255);
    fill(primaryColor);
  } else {
    colorMode(RGB, 255);
    fill(255);
  }
}

void setColorizeStroke() {
  if (forceBlackColor) {
    colorMode(RGB, 255);
    stroke(0);
  } else if (Colorize) {
    colorMode(RGB, 255);
    stroke(primaryColor);
  } else {
    colorMode(RGB, 255);
    stroke(255);
  }
}

void fillBlack() {
  colorMode(RGB, 255);
  fill(0);
}

void strokeBlack() {
  colorMode(RGB, 255);
  stroke(0);
}

// ------ Interfaces / Manager ------
interface Scene {
  void enter();
  void render();
}

class SceneManager {
  Scene[] scenes;
  int idx = -1;

  SceneManager(Scene[] scenes) { this.scenes = scenes; }

  void start(int startIndex) {
    idx = constrain(startIndex, 0, scenes.length-1);
    scenes[idx].enter();
  }

  void next() { switchTo((idx + 1) % scenes.length); }
  void prev() { switchTo((idx - 1 + scenes.length) % scenes.length); }
  void switchTo(int to) {
    // if (to == idx) return;
    idx = to;
    scenes[idx].enter();
  }
  void render() { scenes[idx].render(); }
  int getIndex() { return idx; }
  int count() { return scenes.length; }
}

// ------ Hotkey + Bank ------
class HotkeySwitcher {
  final SceneManager sm;
  final Scene[] scenes;
  final String keys;
  final int keyLen;
  final Map<Character, Integer> posMap = new HashMap<>();
  int bank = 0;
  int bankCount;

  HotkeySwitcher(SceneManager sm, Scene[] scenes, String keys) {
    this.sm = sm;
    this.scenes = scenes;
    this.keys = keys;
    this.keyLen = keys.length();
    // シーン数に応じて自動で総バンク数を算出（BANKSとズレてもOK）
    this.bankCount = (int)ceil((float)scenes.length / keyLen);

    for (int i = 0; i < keyLen; i++) {
      char c = keys.charAt(i);
      posMap.put(Character.toLowerCase(c), i);
      posMap.put(Character.toUpperCase(c), i);
    }
  }

  boolean tryJumpByChar(char c) {
    Integer pos = posMap.get(c);
    if (pos == null) return false;
    int target = bank * keyLen + pos;
    if (target < scenes.length) {
      sm.switchTo(target);
      return true;
    }
    return false;
  }

  void registerCoded(int code, Runnable action) {
    codedMap.put(code, action);
  }

  void tryInvokeByCode(int code) {
    Runnable r = codedMap.get(code);
    if (r != null) r.run();
  }

  void nextBank() { setBank((bank + 1) % bankCount); }
  void prevBank() { setBank((bank - 1 + bankCount) % bankCount); }
  void setBank(int b) { bank = constrain(b, 0, bankCount - 1); }

  int getBank() { return bank; }
  int getBankCount() { return bankCount; }
  String getKeys() { return keys; }
  int getKeyLen() { return keyLen; }

  // 内部
  private final Map<Integer, Runnable> codedMap = new HashMap<>();
}

// ------ Visual Scenes (大量生成用の軽量テンプレ) ------
class VisualScene implements Scene {
  final int id;     // 0..N-1
  final int mode;   // 表現バリエーション
  float t = 0;

  // 可変リソース（必要時のみ確保）
  Particle[] ps = null;

  VisualScene(int id) {
    this.id = id;
    this.mode = id % 5; // 5種類の描画モード
  }

  public void enter() {
    colorMode(RGB,255);
    t = 0;
    if (mode == 2) { // パーティクルだけ入場時に確保
      int n = 180;
      ps = new Particle[n];
      randomSeed(1000 + id); // シーンごとに固定化
      for (int i = 0; i < n; i++) {
        ps[i] = new Particle(random(width), random(height));
      }
    }
  }

  public void update() {
    t += 0.02;
    if (mode == 2 && ps != null) {
      for (Particle p : ps) p.update();
    }
  }

  public void render() {
    drawBackground(); // background(0)の代わり
    switch (mode) {
      case 0: renderRings(); break;
      case 1: renderBars();  break;
      case 2: renderParticles(); break;
      case 3: renderGridWave();  break;
      case 4: renderSpokes();    break;
    }
    // ラベル
    pushStyle();
    setColorizeFill(); textSize(14); textAlign(LEFT, BOTTOM);
    text("Scene #" + id + "  (mode " + mode + ")", 12, height - 12);
    popStyle();
  }

  public void exit() {
    // 重いものがあれば開放
    // ps = null;
  }

  // ---- 表現いくつか ----
  void renderRings() {
    pushMatrix(); translate(width/2, height/2);
    noFill(); strokeWeight(2);
    for (int i = 0; i < 8; i++) {
      float r = 40 + i*28 + 10*sin(t*1.8 + i*0.6 + id*0.1);
      if (Colorize) {
        colorMode(RGB, 255);
        stroke(primaryColor);
      } else {
        float gray = 100 + 155*sin(t*0.5 + i*0.3);
        stroke(gray);
      }
      circle(0, 0, r*2);
    }
    popMatrix();
  }

  void renderBars() {
    noStroke();
    for (int i = 0; i < height; i += 14) {
      float shift = 80*sin(t + i*0.03 + id*0.15);
      if (Colorize) {
        colorMode(RGB, 255);
        fill(primaryColor);
      } else {
        float gray = 50 + 205*sin(t*0.3 + i*0.02);
        fill(gray);
      }
      rect(shift, i, width - abs(shift)*2, 10);
    }
  }

  void renderParticles() {
    if (ps == null) return;
    if (Colorize) {
      colorMode(RGB, 255);
      stroke(primaryColor);
    } else {
      float gray = 100 + 155*sin(t*0.8);
      stroke(gray);
    }
    strokeWeight(2); noFill();
    beginShape(POINTS);
    for (Particle p : ps) vertex(p.x, p.y);
    endShape();
  }

  void renderGridWave() {
    noStroke();
    int step = 24;
    for (int y = step; y < height; y += step) {
      for (int x = step; x < width; x += step) {
        float w = 10 + 8*sin(0.1*x + 0.13*y + t*2 + id*0.07);
        if (Colorize) {
          colorMode(RGB, 255);
          fill(primaryColor);
        } else {
          float gray = 80 + 175*sin(0.1*x + 0.13*y + t*1.5);
          fill(gray);
        }
        rect(x - w/2, y - w/2, w, w);
      }
    }
  }

  void renderSpokes() {
    pushMatrix(); translate(width/2, height/2);
    if (Colorize) {
      colorMode(RGB, 255);
      stroke(primaryColor);
    } else {
      float gray = 120 + 135*sin(t*0.7);
      stroke(gray);
    }
    strokeWeight(3);
    int spokes = 24;
    float R = 240;
    for (int i = 0; i < spokes; i++) {
      float a = TWO_PI * i / spokes + t * 0.9 + id * 0.03;
      line(0, 0, R*cos(a), R*sin(a));
    }
    popMatrix();
  }

  // ---- helper ----
  class Particle {
    float x, y, vx, vy;
    Particle(float x, float y) {
      this.x = x; this.y = y;
      float ang = random(TWO_PI);
      float spd = random(0.5, 2.2);
      vx = cos(ang)*spd; vy = sin(ang)*spd;
    }
    void update() {
      x += vx; y += vy;
      if (x < 0) x += width; else if (x >= width) x -= width;
      if (y < 0) y += height; else if (y >= height) y -= height;
    }
  }
}

// ------ HUD ------
// void drawHUD() {
//   colorMode(RGB,255);
//   pushStyle();
//   fill(255); textAlign(LEFT, TOP);
//   textSize(14);
//   int bank    = hk.getBank();
//   int totalBk = hk.getBankCount();
//   int currentScene = sm.getIndex();

//   // 簡略化されたHUD表示
//   text("Bank " + (bank+1) + "/" + totalBk + " | Scene " + currentScene + " | Layer " + (currentLayer+1) + "/" + maxLayers, 12, 12);

//   // キー割当のプレビュー（現在バンク）
//   String keys = hk.getKeys();
//   int len = hk.getKeyLen();
//   int y = 28;
//   text("Keys: " + keys.substring(0, min(13, len)) + (len > 13 ? "..." : ""), 12, y);
  
//   // キー操作の説明
//   y += 20;
//   text("1-9: Scene | Q: BG | W: Black | E: Color | Scroll: Layer", 12, y);
  
//   // Colorize機能の状態表示
//   y += 20;
//   if (Colorize) {
//     fill(255, 0, 0); // 赤色で表示
//     text("Colorize: ON (E)", 12, y);
//   } else {
//     fill(255); // 白色で表示
//     text("Colorize: OFF (E)", 12, y);
//   }
  
//   // 背景無効の状態表示
//   y += 20;
//   if (disableBackground) {
//     fill(0, 255, 0); // 緑色で表示
//     text("Background: OFF (Q)", 12, y);
//   } else {
//     fill(255); // 白色で表示
//     text("Background: ON (Q)", 12, y);
//   }
  
//   // 黒色描画の状態表示
//   y += 20;
//   if (forceBlackColor) {
//     fill(255, 255, 0); // 黄色で表示
//     text("Black Color: ON (W)", 12, y);
//   } else {
//     fill(255); // 白色で表示
//     text("Black Color: OFF (W)", 12, y);
//   }
  
//   popStyle();
// }

// Colorize機能の色設定関数（統一版）
// void setColorizeFill() {
//   if (forceBlackColor) {
//     colorMode(RGB, 255);
//     fill(0);
//   } else if (Colorize) {
//     colorMode(RGB, 255);
//     fill(primaryColor);
//   } else {
//     colorMode(RGB, 255);
//     fill(255);
//   }
// }

// void setColorizeStroke() {
//   if (forceBlackColor) {
//     colorMode(RGB, 255);
//     stroke(0);
//   } else if (Colorize) {
//     colorMode(RGB, 255);
//     stroke(primaryColor);
//   } else {
//     colorMode(RGB, 255);
//     stroke(255);
//   }
// }

// 黒を保持するための関数
// void fillBlack() {
//   colorMode(RGB, 255);
//   fill(0); // 黒
// }

// void strokeBlack() {
//   colorMode(RGB, 255);
//   stroke(0); // 黒
// }

// 背景描画用の関数
// void drawBackground() {
//   if (!disableBackground) {
//     background(0);
//   }
// }

//// ---- Sample Scenes ----
//class SceneA implements Scene {
//float t;
//public void enter() { t = 0; }
//public void update() { t += 0.02; }
//public void render() {
//noStroke(); fill(255);
//float r = 120 + 60*sin(t);
//ellipse(width*0.5, height*0.5, r, r);
//drawLabel("Scene A : N→/→, P←/←, 1/2/3 jump");
//}
//public void exit() {}
//}

//class SceneB implements Scene {
//PVector[] ps;
//public void enter() {
//// 重い前処理があるならここで1回だけ
//ps = new PVector[200];
//for (int i = 0; i < ps.length; i++) ps[i] = new PVector(random(width), random(height));
//}
//public void update() {
//for (PVector p : ps) { p.x += random(-1,1); p.y += random(-1,1); }
//}
//public void render() {
//stroke(0, 200, 255); noFill();
//for (PVector p : ps) point(p.x, p.y);
//drawLabel("Scene B");
//}
//public void exit() {
//// 片付けが必要ならここで（例：PGraphicsのdisposeなど）
//}
//}

//class SceneC implements Scene {
//float a;
//public void enter() { a = 0; }
//public void update() { a += 0.05; }
//public void render() {
//pushMatrix();
//translate(width/2, height/2);
//rotate(a);
//rectMode(CENTER);
//noStroke(); fill(255, 120, 0);
//rect(0, 0, 200, 40);
//popMatrix();
//drawLabel("Scene C");
//}
