# 関数定義
# リストから目的の値４０を探す
# 返却値はリストの位置を返す
#
# O(n)
#
def linear_search(data, value):
    for i in range(len(data)):
        if data[i] == value:
            return i
    return -1

data = [50, 30, 90, 10, 20, 70, 60, 40, 80]
print(linear_search(data, 40))
