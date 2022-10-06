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
declare -i rear=0;
#
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
# <>queueDisplay()
# 表示
function queueDisplay(){
  for((i=front;i<rear;i++));do
      echo "$i" "$(aRray[$i].getValue)";
  done
  echo "------";
}
##
# <>dequeue()
# デキュー
function dequeue(){
  ((front++));
}
##
# <>enqueue()
# エンキュー
function enqueue(){
  ID=$1;
  value=$2;
  setID     "$rear"    "$ID";      #IDをセット
  setValue  "$rear"    "$value";   #Valueをセット
  ((rear++));
}
##
# <>peek()
# ピーク
function peek(){
  echo "peek :"$front : $(aRray[$front].getValue);
}
##
# <>execQueue()
# キューの実行
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
# メイン
execQueue;
exit;
