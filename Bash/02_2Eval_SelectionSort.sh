#!/bin/bash

################
# 選択ソート
################
#
# 選択ソートは数列を整列するアルゴリズムの一つです。
# 数列を線形探索し、最小値を探します。
# 探索した最小値を、ソート済みではない列の左端の数と交換し、ソート済みにします。
# なお、最小値がすでに左端であった場合には、何の操作も行いません。
# 同様の操作を全ての数字にソート済みになるまで繰り返します。
#
# 5   9   3   1   2   8   4   7   6
# min 
# 
#     ↓
# 5   9   3   1   2   8   4   7   6
# min 
# 
#         ↓
# 5   9   3   1   2   8   4   7   6
#        min 
#
#             ↓
# 5   9   3   1   2   8   4   7   6
#            min 
#
#                 ↓
# 5   9   3   1   2   8   4   7   6
#            min 
#
#                     ↓
# 5   9   3   1   2   8   4   7   6
#            min 
#
#                                 ↓
# 5   9   3   1   2   8   4   7   6
#            min 
#
# 一番目の５とminの１を入れ替える
# 1   9   3   5   2   8   4   7   6
#   
#
# minを一つ右へずらす
# 1   9   3   5   2   8   4   7   6
#    min 
#
# 一番左端は配置済みなので探索の必要はない。
# 右へ探索し最小値を探す      
#
#     ↓
# 1   9   3   5   2   8   4   7   6
#    min 
#
#         ↓
# 1   9   3   5   2   8   4   7   6
#        min 
#
#             ↓
# 1   9   3   5   2   8   4   7   6
#        min 
#
#                 ↓
# 1   9   3   5   2   8   4   7   6
# 済             min 
#
# 
# 探索が右端まで到達したらソート済みではない左端の数値のminを交換します。
#                                 ↓
# 1   9   3   5   2   8   4   7   6
# 済             min 
#
#         ↓
# 1   2   3   5   9   8   4   7   6
# 済  済 
#
# 同様の操作を、全ての数字がソート済みになるまで繰り返します。
# 
# 
# 選択ソート
#https://www.youtube.com/watch?v=f8hXR_Hvybo
#　平均計算時間が O(ｎ^2)
#　安定ソートではない
#　比較回数は「　n(n-1)/2　」
#　交換回数は「　n-1　」
#
# 外側outは右側端nElems-1から左へ移動
# 内側 inは左側0から右へinを移動。
# maxよりinが大きかったらinの値をmaxへ
# ターン終了後にoutとmaxを[必ず]入れ替え
# 一番右側列からソート済み
#
# bubbleSort 比較 O(N2乗) 入れ替え O(N2乗) 
# selectSort 比較 O(N2乗) 入れ替え O(N) 
# 入れ替え回数が少ない分bubbleSortよりも高速
# 入れ替えに要する時間が比較の時間より相当大きい時にはその差も大きい
#
#######################################
# 02_1BubbleSort.shを、少しだけオブジェクティブに
# aRray[0].getValue() で値を取得できるように改変した
# 配列にIDと値を入れるだけのbashスクリプト
#######################################
##
# グローバル変数
declare -i nElems=0;
#
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
# <>bubbleSort() 
# バブルソート
# URL:
function bubbleSort(){
  local tmp_id;
  local tmp_value;
  for((i=nElems;i>0;i--)){
    for((j=0;j<i-1;j++)){
      if(($(aRray[$j].getValue)>$(aRray[$((j+1))].getValue)));then
        # 交換
        tmp_id=$(aRray[$j].getID);
        tmp_value=$(aRray[$j].getValue);
        setID     "$j"    $(aRray[$((j+1))].getID);      #IDをセット
        setValue  "$j"    $(aRray[$((j+1))].getValue);   #Valueをセット
        setID     $((j+1))    $tmp_id;      #IDをセット
        setValue  $((j+1))    $tmp_value;   #Valueをセット
        # 交換
      fi 
    } 
  }  
}
## <>selectionSort()
# 選択ソート
# URL:
function selectionSort(){
  local tmp_id;
  local tmp_value;
  for((i=0;i<nElems;i++)){
    min=$i;
    for((j=i+1;j<nElems;j++)){
      if(($(aRray[$min].getValue)>$(aRray[$j].getValue)));then
        min=$j;
      fi
    }
    # 交換
    tmp_id=$(aRray[$min].getID);
    tmp_value=$(aRray[$min].getValue);
    setID     "$min"    $(aRray[$i].getID);      #IDをセット
    setValue  "$min"    $(aRray[$i].getValue);   #Valueをセット
    setID     $i    $tmp_id;      #IDをセット
    setValue  $i    $tmp_value;   #Valueをセット
    # 交換
  }
}
##
# <>execSort()
# メインルーチン
function execSort(){
  local N=$1;
  setArray $N;    #配列をセット
  echo "修正前"
  display;
  #bubbleSort;     #バブルソート
  selectionSort;  #選択ソート
  echo "修正後"
  display;
}
##
# 実行
time execSort 10;
exit;
