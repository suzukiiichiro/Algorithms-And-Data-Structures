#!/bin/bash
#バイナリーサーチを実装
root="";
### Utility functions to generate a BST ###
# Define set 'methods'
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
gen_uid() {
	# prefix 'id' to the uid generated to guarentee
	# it starts with chars, and hence will work as a
	# bash variable
	echo "id$(uuidgen|tr -d '-')";
}
# Generates a new node 'object'
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
  eval "new_node $id $value";
  if [ -z "$root" ];then
    #ルートから手順を開始する。
    root=$id;
  else
    current=$root;
    parent="";
    while true;do
      parent=$current;
      #着目しているノードと目的の値を比較する。
      #目的の値 < 着目しているノード」なら左の子が、次の着目ノードとなる。
      if [ "$value" -le $(${current}.getValue) ];then
        current=$(eval ${current}.getLeftChild);
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ -z "$current" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、次の着目ノードの位置にデータを挿入。
          set_node_left $parent $id;
          return;
        fi
      #「着目しているノード ≤ 目的の値」なら右の子が、次の着目ノードとなる。
      else
        current=$(eval ${current}.getRightChild);
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ -z "$current" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、次の着目ノードの位置にデータを挿入。
          set_node_right $parent $id;
          return;
        fi
      fi
    done
  fi  
}
function theTree_find(){
  echo "find start"
  key=$1;
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
    if [ -z "$current" ];then
      echo "null" #didn't find it
      return;
    fi

    echo $(${current}.getValue)#found it

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

   

}

main;
