#深さ優先探索の帰りがけ順の逆順で実装
tree = [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10], [11, 12],
        [13, 14], [], [], [], [], [], [], [], []]

data = [0]
while len(data) > 0:
    pos = data.pop()      #末尾から取り出し
    print(pos, end=' ')
    for i in tree[pos]: 
        data.append(i)    #末尾に追加
