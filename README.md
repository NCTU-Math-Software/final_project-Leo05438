# 射擊遊戲

### 1. 玩法

玩家可以用 w a s d 操控位置、滑鼠射出子彈

目標是射中敵人，並躲避敵人的子彈

按q可以退出

### 2. 圖示

藍色三角形：玩家

藍色圓形：玩家子彈

紫色菱形：敵人

紅色圓形：紅色子彈

### 3. variables

#### (1) player
[ x座標,y座標 ]

#### (2) bullets
[ x座標,y座標,x軸向量,y軸向量 ; ... ]

#### (3) enemies
[ x座標,y座標,x軸向量 ; ... ]

#### (4) enemyBullets
[ x座標,y座標,x軸向量,y軸向量 ; ... ]

---

### 4. function

#### (1) draw()
把玩家、敵人跟子彈畫下來

#### (2) bulletsMove()、enemiesMove()、enemyBulletsMove()
移動子彈跟敵人的位置

#### (3) keyboard_callback()
鍵盤輸入

q:離開

w a s d:移動玩家

#### (4) mouse_callback()
滑鼠輸入:射出子彈

---

### 3. 程式流程
1. 如果敵人數量少於5個，增加敵人直到有五個敵人
2. 如果敵人的子彈少於5個，增加子彈直到有五個子彈
3. draw()
4. bulletsMove()、enemiesMove()、enemyBulletsMove()
5. 如果 quit~=1且live>0 重新回到 1.
6. 輸出分數 
7. 結束程式
