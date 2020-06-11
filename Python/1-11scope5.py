# グローバル変数の値を書き換えたい場合には、globalという指定をつけます
x = 10

def reset():
    global x   # グローバル変数として宣言
    x = 30     # グローバル変数に代入される
    print(x)

reset()
print(x)
