#!/bin/bash

#
####################
# 再帰-ユークリッドの互除法(最大公約数 Greatest common divisor)
####################
# 
# 二つの整数値の最大公約数も再帰的に求める事が出来ます。
# 整数値を長方形の二辺の長さと考えると以下の問題に置き換える事が出来ます。
#
# 長方形をあまりが出ないように正方形で埋め尽くす。
# そのようにして作られる正方形の最大の辺の長さを求めたい。
#
#                  22
#  +--------------------------------+
#  |                                |
#  |                                |
# 8|                                |
#  |                                |
#  |                                |
#  +--------------------------------+
#                 ↓
#        8           8         6
#  +--------------------------------+
#  |           |           |        |
#  |           |           |        |
# 8|           |           |        |
#  |           |           |        |
#  |           |           |        |
#  +--------------------------------+
#                 ↓
#        8           8         6
#  +--------------------------------+
#  |           |           |        |
#  |           |           |6       |
# 8|           |           |        |
#  |           |           |--------|
#  |           |           |        |
#  +--------------------------------+
#                 ↓
#        8           8         6
#  +--------------------------------+
#  |           |           |        |
#  |           |           |6       |
# 8|           |           |        |
#  |           |           |--------|
#  |           |           | 2| 2| 2|
#  +--------------------------------+
#                           2  2  2
#                 ↓
#  22と8の最大公約数は2
#
# 二つの整数値が与えられたとき、大きいほうの値を小さい方の値で割ってみて、割り切れれば小さい方の値が最大公約数です。
# 割り切れない場合は、小さい方の値と得られた余剰に対して、同じ手続きを割り切れるまで再帰的に繰り返します。
#
# <> gcd()
# $1:x $2:y
function gcd(){
  local xValue=$1;
  local yValue=$2;
  if(($2==0));then
    echo "$xValue";
  else
    echo $(gcd $yValue $(($xValue % $yValue)) ); 
  fi
}

#
gcd 22 8 ; # 22x8の四角形
exit ;
#
