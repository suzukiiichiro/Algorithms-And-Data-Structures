# ビッグオー記法
#
#３の倍数をFizz ５の倍数をBuzz
# ３，５の倍数をFizzBuzzで出力
#
#print文を1回実行するのにかかる時間をa、if文で
#条件を判定するのにかかる時間をbとすると、全体の
#処理時間は(a+b)×50となります。
#
# ビッグオー記法
# O(n)

for i in range(1, 51):
    if (i % 3 == 0) and (i % 5 == 0):
        print('FizzBuzz', end=' ')
    elif i % 3 == 0:
        print('Fizz', end=' ')
    elif i % 5 == 0:
        print('Buzz', end=' ')
    else:
        print(i, end=' ')
