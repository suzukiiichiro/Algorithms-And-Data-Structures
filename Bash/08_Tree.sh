#!/bin/bash
#バイナリーサーチを実装
root="";
### Utility functions to generate a BST ###
#スタックの関数を追加した。配列ごとに別メソッドで作ったがevalでまとめた方が良さそう
function globalStack.push() {
    globalarr+=($1)
}

function globalStack.pop() {
    if [ ${#globalarr[*]} == 0 ];then
      echo "null";
      return;
    fi
    local el=${globalarr[${#globalarr[*]}-1]}
    po=$((${#globalarr[*]}-1))
    unset globalarr[$po]
}
function globalStack.peek() {
    if [ ${#globalarr[*]} == 0 ];then
      echo "null";
      return;
    fi
    local el=${globalarr[${#globalarr[*]}-1]}
    po=$((${#globalarr[*]}-1))
    echo $el
}
function globalStack.isEmpty() {
  if [ ${#globalarr[*]} == 0 ];then
    echo "true";
  else
    echo "false"
  fi
}
function localStack.push() {
    localarr+=($1)
    #echo pushed: $1
}

function localStack.pop() {
    if [ ${#localarr[*]} == 0 ];then
      echo "null";
      return;
    fi
    local el=${localarr[${#localarr[*]}-1]}
    po=$((${#localarr[*]}-1))
    unset localarr[$po]
}
function localStack.peek() {
    if [ ${#localarr[*]} == 0 ];then
      echo "null";
      return;
    fi
    local el=${localarr[${#localarr[*]}-1]}
    po=$((${#localarr[*]}-1))
    echo $el
}
function localStack.isEmpty() {
  if [ ${#localarr[*]} == 0 ];then
    echo "true";
  else
    echo "false"
  fi
}
# Define set 'methods'
#setメソッドはインスタンスのgetterメソッドを動的に生成する
set_node_left() {
	eval "${1}.getLeftChild()  { echo "$2"; }"
}
set_node_right() {
	eval "${1}.getRightChild() { echo "$2"; }"
}
set_node_value() {
	eval "${1}.getValue()      { echo "$2"; }"
}
# Generate unique id:
#インスタンスのユニークなidを生成する
gen_uid() {
	# prefix 'id' to the uid generated to guarentee
	# it starts with chars, and hence will work as a
	# bash variable
	echo "id$(uuidgen|tr -d '-')";
}
###
function display_Tree(){

globalarr=();
globalStack.push "$root";
nBlanks=32;
isRowEmpty="false";
echo "......................................................"
while [[ $isRowEmpty == "false" ]];do
  localarr=();
  isRowEmpty="true"
  for ((j=0; j<nBlanks; j++));do
    echo -n " ";
  done
  while [[ $(globalStack.isEmpty) == "false" ]];do
    #サブシェルでpopメソッドを呼び出しても配列の削除が反映されないので
    #peekメソッドを別に作った。
    temp=$(globalStack.peek);
    globalStack.pop
    if [ "$temp" != "null" ];then
      echo -n $(${temp}.getValue)
      localStack.push $(eval ${temp}.getLeftChild);  
      localStack.push $(eval ${temp}.getRightChild);  
      if [[ $(eval ${temp}.getRightChild) != "null" ]]||[[ $(eval ${temp}.getLeftChild) != "null" ]];then
        isRowEmpty="false"
      fi
    else
      echo -n "--"
      localStack.push "null";
      localStack.push "null"
    fi
    nBlanks2=$((nBlanks*2-2));
    for ((j=0; j<nBlanks2; j++));do
      echo -n " ";
    done
  done
  echo ""
  nBlanks=$((nBlanks/2))
  while [[ $(localStack.isEmpty) == "false" ]];do
    globalStack.push $(localStack.peek) 
    localStack.pop
  done 
done
echo ""......................................................""

}
# Generates a new node 'object'
#インスタンスを生成する
function new_node() {
	local node_id="$1";
	local value="$2";
	local left="$3";
	local right="$4";
	eval "${node_id}set='set'";
	eval "set_node_value $node_id $value";
	eval "set_node_left $node_id $right";
	eval "set_node_right $node_id $right";
}
function theTree_insert(){
  local value=$1;
  local id=$(gen_uid);
  #nodeのインスタンスを生成する。
  eval "new_node $id $value null null";
  #最初にルートを設定する（初回のinsertの時だけ動く）
  if [ -z "$root" ];then
    #ルートから手順を開始する。
    root=$id;
  else
    #ルートノードから値を比較しながら下のノードに移動していく 
    current=$root;
    parent="null";
    while true;do
      parent=$current;
      #着目しているノードと目的の値を比較する。
      #目的の値 < 着目しているノード」なら左の子が、次の着目ノードとなる。
      if [ "$value" -lt $(${current}.getValue) ];then
        current=$(eval ${current}.getLeftChild);
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ "$current" == "null" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、一つ前の着目ノード(parent)の左(leftChild)位置にデータを挿入。
          set_node_left $parent $id;
          return;
        fi
      #「着目しているノード ≤ 目的の値」なら右の子が、次の着目ノードとなる。
      else
        current=$(eval ${current}.getRightChild);
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ "$current" == "null" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、一つ前の着目ノード(parent)の右(rightChild)位置にデータを挿入。
          set_node_right $parent $id;
          return;
        fi
      fi
    done
  fi  
}
function theTree_find(){
  key=$1;
  echo "find start $key"
  current="$root";
  echo "root:$(${root}.getValue)"
  while [ $(${current}.getValue) != "$key" ] ;do
    if [ "$key" -le $(${current}.getValue) ];then
      echo "go left"
      current=$(eval ${current}.getLeftChild);
    else
      echo "go right"
      current=$(eval ${current}.getRightChild);
    fi
    if [ "$current" == "null" ];then
      echo "null" #didn't find it
      return;
    fi
    echo $(${current}.getValue) #found it

  done
  echo "####"
}

function main(){
  #デフォルトでいくつか値を入れる
  theTree_insert "50";
  theTree_insert "25";
  theTree_insert "75";
  theTree_insert "12";
  theTree_insert "37";
  theTree_insert "43";
  theTree_insert "30";
  theTree_insert "33";
  theTree_insert "87";
  theTree_insert "93";
  theTree_insert "97";
  
  theTree_find "92";
  
  theTree_find "93";

  theTree_find "12";

  display_Tree;   

}

main;
