#２進数から１０進数に変換
n = '10010'

result = 0
for i in range(len(n)):
    # int(n[i]) 一文字ずつ取り出す
    # (len(n)-i-1) 累乗部分を計算
    result += int(n[i]) * (2 ** (len(n) - i - 1))

print(result)
