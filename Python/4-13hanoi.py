# src:移動元 dist:移動先 via:経由場所
def hanoi(n, src, dist, via):
    if n > 1:
        #n-1枚を移動元から経由場所に移す
        hanoi(n - 1, src, via, dist)
        print(src + ' -> ' + dist)
        #n-1枚を経由場所から移動先に移す
        hanoi(n - 1, via, dist, src)
    else:
        print(src + ' -> ' + dist)

n = int(input("塔の数を入力: "))
hanoi(n, 'a', 'b', 'c')
