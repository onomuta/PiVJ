// 基底クラス - 共通の変数とメソッド
class VisualObjectBase {
  float x, y;
  int lifetime;
  int age;
  boolean active;
  color c;
  float size;
  
  VisualObjectBase(float startX, float startY) {
    x = startX;
    y = startY;
    active = true;
    age = 0;
    lifetime = 120;
  }
  
  void update() {
    age++;
    if (age >= lifetime) {
      active = false;
    }
  }
  
  void display() {
    // サブクラスで実装
  }
  
  float getAlpha() {
    //return map(age, 0, lifetime, 255, 0);
    return 255;
  }
}
