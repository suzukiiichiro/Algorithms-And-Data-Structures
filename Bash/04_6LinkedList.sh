#!/bin/bash


########################################
# 連結リスト　Linked List 
# Bash シェルスクリプト版
########################################


##
# final()
# 実行後に行うファイナル処理
# 実行に必要なノードファイルを削除します。
function final(){
  rm -fr $dirName;
}
##
# makeNodeFile()
# ノードファイルを作成
#
dirName="demo";
list1="list1";
node1="node1";
node2="node2";
node3="node3";
#
function makeNodeFile(){
  rm -fr "$dirName";
  mkdir -p $dirName;
  cd demo;
  :>$list1;
  echo "node1"  | tee "$list1";
  echo "3"      | tee -a "$list1";
  :>$node1;
  echo "node2"  | tee "$node1";
  echo "foo"    | tee -a "$node1";
  :>$node2;
  echo "node3"  | tee "$node2";
  echo "bar"    | tee -a "$node2";
  :>$node3;
  echo "none"   | tee "$node3";
  echo "!"      | tee -a "$node3";
  cd ../
}



##
## 
# addAtIdx()
# 指定したインデックスに要素を追加
function addAtIdx {
  local first=$1;
  local N=$2;
  local dataItems=$3;
  if [ "$N" -eq "0" ]; then
    add $first $dataItems;
  else
    let prevIdx=$N-1;
    let size=$(tail -n1 $first)+1;
    prev=$(getNode $first $prevIdx);
    if [ "$N" -eq $(tail -n1 $first) ]; then
      cur="none";
    else
      cur=$(getNode $first $N);
    fi
    printf "%s\n%s" $cur $dataItems > node$size;
    printf "%s\n%s" node$size $(tail -n1 $prev) > $prev;
    printf "%s\n%s" $(head -n1 $first) $size > $first;
  fi
}
## 
# remove()
# リストの先頭から要素を削除します。
# $1 - 追加するリストの先頭
function remove {
  local first=$1;
  local oldHead=$(head -n1 $first);
  local oldVal=$(tail -n1 $oldHead);
  let size=$(tail -n1 $first)-1;
  local newHead=$(head -n1 $oldHead);
  printf "%s\n%s" $newHead $size > $first;
  rm $oldHead;
  echo $oldVal;
}
##
# removeAtIdx()
# インデックスの要素を削除します
function removeAtIdx {
  local first=$1; 
  local N=$2;
  local prev;
  local cure;
  local Next;
  local oldVal;
  if [ "$N" -eq "0" ]; then
    remove $first;
  else
    let prevIdx=$N-1
    let size=$(tail -n1 $first)-1
    prev=$(getNode $first $prevIdx)
    cur=$(getNode $first $N)
    Next=$(head -n1 $cur)
    oldVal=$(tail -n1 $cur)
    printf "%s\n%s" $Next $(tail -n1 $prev) > $prev
    printf "%s\n%s" $(head -n1 $first) $size > $first
    rm $cur;
    echo $oldVal;
  fi
}
##
# getNode()
# N番目の要素を含むノードの名前を返します。
function getNode {
  local first=$1;
  local N=$2;
  rest=$(head -n1 $first)
  let restlen=$N-1;
  if [ "$N" -eq "0" ]; then
    echo $rest;
  else
    getNode $rest $restlen;
  fi
}
##
# get()
# リンクリストのN番目の要素を取得します。
function get {
  local currentNode=$1; 
  local N=$2;           
  local current=$(tail -n1 $currentNode);
  local rest=$(head -n1 $currentNode);
  let restlen=$N-1;
  if [ "$N" -eq "0" ]; then
    echo "$current";
  else
    get $rest $restlen; 
  fi
}
## 
# add()
# リストの先頭に要素を追加します
function add {
  # リストの先頭を参照
  local first=$1;   
  local N=$2;       
  local oldHead=$(head -n1 $first); 
  let size=$(tail -n1 $first)+1; 
  printf "%s\n%s" $oldHead $N > node$size;
  printf "%s\n%s" node$size $size > $first;
}
##
# printList()
# 連結されたリスト全体を出力
function printList {
  local current=$1; 
  local dataItems=$(tail -n1 $current); 
  local Next=$(head -n1 $current); 
  echo "データアイテム:" $dataItems "次の参照:" $Next;
  if [ "$Next" != "none" ]; then
    printList $Next;
  fi
}
##
# execLinkedList()
# 連結リストの実行
function execLinkedList(){
  # demoディレクトリへ移動
  cd demo;
  #
  printList $(head -n1 $list1);
  printf "\nリストの先頭に hello を追加\n"
  add "$list1" "hello";
  printList $(head -n1 $list1);
  #
  printf "\nリストの先頭に world を追加\n"
  add "$list1" "world"
  printList $(head -n1 $list1)
  #
  printf "\n０から数えて１番目の要素を取得\n"
  get $(head -n1 $list1) 1
  #
  printf "\n０から数えて１番目のノード名を取得\n"
  getNode "$list1" 1
  #
  printf "\n０から数えて２番目に要素 327 を挿入\n"
  addAtIdx "$list1" 2 327
  printList $(head -n1 $list1)
  #
  printf "\nリストの先頭に要素 94 を挿入\n"
  addAtIdx "$list1" 0 94
  printList $(head -n1 $list1)
  #
  printf "\n０から数えて７番目に要素 1138 を挿入\n"
  addAtIdx "$list1" 7 1138
  printList $(head -n1 $list1)
  #
  printf "\nリストの先頭の要素 %s を削除\n" $(remove "$list1")
  printList $(head -n1 $list1)
  #
  printf "\nリストの１番目の要素 %s を削除\n" $(removeAtIdx "$list1" 1)
  printList $(head -n1 $list1)
  #
  printf "\nリスト５番目の要素 %s を削除\n" $(removeAtIdx "$list1" 5)
  printList $(head -n1 $list1)
  #
  printf "\nリストの先頭の要素 %s を削除\n" $(removeAtIdx "list1" 0)
  printList $(head -n1 $list1)
  #
  printf "\n%s を削除し初期状態に戻りました\n" $(remove "$list1")
  printList $(head -n1 $list1)
  #
  cd ../;
}
##
# メイン
makeNodeFile; # makeDir makeFileなどのノードファイルを作成します。
execLinkedList
final;        # 作成したディレクトリを削除（当然中にあるノードファイルも消えます）

exit;
