#!/bin/bash

################
# オブジェクトソート（挿入ソート）
################
#
#単純化のために、ここまで学んだソートアルゴリズムはもっぱら、プリミティブデータタイプでした。
#しかしソートルーチンは、プリミティブデータよりオブジェクトをソートするために使うことのほうが、実際には多いのです。
#ここでは、lastName,firstName,ageフィールドをもつオブジェクトをlastNameフィールドでソートします。
#ロジックは挿入ソートを使用します。
#
# 挿入ソートは数列を整列するアルゴリズムの一つです。
# 最初に、左端の数字を操作済みにします。
#
# 済
# 5   3   4   7   2   8   6   9   1
# 
# つづいてまだ操作していないものの中で左端の数字を取り出し、
# 左端の操作済みになっている数字と比較します。
# もし左の数字のほうが大きい場合、二つの数字を入れ替えます。
#
# 済  ↓
# 5   3   4   7   2   8   6   9   1
# 
# この操作を自分より小さい数字が現れるか、数字が左端に到達するまで繰り返します。
# この場合、５＜３なので数字を入れ替えます。
#  ←→
# 3   5   4   7   2   8   6   9   1
# 
# 数字が左端に到達したので止まり、数字を操作済みにします。
#
# 済　済
# 3   5   4   7   2   8   6   9   1
# 
# 同様に済になっていない左端の数字を取り出し
#
# 済　済  ↓
# 3   5   4   7   2   8   6   9   1
#
# 左の数字と比較します。 
# 済　済  ↓
# 3   5   4   7   2   8   6   9   1
#
# 5 < 4 なので数字を入れ替えます。
#
# 済　↓   済
# 3   4   5   7   2   8   6   9   1
#
# ３＜４でじぶんより小さい数字が現れたので交換せずに止まり、
# 数字を交換済みとして、比較を右に一つ移動します。
#
# 済　済  済  ↓
# 3   4   5   7   2   8   6   9   1
#
# 同様の操作を、全ての数字が操作済みになるまで繰り返します。
#
# 済　済  済  済  ↓
# 3   4   5   7   2   8   6   9   1
#
# 済　済  済  済  済  ↓
# 2   3   4   5   7   8   6   9   1
#
# 済　済  済  済  済  済  ↓
# 2   3   4   5   7   8   6   9   1
#
# 済　済  済  済  済  済  済  ↓
# 2   3   4   5   6   7   8   9   1
#
# 済　済  済  済  済  済  済  済  ↓
# 2   3   4   5   6   7   8   9   1
#
# 済　済  済  済  済  済  済  済  済
# 1   2   3   4   5   6   7   8   9
#
#
#<> insertion Sort
#挿入ソート
#https://www.youtube.com/watch?v=DFG-XuyPYUQ
#　平均計算時間が O(ｎ^2)
#　安定ソート
#　比較回数は「　n(n-1)/2以下　」
#　交換回数は「　約n^2/2以下　」
#
##
#######################################
# 02_3InsertionSort.shを、少しだけオブジェクティブに
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
    echo -n "aRray[$i]\
    LastName:  $( aRray[$i].getLastName )\
    FirstName: $( aRray[$i].getFirstName ) \
    Age: $( aRray[$i].getAge ) "; 
     
    echo "";
  }
}
##
# <>setLastName() 
# セッター
function setLastName() {
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Elem="$1";      
  local lastname="$2";
	eval "aRray[$Elem].getLastName()      { echo "$lastname"; }"
}
##
# <>setFirstName() 
# セッター
function setFirstName() {
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Elem="$1";      
  local firstname="$2";
	eval "aRray[$Elem].getFirstName()      { echo "$firstname"; }"
}
##
# <>setAge()
# セッター
function setAge(){
  #今後挿入や置き換えに備えてnElemsとは別の変数を用意しておく
  local Elem="$1";      
  local age="$2";
	eval "aRray[$Elem].getAge()         { echo "$age"; }"
}
##
# <> insert
# 配列の要素に値を代入
function insert(){
  local lastname=$1;        #LastName
  local firstname=$2;       #FirstName
  local age=$3;       #Age
  setLastName     "$nElems"    "$lastname";      #LastNameをセット
  setFirstName  "$nElems"    "$firstname";   #FirstNameをセット
  setAge  "$nElems"    "$age";   #Ageをセット
  ((nElems++));
}
##
# <> set Array
# 配列を作成 今回は使わない
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
  local tmp_lastname;
  local tmp_firstname;
  local tmp_age;
  local in;
  for((out=1;out<nElems;out++)){
     tmp_lastname=$(aRray[$out].getLastName);
     tmp_firstname=$(aRray[$out].getFirstName);
     tmp_age=$(aRray[$out].getAge);
     in=$out;
     #文字列を辞書式にアルファベット順に比較したい場合は[[]]
     #https://fumiyas.github.io/2013/12/15/test.sh-advent-calendar.html
     #[[ 文字列1 > 文字列2 ]] 現在のロケールの辞書順で文字列1が文字列2よりも後なら真。
     while (( in > 0 ))&&[[ $(aRray[$((in-1))].getLastName) > $tmp_lastname ]];do
       setLastName     "$in"    $(aRray[$((in-1))].getLastName);      #LastNameをセット
       setFirstName  "$in"    $(aRray[$((in-1))].getFirstName);   #FirstNameをセット
       setAge  "$in"    $(aRray[$((in-1))].getAge);   #Ageをセット
       in=$((in-1));
     done 
     setLastName     "$in"    $tmp_lastname;      #LastNameをセット
     setFirstName  "$in"    $tmp_firstnname;   #FirstNameをセット
     setAge  "$in"    $tmp_age;   #Ageをセット
  } 
}
# <>execSort()
# メインルーチン
function execSort(){
  #配列をセット
  insert "Evans" "Patty" "24";
  insert "Smith" "Doc" "59";
  insert "Smith" "Lorraine" "37";
  insert "Smith" "Paul" "37";
  insert "Yee" "Tom" "43";
  insert "Hashimoto" "Sato" "21";
  insert "Stimson" "Henry" "29";
  insert "Velasquez" "Jose" "72";
  insert "Vang" "Minh" "22";
  insert "Creswell" "Lucinda" "18";

  echo "修正前"
  display;
  #bubbleSort;     #バブルソート
  #selectionSort;  #選択ソート
  insertionSort;   #オブジェクトソート（挿入ソート）
  echo "修正後"
  display;
}
##
# 実行
time execSort 10;
exit;
