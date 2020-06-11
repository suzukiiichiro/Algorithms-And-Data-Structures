#グローバル変数に値をセット
x = 10

def check():
    a = 30
    return

check()
print("x")
print(x)
print("a") # ローカル変数は見えませんのでエラーとなります
print(a)
