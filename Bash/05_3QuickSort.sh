#!/bin/bash

# ########################################################
# <>quickSort
# クイックソート
# https://www.youtube.com/watch?v=aQiWF4E8flQ
#　平均計算時間が O(n Log n)
#　安定ソートではない
#　最大計算時間が O(n^2)
#
# データ数が 50 以下なら挿入ソート (Insertion Sort)
# データ数が 5 万以下ならマージソート (Merge Sort)
# データ数がそれより多いならクイックソート (Quick Sort)
#
# 1. 一般的なクイックソート
# 2. ３つのメジアンによる分割と、
#    小さな配列の場合はマニュアルソートを取り入れたクイックソート
# 3.
#
#
##############
# 共通ブロック
##############
##
# display()
# 表示
function display(){
  for((i=0;i<nElems;i++)){
    echo "$i" "${array["$i"]}";
  }
  echo "------" ;
}
##
# insert()
# 配列の作成
function insert(){
  array[$((nElems++))]=$1
}
##
# setArray()
# 配列をセット
function setArray(){
  nElems=0;
  for((i=0; i<"$1"; i++)){
    insert `echo "$RANDOM"` ;
  }
}
##
# pertisionIt()
#
function pertisionIt(){
  #最初の成分の右
  local leftPtr=$1  ;
  #分割値の左
  local rightPtr=$(($2-1)) ;
  local pivot=$3
  while :; do
    #より大きい項目を見つける
    while (( "${array[++leftPtr]}" < "$pivot" )); do
      : 
    done
    #より小さい項目を見つける
    while (( "${array[--rightPtr]}" > "$pivot" )); do
      :
    done
    #ポインタが交差したら
    if [ "$leftPtr" -ge "$rightPtr" ]; then
      #分割は終了
      break ;
    else
      # leftPtr rightPtr
      #交差していないので成分を入れ替える
      local tmp="${array[leftPtr]}" ;
      array[leftPtr]="${array[rightPtr]}" ;
      array[rightPtr]="$tmp" ;
    fi
  done
  #leftPtr right-1
  #分割値をリストア
  local tmp="${array[leftPtr]}" ;
  array[leftPtr]="${array[right-1]}" ;
  array[right-1]="$tmp" ;
  #分割値の位置を返す
  pertision="$leftPtr" ;
}
##
# medialOf3()
# 
function medianOf3(){
  local left=$1 ;
  local right=$2 ;
  local center="$(( (left+right) / 2 ))" ;
  if [ "${array[left]}" -gt "${array[center]}" ]; then
    # left / centerを正順化
    local tmp="${array[left]}" ;
    array[left]="${array[center]}" ;
    array[center]="$tmp" ;
  fi
  if [ "${array[left]}" -gt "${array[right]}" ]; then
    # left / rightを正順化
    local tmp="${array[left]}" ;
    array[left]="${array[right]}";
    array[right]="$tmp" ;
  fi
  if [ "${array[center]}" -gt "${array[right]}" ]; then
    # center rightを正順化
    local tmp="${array[center]}" ;
    array[center]="${array[right]}" ;
    array[right]="$tmp" ;
  fi
  # 分割値をrightに
  local tmp="${array[center]}" ;
  array[center]="${array[right-1]}" ;
  array[right-1]="$tmp" ;
  #メジアンの値を返す
  median="${array[right-1]}" ;
}
##
#
########################################
# 3. 【完成版】小さな分割の場合に挿入ソートを行うクイックソート
# クイックソートのような強力なアルゴリズムが、再帰呼び出しの行き着く果てに、わ
# ずか２項目か３項目の小さな配列にも適用されるのは、妙な感じがします。最後の段
# 階、いわゆる小さな分割の場合に挿入ソートを行うクイックソート完成版。 
# 分割によってできる部分配列がある程度大きい間はクイックソートをして、それ以降
# の小さな部分配列はそのまま放置します。そうすると、配列全体としては、ほとんど
# ソートされた状態になります。その配列全体に対して、今度は挿入ソートを適用しま
# す。挿入ソートはほとんどソートされた状態の配列に対しては高速です。と、何人か
# の専門家は言っていますが、実は挿入ソートは、大きな配列を１つソートするより、
# 小さなソートをたくさんするほうが向いているのです。
##
# insertionSort3()
# 挿入ソート
function insertionSort(){
  for((out=left+1; out<=right; out++ )){
    tmp="${array[out]}" ;
    in="$out" ;
    while(( in>left && array[in-1]>=tmp )); do
      array[in]="${array[in-1]}" ;
      ((--in));
    done
    array[in]="$tmp"
  }
}
##
# quickSort3()
# クイックソート挿入ソート導入型
function quickSort3(){
  local left="$1" ;
  local right="$2" ;
  local size=$((right-left+1)) ;
  #小さければ挿入ソート
  if [ "$size" -lt 10 ]; then
    insertionSort "$left" "$right" ;
  else
    medianOf3 "$left" "$right" ;
    #範囲を分割する 戻り値は $pertision 
    pertisionIt "$left" "$right" "$median";
    #左側をソート
    quickSort3 "$left" "$((pertision-1))"  ;
    #右側をソート
    quickSort3 "$((pertision+1))" "$right" ; 
  fi
}
##
# exec_QuickSort3()
# クイックソート挿入ソート導入型
function exec_QuickSort3(){
  setArray "$1" ;
  # display ;
  quickSort3 0 $((nElems-1));
  display ;
}
#
########################################
# 2. ３つのメジアンによる分割と
# 要素数が３よりも小さな配列の場合はマニュアルソートを取り入れたクイックソート
#
# クイックソートの分割値の選び方は、これまでにいろんな方法が提案されています。
# その選び方は簡単でしかも最大や最小の値には決してならないという方法でなければ
# なりません。ランダムに選ぶのは方法としては簡単ですが、すでに見たように必ずし
# も常によい選択になるとは限りません。では全ての項目の値を調べて、そのメジアン
# をとるというのはどうでしょう？この方法は分割値の決め方としては理想的でもしか
# し、ソートそのものよりも多くの時間を要してしまいますから実用的ではありません。
# そこで妥協案として考えられたのが、配列の最初の項目、最後の項目、そして中央の
# 項目の中央の値を分割値とする方法を、３つのメジアンと言います。
# さらに成分が３よりも少ない小さな配列をソートするmanualSort()を実装しています。
# このメソッドは、部分配列が１セル以下なら直ちにリターン、２セルなら必要な入れ
# 替えを行い、３セルならソートをします。３のメジアン法は、配列が４成分以上でな
# いと使えませんから、３成分以下の配列に対しては今回のrecQuickSort()では使えな
# いのです。
##
##
# manualSort()
# 
function manualSort(){
  local left="$1" ;
  local right="$2" ;
  local size=$((right-left+1)) ; 
  if [ "$size" -le 1 ]; then
    #ソート不要
    return ;
  fi
  if [ "$size" -eq 2 ]; then
    #２のソート leftとrightを入れ替える
    if [ "${array[left]}" -gt "${array[right]}" ]; then 
      local tmp="${array[left]}" ;
      array[left]="${array[right]}" ;
      array[right]="$tmp" ;
      return ;
    fi
  else
    #サイズが３
    #３のソート,left, center, (right-1) & right
    if [ "${array[left]}" -gt "${array[right-1]}" ]; then
      # left / center
      local tmp="${array[left]}" ;
      array[left]="${array[right-1]}" ;
      array[right-1]="$tmp" ;
    fi
    # left / right
    if [ "${array[left]}" -gt "${array[right]}" ]; then
      local tmp="${array[left]}" ;
      array[left]="${array[right]}" ;
      array[right]="$tmp" ;
    fi
    # center / right
    if [ "${array[right-1]}" -gt "${array[right]}" ]; then
      local tmp="${array[right-1]}" ;
      array[right-1]="${array[right]}" ;
      array[right]="$tmp" ;
    fi
  fi
}
##
# quickSort2()
# クイックソート改良版
function quickSort2(){
  local left="$1" ;
  local right="$2" ;
  local size=$((right-left+1)) ;
  if [ "$size" -le 3 ]; then
    #小さければマニュアルソート
    manualSort "$left" "$right" ;
  else
    medianOf3 "$left" "$right" ;
    #範囲を分割する 戻り値は $pertision 
    pertisionIt "$left" "$right" "$median";
    #左側をソート
    quickSort2 "$left" "$((pertision-1))"  ;
    #右側をソート
    quickSort2 "$((pertision+1))" "$right" ; 
  fi
}
##
# exec_QuickSort2()
# クイックソート改良型
function exec_QuickSort2(){
  setArray "$1" ;
  # display ;
  quickSort2 0 $((nElems-1));
  display ;
}
########################################
# 普通のクイックソート
########################################
##
# pertionIt1()
# 普通のクイックソートで言うところのソートはこのメソッドで行う
# 共通メソッドの pertisionIt()とはちょっと内容が異なる
function pertisionIt1(){
  #最初の成分の右
  local leftPtr=$(($1-1))  ;
  #分割値の左
  local rightPtr="$right" ;
  # local pivot="$3" ;
  while :; do
    #より大きい項目を見つける
    while ((array[++leftPtr]<pivot)); do
      : 
    done
    #より小さい項目を見つける
    while ((rightPtr>0 &&  array[--rightPtr]>pivot)); do
      :
    done
    #ポインタが交差したら
    if [ "$leftPtr" -ge "$rightPtr" ]; then
      #分割は終了
      break ;
    else
      #交差していないので成分を入れ替える
      local tmp="${array[leftPtr]}" ;
      array[leftPtr]="${array[rightPtr]}" ;
      array[rightPtr]="$tmp" ;
    fi
  done
  #分割値をリストア
  local tmp="${array[leftPtr]}" ;
  array[leftPtr]="${array[right]}" ;
  array[right]="$tmp" ;
  #分割値の位置を返す
  pertision="$leftPtr" ;
}
##
# quickSort1()
# クイックソート初期型
function quickSort1(){
  local left="$1" ;
  local right="$2" ;
  local size=$((right-left)) ;
  # サイズが１なら
  if [ "$size" -le 0 ]; then 
    return; # ソート済み
  else # サイズが２以上
    #範囲を分割する 戻り値は $pertision 
    pivot="${array[$right]}";
    pertisionIt1 "$left" "$right" "$pivot";
    #左側をソート
    quickSort1 "$left" "$((pertision-1))"  ;
    #右側をソート
    quickSort1 "$((pertision+1))" "$right" ; 
  fi
}
##
# exec_QuickSort1()
# クイックソート初期型
function exec_QuickSort1(){
  setArray "$1" ;
  # display ;
  quickSort1 0 $((nElems-1));
  display ;
}
###
# メイン
###
# クイックソート初期型
time exec_QuickSort1 100 ;
# クイックソート改良型
time exec_QuickSort2 100 ;
# クイックソート挿入ソート導入型
time exec_QuickSort3 100 ;
exit ;
#
