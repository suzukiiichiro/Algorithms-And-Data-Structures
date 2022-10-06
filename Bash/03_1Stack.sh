#!/bin/bash

#####
# stack (push/pop)
#
# スタックはデータ構造の一つです。
# スタックの仕組みは、ものを縦に積み上げる事を考えるとイメージしやすいです。
# 積み上げられた山からものを取り出す場合、上から順番に取り出す事になります。
# スタックにデータを追加する場合、データは一番最後に追加されます。
# スタックにデータを追加する操作をpushと呼びます。
# スタックからデータを取り出す場合、最も新しく追加されたデータから取り出されます。
# スタックからデータを取り出す操作をpopと呼びます。
# このような、後から入れたものを先に出す「後入れ先出し」の仕組みを
# 「Last In First Out 」を略してLIFOと呼びます。
# 
#######################################
# Bash/シェルスクリプトでスタックを実装
#
#######################################
##
# <>display()
# 表示
function display(){
  for((n=0;n<peek;n++));do
    echo "$n" "${array[n]}";
  done
  echo "------";
}
##
# <>stackPeek()
# ピーク
function stackPeek(){
  echo "$1 : $peek:"${array[$peek]}"";
}
##
# <>stackPush()
# プッシュ
function stackPush(){
  array[$((peek))]=$(echo "$RANDOM");
  stackPeek "push";
  ((peek++));
}
##
# <>stackPop()
# ポップ
function stackPop(){
  if (($peek!=0));then
    ((peek--));
    stackPeek "pop";
  else
    echo "Stack is empty";
  fi
}
##
# <>stack()
# スタック（表示とポップとプッシュ）の実行
function stack(){
  display;  #表示
  stackPop; 
  stackPush;
  stackPush;
  display;  #表示
  stackPop;
  stackPop;
  stackPop;
  stackPop;
  display;  #表示
  stackPop;
  stackPop;
  stackPop;
  display;  #表示
  stackPop;
  stackPop;
  stackPop;
  display;  #表示
  stackPop;
  stackPop; # Empty
}
##
# <>insert()
# 配列に値を挿入
function insert(){
  array[$((peek++))]="$1";
}
##
# <>setArray()
# 配列にランダムな値を要素として挿入
function setArray(){
  peek=0;
  for((i=0;i<$1;i++));do
    insert $(echo "$RANDOM");
  done
}
##
# <>execStack()
# スタックの実行
function execStack(){
 setArray "$1";
 stack;
}
##
# 実行
execStack 10;
exit;
