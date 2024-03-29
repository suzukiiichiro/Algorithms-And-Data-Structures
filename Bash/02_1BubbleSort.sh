#!/bin/bash

################
# バブルソート
################
# 
# バブルソートは数列を整列するアルゴリズムの一つです。
# 数列の右端に天秤を置き、天秤の左右の数字を比較します。
# 
# 5   9   3   1   2   8   4   7   6
#                             _____
#                               |
#
# この場合、７と６を比較します。
# 比較した結果、右の数字の方が小さければ入れ替えをします。
#
# 5   9   3   1   2   8   4   6←→ 7
#                             _____
#                               |
#
# 比較が完了すると天秤を一つ左に移動します。
#
# 5   9   3   1   2   8   4   6   7
#                         _____
#                           |
#
# 同様に数字を比較します。
#
# 5   9   3   1   2   8   4   6   7
#                         _____
#                           |
#
# 今回は、4<6 なので数字は入れ替えません。
# 天秤を左に移動します。
#
# 5   9   3   1   2   8   4   6   7
#                     _____
#                       |
#
# 同様の操作を天秤が左端に行くまで繰り返します。
# 天秤が左端に到達したら、ここまでの一連の操作で通数列の中で最も小さな数字が左の橋に移動した事になります。
#
# 1   5   9   3   2   4   8   6   7
#                     _____
#                       |
#
# 左端の１をソート済みとして、天秤を右端に戻します。
#
# 済
# 1   5   9   3   2   4   8   6   7
#                             _____
#                               |
#
# 同様の操作を全ての数字がソート済みになるまで繰り返します。
# 
# 済  済  済
# 1   2   3   5   9   4   6   7   8
#                             _____
#                               |
# ソート済みの数字はすでに配置が完了しているので天秤は移動せずに右端に戻ります。
# 
# 済  済  済  済  済
# 1   2   3   4   5   9   6   7   8
#                             _____
#                               |
# 
# 済  済  済  済  済  済  済  済  済
# 1   2   3   4   5   6   7   8   9
#                             _____
#                               |
# 
# バブルソート
# https://www.youtube.com/watch?v=8Kp-8OGwphY
#
#　平均計算時間が O(ｎ^2)
#　安定ソート
#　比較回数は「　n(n-1)/2　」
#　交換回数は「　n^2/2　」
#　派生系としてシェーカーソートやコムソート
#
# 外側outは要素右側端nElems-1から左へ移動
# 内側 inは左側0から右へinを移動。
# inとin+1を比べinが大きかったらinとin+1を入れ替える
# 外側一番右側列からソート済み。並べ替えは不要
# 9+8+7+6+5+4+3+2+1(10本あった場合）
# ↓
# (N-1)+(N-2)+(N-3)+(N-4)+(N-5)+(N-6)+(N-7)+(N-8)+(N-9)
# ↓
# N*(N-1)/2=45
# ↓
# N2乗/2 （-1は無視します）
# ↓
# N2乗/4 （半分は入れ替えは不要）
# ↓
# O(N2乗) （ビッグオー規格では定数は含めない）
# 比較 O(N2乗) 入れ替え O(N2乗) 
#
##
#
function display(){
  for((n=0;n<nElems;n++));do
    echo "$n" "${array[n]}";
  done
  echo "------";
}
##
#
function insert(){
  array[nElems++]="$1";
}
##
#
function setArray(){
  nElems=0;
  for((i=0;i<$1;i++));do
    insert $(echo "$RANDOM");
  done
}
##
#
function bubbleSort(){
  for((i=nElems;i>0;i--));do
    for((j=0;j<i-1;j++));do
      if (( array[j] > array[j+1] ));then
        tmp=${array[j]};
        array[j]=${array[j+1]};
        array[j+1]=$tmp;
      fi
    done
  done  
}
##
#
function execSort(){
  setArray $1;
  display;
  bubbleSort;
  display;
}
##
#
time execSort 10;
exit;
