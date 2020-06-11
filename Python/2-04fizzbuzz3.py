#３の倍数の時に「Fizz」を出力
#５の倍数の時に「Buzz」を出力
for i in range(1, 51):
    if i % 3 == 0:
        print('Fizz', end=' ')
    elif i % 5 == 0:
        print('Buzz', end=' ')
    else:
        print(i, end=' ')
