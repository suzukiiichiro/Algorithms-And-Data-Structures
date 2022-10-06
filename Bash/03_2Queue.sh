#!/bin/bash

#########
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
##
# <>queueDisplay()
# 表示
function queueDisplay(){
  for((i=front;i<rear;i++));do
      echo "$i" "${queue[i]}";
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
  queue[rear++]=$1;
}
##
# <>peek()
# ピーク
function peek(){
  echo "peek :"$front : ${queue[front]};
}
##
# <>execQueue()
# キューの実行
function execQueue(){
  rear=0;   #後ろ端（enqueueされるほう）
  front=0;  #前端（peek/dequeueされるほう)
  enqueue 10;
  enqueue 20;
  enqueue 30;
  enqueue 40;
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
  enqueue 50;
  echo "データを1つenqueue";
  peek;
  queueDisplay;
  #----
}
##
# メイン
execQueue;
exit;
