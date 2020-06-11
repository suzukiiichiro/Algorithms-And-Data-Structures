# グローバル変数とローカル変数　エラーとなります
x = 10

def check():
    a = 30
    print(x) # グローバル変数 
    print(a) # ローカル変数
    return

check()
print(x) # グローバル変数
print(a) # ローカル変数なのでエラーとなります
