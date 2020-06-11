#基数２，３，８に変換
n = 18

def convert(n, base):
    result = ''

    while n > 0:
        result = str(n % base) + result
        n //= base

    return result

print(convert(n, 2)) #２進数に変換
print(convert(n, 3)) #３進数に変換
print(convert(n, 8)) #８進数に変換
print(convert(n, 10))#１０進数に変換
