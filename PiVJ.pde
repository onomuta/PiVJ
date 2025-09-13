import java.util.*;

// ------ Config ------
final String KEYSET = "qwertyuiopasdfghjklzxcvbnm"; // 26キー
final int BANKS     = 3;      

// ------ Globals ------
SceneManager sm;
HotkeySwitcher hk;

float t = 0;
float w,h;

void setup() {
  size(1280,720,P3D);
  // fullScreen(P3D);
  frameRate(60);
  noCursor();
  w = width;
  h = height;
  // バンク数×キー数ぶんシーンを用意（= 全部事前生成、切替は参照差替えのみ）
  int total = KEYSET.length() * BANKS;
  Scene[] scenes = new Scene[total];
  for (int i = 0; i < total; i++) scenes[i] = new VisualScene(i);

  scenes[1] = new Scene1();
  scenes[2] = new Scene2();
  scenes[3] = new Scene3();
  scenes[4] = new Scene4();
  scenes[5] = new Scene5();
  scenes[6] = new Scene6();
  scenes[7] = new Scene7();
  scenes[8] = new Scene8();
  scenes[9] = new Scene9();
  scenes[10] = new Scene10();
  scenes[11] = new Scene11();
  scenes[12] = new Scene12();
  // scenes[13] = new Scene13();
  // scenes[14] = new Scene14();
  // scenes[15] = new Scene15();
  // scenes[16] = new Scene16();
  // scenes[17] = new Scene17();
  // scenes[18] = new Scene18();
  // scenes[19] = new Scene19();
  // scenes[20] = new Scene20();
  // scenes[21] = new Scene21();
  // scenes[22] = new Scene22();
  // scenes[23] = new Scene23();
  // scenes[24] = new Scene24();



  sm = new SceneManager(scenes);
  sm.start(0);

  hk = new HotkeySwitcher(sm, scenes, KEYSET);

  // 矢印キー割当：シーン移動＆バンク切替
  hk.registerCoded(LEFT,  () -> sm.prev());
  hk.registerCoded(RIGHT, () -> sm.next());
  hk.registerCoded(UP,    () -> hk.prevBank());
  hk.registerCoded(DOWN,  () -> hk.nextBank());
}

void draw() {
  background(0);
  sm.render();
  // drawHUD();
  t++;
}

// ラッチなし：押されたイベントで即反応
void keyPressed() {
  if (key != CODED) {
    // 文字キー → 現在バンクの割当シーンに即ジャンプ
    if (!hk.tryJumpByChar(key)) {
      // ついでに '[' ']' でもバンク切替（任意）
      if (key == '[') hk.prevBank();
      if (key == ']') hk.nextBank();
    }
  } else {
    hk.tryInvokeByCode(keyCode);
  }
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
    if (to == idx) return;
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
    switch (mode) {
      case 0: renderRings(); break;
      case 1: renderBars();  break;
      case 2: renderParticles(); break;
      case 3: renderGridWave();  break;
      case 4: renderSpokes();    break;
    }
    // ラベル
    pushStyle();
    fill(255); textSize(14); textAlign(LEFT, BOTTOM);
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
      stroke(180 + (i*9 + id*7)%75, 150 + (i*5)%100, 255);
      circle(0, 0, r*2);
    }
    popMatrix();
  }

  void renderBars() {
    noStroke();
    for (int i = 0; i < height; i += 14) {
      float shift = 80*sin(t + i*0.03 + id*0.15);
      fill(60 + (i + id*13)%195, 200, 240);
      rect(shift, i, width - abs(shift)*2, 10);
    }
  }

  void renderParticles() {
    background(0); // 残像を消したいならコメントアウト
    if (ps == null) return;
    stroke(0, 220, 255); strokeWeight(2); noFill();
    beginShape(POINTS);
    for (Particle p : ps) vertex(p.x, p.y);
    endShape();
    println(ps.length);

  }

  void renderGridWave() {
    noStroke();
    int step = 24;
    for (int y = step; y < height; y += step) {
      for (int x = step; x < width; x += step) {
        float w = 10 + 8*sin(0.1*x + 0.13*y + t*2 + id*0.07);
        fill(255, 120, 0);
        rect(x - w/2, y - w/2, w, w);
      }
    }
  }

  void renderSpokes() {
    pushMatrix(); translate(width/2, height/2);
    stroke(255); strokeWeight(3);
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
      println(ps.length);

    }
  }
}

// ------ HUD ------
void drawHUD() {
  colorMode(RGB,255);
  pushStyle();
  fill(255); textAlign(LEFT, TOP);
  textSize(14);
  int bank    = hk.getBank();
  int totalBk = hk.getBankCount();

  text("Bank " + (bank+1) + " / " + totalBk + "   (UP/DOWN = bank, LEFT/RIGHT = prev/next)",
       12, 12);

  // キー割当のプレビュー（現在バンク）
  String keys = hk.getKeys();
  int len = hk.getKeyLen();
  int y = 32;
  text("Keys → Scenes (current bank):", 12, y);
  y += 16;

  StringBuilder line = new StringBuilder();
  for (int i = 0; i < len; i++) {
    int idx = bank * len + i;
    String chunk = "" + keys.charAt(i) + (idx < sm.count() ? "→" + idx : "→-");
    line.append(chunk).append("   ");
    // 改行が欲しければここで適宜折り返し
  }
  text(line.toString(), 12, y);
  popStyle();
}










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
