#!/bin/bash

#
####################
# 再帰-三角数(Triangular numbers）
# この数列の任意のn番目の項の値を見つけたいのですが、どうしたら見つかるでしょうか。
# ４番目の項はいくつでしょう（それは１０でした）
# どんな計算をしたらその１０という値は求まるのでしょうか。
# 項の値は、図の各行の四角形の数を単純に足していけば求まるように見えますね。
# 三角数列の４番目の項では、最初の桁に小さな四角形が４つあり、次が３つ、その次が２つという具合ですから、
# 全部を足せば 4+3+2+1=10となります。
# 
# 異なるアプローチ
# N番目の項の値は、前数列の和ではなく、たった２つのものの和であると考えます。
# 
# １．最初の桁、その数はn
# ２．そのほかの桁全ての和
#
# 項nの場合の「残りの桁」の和は、項n-1の場合の全ての桁の和と同じです。
# ですから、項nの全ての桁の和を求めるメソッドがあれば、
# そのメソッドをn-1という引数で呼び出せば、項nの場合の「残りの桁」の和は求まるはずです。
# こうした無限の責任転嫁を防ぐために n==1 の場合、自力で答えは１であるという言えなくてはなりません。
# これを基底条件といいます。どんな再帰メソッドにも基底条件がある事が絶対的に必要です。
#
# 計算式で解を得る場合
# n番目の三角数＝(n^2+n)/2
#
####################
#
#  □
#  #1=1
#
#  □
#  □□
#  #2=3
#
#  □
#  □□
#  □□□
#  #3=6
#
#  □
#  □□
#  □□□
#  □□□□
#  #4=10
#
#  □
#  □□
#  □□□
#  □□□□
#  □□□□□
#  #5=15
#
#  □
#  □□
#  □□□
#  □□□□
#  □□□□□
#  □□□□□□
#  #6=21
#
#  □
#  □□
#  □□□
#  □□□□
#  □□□□□
#  □□□□□□
#  □□□□□□□
#  #7=28
#
# #64=　？
##
#
function triangle(){
  (($1==1))&&{
    echo "1";
  }||{
    echo $(( $1 + $(triangle $(($1-1))) ));
  }
}
##
#
triangle 64 ;
exit ;
#
