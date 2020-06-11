# ビッグオー記法
#
#直方体の体積を求める
#
#このプログラムは３重になっていますので、それぞれについてn回実行します。
# 実行回数は dxnxnxn=dn3
#
# ビッグオー記法では
# O(n^3)
#
n = 10

#縦の長さを１からnまで
for i in range(1, n):
    #横の長さを１からnまで
    for j in range(1, n):
        #高さを１からnまで
        for k in range(1, n):
            #体積を出力
            print(str(i) + '*' + str(j) + '*' + str(k) + \
                '=' + str(i * j * k))
