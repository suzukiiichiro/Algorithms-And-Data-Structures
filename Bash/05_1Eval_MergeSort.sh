#!/bin/bash

#######################################
# 05_1MergeSort.shを、少しだけオブジェクティブに
# aRray[0].getValue() で値を取得できるように改変した
# 配列にIDと値を入れるだけのbashスクリプト
#######################################
##
# グローバル変数
declare -i nElems=0;
declare -i wElems=0;
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
# <>setWvalue() 
# セッター
function setWvalue() {
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Welem="$1";      
  local wvalue="$2";
  eval "wRray[$Welem].getWvalue()      { echo "$wvalue"; }"
}
##
# <>setWiD()
# セッター
function setWID(){
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Welem="$1";      
  local wid="$2";
  eval "wRray[$Welem].getWID()         { echo "$wid"; }"
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
# URL:https://www.youtube.com/watch?v=xli_FI7CuzA
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
# URL:https://www.youtube.com/watch?v=g-PGLbMth_g
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
## <>insertionSort()
# 挿入ソート
# URL:https://www.youtube.com/watch?v=DFG-XuyPYUQ
function insertionSort(){
  local tmp_id;
  local tmp_value;
  for((out=1;out<nElems;out++)){
    tmp_id=$(aRray[$out].getID);
    tmp_value=$(aRray[$out].getValue);
    in=$out;
    while (( in > 0 ))&&(( $(aRray[$((in-1))].getValue) > tmp_value ));do
      setID     "$in"    $(aRray[$((in-1))].getID);      #IDをセット
      setValue  "$in"    $(aRray[$((in-1))].getValue);   #Valueをセット
      in=$((in-1));
    done 
    setID     "$in"    $tmp_id;      #IDをセット
    setValue  "$in"    $tmp_value;   #Valueをセット
  } 
}
##
# merge()
# マージソートのマージ（併合）部分メソッド
merge(){
  echo "before merge"
  display;
  #作業スペースのインデクス
  local j=0; 
  #下半分の部分配列が始まる位置
  local lowPtr="$1" ;
  #上半分の部分配列が始まる位置
  local highPtr="$2" ;
  #上半分の配列の上限位置
  local _upperBound="$3" ;
  #下半分の配列の上限位置
  local _lowerBound="$lowPtr" ;
  local _mid="$(($highPtr-1))" ;
  #項目の数
  local n="$((_upperBound-_lowerBound+1))" ;
  #マージする列が２つある場合
  while (("$lowPtr" <= "$_mid" && "$highPtr" <= "$_upperBound" ));do
    #小さい値をコピー
    if (($(aRray[$lowPtr].getValue)<$(aRray[$highPtr].getValue)));then
      echo "low $lowPtr $(aRray[$lowPtr].getValue) < high $highPtr $(aRray[$highPtr].getValue)"
      echo "$lowPtr $(aRray[$lowPtr].getValue) をworkにセットします"
      setWID     "$j"    $(aRray[$lowPtr].getID);      #IDをセット
      setWvalue  "$j"    $(aRray[$lowPtr].getValue);   #Valueをセット
      ((lowPtr++));
      ((j++)) ;
    else
      echo "low $lowPtr $(aRray[$lowPtr].getValue) > high $highPtr $(aRray[$highPtr].getValue)"
      echo "$highPtr $(aRray[$highPtr].getValue) をworkにセットします"
      setWID     "$j"    $(aRray[$highPtr].getID);      #IDをセット
      setWvalue  "$j"    $(aRray[$highPtr].getValue);   #Valueをセット
      ((highPtr++));
      ((j++)) ;
    fi
  done
  echo "j1:$j"
  #前半分のリスト
  while (( "$lowPtr" <= "$_mid" )); do
    #前半分の要素をそのまま作業用配列にコピー
    setWID     "$j"    $(aRray[$lowPtr].getID);      #IDをセット
    setWvalue  "$j"    $(aRray[$lowPtr].getValue);   #Valueをセット
    ((lowPtr++));
    ((j++)) ;
  done
  echo "j2:$j"
  #後半分のリスト
  while (( "$highPtr" <= "$_upperBound" )) ; do
    #後半分の要素を逆順に作業用配列にコピー
    setWID     "$j"    $(aRray[$highPtr].getID);      #IDをセット
    setWvalue  "$j"    $(aRray[$highPtr].getValue);   #Valueをセット
    ((highPtr++));
    ((j++)) ;
  done
  echo "j3:$j"
  #昇順に整列するよう１つのリストにまとめる
  #作業用配列の両端から取り出したデータをマージして配列に入れる
  for((j=0; j<$n; j++)); do
    setID     $((_lowerBound+j))    $(wRray[$j].getWID);      #IDをセット
    setValue  $((_lowerBound+j))    $(wRray[$j].getWvalue);   #Valueをセット
  done
  echo "after merge"
  display;
}
## <>mergeSort()
# マージソート
# URL:https://www.youtube.com/watch?v=4VqmGXwpLqc
mergeSort(){
  local lowerBound="$1" ;
  local upperBound="$2" ;
  echo "0:$lowerBound$upperBound"
  echo "lower:$lowerBound upper:$upperBound"
  #範囲が１なら再帰呼び出しの終了 基底条件
  if [ "$lowerBound" -eq "$upperBound" ]; then
    echo "1:$lowerBound$upperBound:範囲が１なら再帰呼び出しの終了 基底条件"
    #ソートは不要
    :
  else
    echo "2:$lowerBound$upperBound"
    #列を２つに分割する中間点を見つける
    local mid=$(( $((lowerBound+upperBound)) / 2 ));
    #前半分をソート
    echo "3:$lowerBound$upperBound"
    echo "mae $lowerBound $mid"
    mergeSort "$lowerBound" "$mid" ;
    #後半分をソート
    echo "4:$lowerBound$upperBound"
    echo "usr $((mid+1)) $upperBound"
    mergeSort "$((mid+1))" "$upperBound"
    #両者をマージ
    echo "5:$lowerBound$upperBound"
    echo "logic $lowerBound $((mid+1)) $upperBound"
    merge "$lowerBound" "$((mid+1))" "$upperBound" ;
    echo "6:$lowerBound$upperBound:mergeまで到達し再帰終了"
  fi
}
# <>execSort()
# メインルーチン
function execSort(){
  local N=$1;
  setArray $N;    #配列をセット
  echo "修正前"
  display;
  #bubbleSort;     #バブルソート
  #selectionSort;  #選択ソート
  #insertionSort;   #挿入ソート
  mergeSort 0 "$(($nElems-1))" ;  #マージソート
  echo "修正後"
  display;
}
##
# 実行
time execSort 10;
exit;
