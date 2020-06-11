# 例外：ifやforの中で定義した変数はエラーとならない
x = 10

if True:
    a = 30
    print(x)
    print(a)

print(x)
print(a) # ifやforの中で定義した変数はエラーとならない
