#１０進数から２進数に変換
n = 18

result = ''

while n > 0:
    result = str(n % 2) + result #あまりを文字列の左側に追加
    n //= 2 #２で割った商を再度代入

print(result)
