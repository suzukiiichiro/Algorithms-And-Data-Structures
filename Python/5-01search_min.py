#小さいものを選ぶ
data = [6, 15, 4, 2, 8, 5, 11, 9, 7, 13]

min = 0 #最小値の位置の初期値として先頭を設定
for i in range(1, len(data)):
    if data[min] > data[i]:
        #最小値が更新されたらその位置をセット
        min = i

print(min)
