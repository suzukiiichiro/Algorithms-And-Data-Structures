# ３の倍数の時に「Fizz」を出力
for i in range(1, 51):
    if i % 3 == 0: #３で割り切れた
        print('Fizz', end=' ')
    else:
        print(i, end=' ')
