#素数か調べるプログラム
#素数であればTrue 素数でなければFalseを返す関数
import math #平方根を求めるのに使う数学モジュールを読み込む

def is_prime(n):
    if n <= 1:
        return False
    # math.sqrt(n) 平方根を計算
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0: # 割り切れるか判定
            return False # 割り切れれば素数ではない
    return True # いずれの数でも割りきれなかったときは素数

for i in range(200):
    if is_prime(i): #定義した関数を呼び出す
        print(i, end=' ')
