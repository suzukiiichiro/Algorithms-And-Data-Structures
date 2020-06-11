#メモ化によって処理を高速化する

#辞書に終了条件の値を入れる
memo = {1: 1, 2: 1}
def fibonacci(n):
    if n in memo:
        #辞書に登録されていればその値を返す
        return memo[n]
    #辞書に登録がなければ計算して辞書に登録
    memo[n] = fibonacci(n - 2) + fibonacci(n - 1)
    return memo[n]

print(fibonacci(6))
