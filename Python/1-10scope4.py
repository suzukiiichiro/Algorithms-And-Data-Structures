# グローバル変数とローカル変数
x = 10

def reset():
    x = 30 # グローバル変数と同じ名前だが、ローカル変数として扱われる
    print(x)

print("ローカル変数:x")
reset()
print("グローバル変数:x")
print(x)
