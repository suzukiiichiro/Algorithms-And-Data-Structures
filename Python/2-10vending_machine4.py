#不適切な入力（カンマが含まれる金額)に対応する
import sys # エラー時に強制終了するためのモジュールを組み込む

input_price = input('insert: ')
if not input_price.isdecimal():
    print('整数を入力してください')
    sys.exit() # エラーがあれば強制終了

product_price = input('product: ')
if not product_price.isdecimal():
    print('整数を入力してください')
    sys.exit() # エラーがあれば強制終了

change = int(input_price) - int(product_price)

if change < 0:
    print('金額が不足しています')
    sys.exit() # エラーがあれば強制終了

coin = [5000, 1000, 500, 100, 50, 10, 5, 1]

for i in coin:
    r = change // i
    change %= i
    print(str(i) + ': ' + str(r))
