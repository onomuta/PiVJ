// ビジュアルパフォーマンスツール
// キーボード入力でオブジェクトを生成・表示

// オブジェクトを格納する配列（最大10個）
VisualObjectBase[] objects;
int maxObjects = 10;
int objectCount = 0;

// フォント用の変数
PFont customFont;

// ============================================
// セットアップとメインループ
// ============================================
void setup() {
  size(1280, 720,P3D);
  background(0);
  
  objects = new VisualObjectBase[maxObjects];
  objectCount = 0;
  
  // フォントの読み込み（方法1: TTF/OTFファイルを直接読み込む）
  // dataフォルダにフォントファイル（例: "DotGothic16-Regular.ttf"）を配置してから使用
  // ファイル名を実際のフォントファイル名に変更してください
  try {
    // 例: customFont = createFont("data/YourFont.ttf", 48);
    // textFont(customFont);
    // フォントファイルを配置したら、上記のコメントを外してファイル名を変更してください
  } catch (Exception e) {
    println("フォントファイルが見つかりません。dataフォルダにフォントファイル（.ttf または .otf）を配置してください。");
  }
  
  customFont = createFont("data/DotGothic16-Regular.ttf", 128); // ファイル名を変更
   textFont(customFont);
  smooth();
}

void draw() {
  //translate(width/2,height/2);
  //scale((sin(frameCount/100.)+1)/8+1.2);
  //rotate(sin(frameCount/100.)/24);
  //translate(-width/2,-height/2);

  //fill(0, 10);
  fill(0);
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, height);
  background(0);
  //drawGrid();
  
  for (int i = 0; i < maxObjects; i++) {
    if (objects[i] != null && objects[i].active) {
      objects[i].update();
      objects[i].display();
    }
  }
  
  cleanupInactiveObjects();

}

void drawGrid() {
  
  for(int i = 0;i <= width; i+=width/24){
    stroke(64);
    strokeWeight(0.5);
    line(i,0,i,height);
  }
  for(int i = 0;i <= height; i+=width/24){
    stroke(64);
    strokeWeight(0.5);
    line(0,i,width,i);
    stroke(0);
    strokeWeight(width/24-10);
    line(0,i+25,width,i+25);
  }
  for(int i = 0;i <= width; i+=width/24){

    stroke(0);
    strokeWeight(width/24-10);
    line(i+25,0,i+25,height);
  }
}


void keyPressed() {
  if (key >= '0' && key <= '9') {
    int type = key - '0';
    addObject(type);
  }
}

void addObject(int type) {
  float startX = width/2 + random(-height/2, height/2);
  float startY = height/2 + random(-height/2, height/2);
  
  VisualObjectBase newObject = null;
  
  // タイプに応じて適切なクラスをインスタンス化
  switch(type) {
    case 0:
      newObject = new VisualObject0(startX, startY);
      break;
    case 1:
      newObject = new VisualObject1(startX, startY);
      break;
    case 2:
      newObject = new VisualObject2(startX, startY);
      break;
    case 3:
      newObject = new VisualObject3(startX, startY);
      break;
    case 4:
      newObject = new VisualObject4(startX, startY);
      break;
    case 5:
      newObject = new VisualObject5(startX, startY);
      break;
    case 6:
      newObject = new VisualObject6(startX, startY);
      break;
    case 7:
      newObject = new VisualObject7(startX, startY);
      break;
    case 8:
      newObject = new VisualObject8(startX, startY);
      break;
    case 9:
      newObject = new VisualObject9(startX, startY);
      break;
  }
  
  // 配列が満杯の場合、最初の要素（最も古い）を削除してシフト
  if (objectCount >= maxObjects) {
    // 最初の要素を削除
    objects[0] = null;
    // 配列を左にシフト
    for (int i = 0; i < maxObjects - 1; i++) {
      objects[i] = objects[i + 1];
    }
    // 最後の位置に新しいオブジェクトを追加
    objects[maxObjects - 1] = newObject;
  } else {
    // 空きスロットを見つけて追加
    for (int i = 0; i < maxObjects; i++) {
      if (objects[i] == null) {
        objects[i] = newObject;
        objectCount++;
        break;
      }
    }
  }
}

void cleanupInactiveObjects() {
  for (int i = 0; i < maxObjects; i++) {
    if (objects[i] != null && !objects[i].active) {
      objects[i] = null;
      objectCount--;
    }
  }
}
