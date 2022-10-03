#!/bin/bash

########
# Circular Queue
# 映画館の待ち行列なら、先頭の一人が列を去ったら、列全体が前に進みます。
# キューでも、削除のたびに全ての項目を移動する事は出来ますが、しかしその時間が無駄です。
# むしろ項目はそのままにしておいて、キューの前端や後端が動いた方が簡単なのです。
# しかしその場合の問題は、キューの後端がすぐに配列の終端に達してしまいます。
# まだ満杯ではないのに新たなデータを挿入できないというこの問題を解決するために、
# キューのfrontとrear矢印は配列の先頭へラップアラウンド（最初に戻る）します。
# その結果として円環キューというものができあがります。リングバッファとも呼ばれます。
# 
#########
##
#######################################
# 03_3CircularQueue.shを、少しだけオブジェクティブに
# aRray[0].getValue() で値を取得できるように改変した
# 配列にIDと値を入れるだけのbashスクリプト
#######################################
##
# グローバル変数
declare -i nElems=0;
declare -i rear=0;
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
# <> init Array
# 配列を作成
function initArray(){
  local N=$1;           #すべての要素数
  local ID=100;         #100からの連番
  local value=null;          #配列に代入される要素の値
  for((i=0;i<N;i++)){
    insert $((ID++)) $value;
  }
}
##
function CircularQDisplay(){
  for((i=0;i<maxSize;i++));do
      echo "$i" $(aRray[$i].getValue);
  done
  echo "------";
}
##
#
function CircularQDequeue(){
  ((front++));
  ((front==maxSize))&&{ front=0; }
}
##
#
function CircularQEnqueue(){
  ID=$1;
  value=$2;
  if(( rear==(maxSize-1) ));then 
    rear=-1; 
  fi
  ((rear++));
  setID     "$rear"    "$ID";      #IDをセット
  setValue  "$rear"    "$value";   #Valueをセット
}
##
#
function CircularQPeek(){
  echo "peek :front :$front  rear : $rear  peek : $front $(aRray[$front].getValue) ";
}
##
#
function execCircularQ(){
  rear=-1; #後ろ端（enqueueされるほう）
  front=0; #前端（peek/dequeueされるほう)
  ID=100;

  maxSize=5 #キューの項目数
  initArray $maxSize;

  CircularQEnqueue $((ID++)) 10;
  CircularQEnqueue $((ID++)) 20;
  CircularQEnqueue $((ID++)) 30;
  CircularQEnqueue $((ID++)) 40;
  echo "データを4つenqueue";
  CircularQPeek;
  CircularQDisplay;
#exit;
  #----
  CircularQDequeue;
  CircularQDequeue;
  echo "データを2つdequeue";
  CircularQPeek;
  CircularQDisplay;
#exit;
  #----
  CircularQEnqueue $((ID++)) 50;
  echo "データを1つenqueue";
  CircularQPeek;
  CircularQDisplay;
#exit;
  #----
  # CircularQ
  CircularQEnqueue $((ID++)) 60;
  CircularQEnqueue $((ID++)) 70;
  echo "データを2つenqueue";
  CircularQPeek;
  CircularQDisplay;
#exit;
  #---
  CircularQDequeue;
  CircularQDequeue;
  CircularQDequeue;
  echo "データを3つdequeue";
  CircularQPeek;
  CircularQDisplay;
}
##
#
# 実行
execCircularQ;
exit;

