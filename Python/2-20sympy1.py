# sympyをインストール
# pip install sympy
from sympy import sieve

#素数を求める
print([i for i in sieve.primerange(1, 200)])
