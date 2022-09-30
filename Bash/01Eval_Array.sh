#!/bin/bash

#################
# 00 配列
# 配列はデータ構造の一つで、複数の値を格納する事が出来ます。
# 各要素には添え字（データの何番目かを表す数字）でアクセスできます。
# データはメモリーの連続した領域に、順番通りに格納されます。
# 連続した領域に格納されているので、メモリアドレスが添え字を使って計算でき、各データにランダムアクセスが出来ます。
# また、配列の特徴として、任意の場所へのデータの追加・削除の操作がリストに比べてコストが高いです。
# 
# a[0]   a[1]   a[2]
# blue   yellow red
#
# green
#
# greenを２番目に追加する事を考えます。
# まず配列の最後に追加する空間を確保します。
# 
# a[0]   a[1]   a[2]  a[3]
# blue   yellow red   
#
# 追加される空間を空けるため、一つずつデータをずらします。
# 
# a[0]   a[1]   a[2]  a[3]
# blue   yellow       red   
#
#        ↓
# a[0]   a[1]   a[2]   a[3]
# blue          yellow red   
#
#        ↓
# 空いた空間にgreenを追加して追加の操作が完了します。
#
# a[0]   a[1]   a[2]   a[3]
# blue   green  yellow red   
#
# 逆に２番目の要素を削除するときは、
# まず２番目の要素を削除し、
#
# a[0]   a[1]   a[2]   a[3]
# blue          yellow red   
#
#        ↓
# 空いた空間にデータを一つずらして埋めます。
# a[0]   a[1]   a[2]   a[3]
# blue   yellow        red   
#
#        ↓
# a[0]   a[1]   a[2]   a[3]
# blue   yellow red   
#
#        ↓
# 最後に余った空間を削除して削除の操作が完了します。
# a[0]   a[1]   a[2]
# blue   yellow red   
#
# こうした追加・削除の操作は以降のソートの処理で学びますので、ここではデータ配列を生成する処理を覚えます。
# 
#
#######################################
# 01Array.shを、少しだけオブジェクティブに
# aRray[0].getValue() で値を取得できるように改変した
# 配列にIDと値を入れるだけのbashスクリプト
#######################################
#
# グローバル変数
declare -i nElems=0;
##
# <>display()  
# 配列を表示
function display(){
  for((i=0;i<nElems;i++)){
    echo -n "aRray[$i]  \
    ID: " $( aRray[$i].getID ) " \
    Value:" $( aRray[$i].getValue ) ; 
    echo "";
  }
}
##
# <>setValue() 
# セッター
function setValue() {
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Elem="$1";      
  local value="$2";
	eval "aRray[$Elem].getValue()      { echo "$value"; }"
}
##
# <>setID()
# セッター
function setID(){
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Elem="$1";      
  local ID="$2";
	eval "aRray[$Elem].getID()         { echo "$ID"; }"
}
##
# <> insert
# 配列の要素に値を代入
function insert(){
  local ID=$1;          #100からの連番
  local value=$2;       #配列に代入される要素の値
  setID     "$nElems"    "$ID";      #IDをセット
  setValue  "$nElems"    "$value";   #Valueをセット
  ((nElems++));
}
##
# <> set Array
# 配列を作成
function setArray(){
  local N=$1;           #すべての要素数
  local ID=100;         #100からの連番
  local value;          #配列に代入される要素の値
  for((i=0;i<N;i++)){
    value=$( echo $RANDOM );
    insert $((ID++)) $value;
  }
}
##
# <>execArray()
# メインルーチン
function execArray(){
  local N=$1;           #要素数
  setArray $N           #配列にセット
  display;              #表示
}
##
# 実行
#
time execArray 10;
exit;
