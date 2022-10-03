#!/bin/bash

########
# Queue
# 
# キューはデータ構造の一つです。
# キューは待ち行列とも呼ばれ、その名の通り行列に並ぶ事を考えるとイメージしやすいです。
# 行列においては、先に並んだ人ほど優先されます。 
# キューにデータを追加する場合、データは一番最後に追加されます。
# キューにデータを追加する操作をenqueueと呼びます。
# キューからデータを取り出す場合、最も古くに追加されたデータから取り出されます。
# キューからデータを取り出す操作をdequeueと呼びます。
# このような、先に入れたものを先に出す先入れ先出しの仕組みを
# 「First In First Out」を略してFIFOと呼びます。
# 
#########
##
#######################################
# 03_2Queue.shを、少しだけオブジェクティブに
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
#
function queueDisplay(){
  for((i=front;i<rear;i++));do
      echo "$i" "$(aRray[$i].getValue)";
  done
  echo "------";
}
##
#
function dequeue(){
  ((front++));
}
##
#
function enqueue(){
  ID=$1;
  value=$2;
  insert "$ID" "$value"
  rear=$nElems;
}
##
#
function peek(){
  echo "peek :"$front : $(aRray[$front].getValue);
}
##
#
# メインルーチン
function execQueue(){
  rear=0;   #後ろ端（enqueueされるほう）
  front=0;  #前端（peek/dequeueされるほう)
  ID=100;
  enqueue $((ID++)) 10;
  enqueue $((ID++)) 20;
  enqueue $((ID++)) 30;
  enqueue $((ID++)) 40;
  echo "データを4つenqueue";
  peek;
  queueDisplay;
  #----
  dequeue;
  dequeue;
  echo "データを2つdequeue";
  peek;
  queueDisplay;
  #----
  enqueue $((ID++)) 50;
  echo "データを1つenqueue";
  peek;
  queueDisplay;
  #----
}
##
#
# 実行
execQueue;
exit;
