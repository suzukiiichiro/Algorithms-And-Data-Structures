# 直前の二つの数を足した値を出力する処理を再帰的に繰り返し「フィボナッチ数列」
# という数の並びを出力する

def fibonacci(n):
  if n==0:
    return 1
  elif n==1:
    return 1
  else:
    return fibonacci(n-1)+fibonacci(n-2)

for i in range(8):
  print(fibonacci(i))

