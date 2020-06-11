#バブルソートの改良
data = [6, 15, 4, 2, 8, 5, 11, 9, 7, 13]

change = True
for i in range(len(data)):
    if not change: #交換が発生していなければ終了
        break
    change = False  #交換が発生していないものとする
    for j in range(len(data) - i - 1):
        if data[j] > data[j + 1]:
            data[j], data[j + 1] = data[j + 1], data[j]
            change = True #交換が発生した

print(data)
