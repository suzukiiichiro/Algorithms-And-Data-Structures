data = [4, 5, 2, 3, 6]

# 格納するようその方が制限されているため、メモリ管理を厳密に行いたい場合はarray
# モジュールを使います
import array
data = array.array('i', [4, 5, 2, 3, 6])

# 機械学習に使いたいときなど、数値だけをより高速に処理したい場合はNumPyというパッ
# ケージのndarrayを使います
import numpy
data = numpy.ndarray([4, 5, 2, 3, 6])
