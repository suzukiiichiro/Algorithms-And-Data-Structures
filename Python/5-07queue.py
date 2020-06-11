#キュー
import queue

q = queue.Queue()

q.put(3) #キューに３を追加
q.put(5) #キューに５を追加
q.put(2) #キューに２を追加

temp = q.get() #キューから取り出し
print(temp)

temp = q.get() #キューから取り出し
print(temp)

q.put(4) #キューに４を追加

temp = q.get() #キューから取り出し
print(temp)
