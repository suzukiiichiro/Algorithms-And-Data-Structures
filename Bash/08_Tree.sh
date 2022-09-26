#!/bin/bash
#バイナリーサーチを実装
root="";
function theTree_insert(){
  id=$1;
  dd=$2;
  iData=$id;
  dData[iData]=$dd;
  leftChild[iData]="";
  rightChild[iData]="";
  if [ -z "$root" ];then
    #ルートから手順を開始する。
    root=$iData;
  else
    current=$root;
    parent="";
    while true;do
      parent=$current;
      #着目しているノードと目的の値を比較する。
      #目的の値 < 着目しているノード」なら左の子が、次の着目ノードとなる。
      if [ "$id" -lt "$current" ];then
        current=${leftChild[$current]};
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ -z "$current" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、次の着目ノードの位置にデータを挿入。
          leftChild[$parent]=$iData; 
          return;
        fi
      #「着目しているノード ≤ 目的の値」なら右の子が、次の着目ノードとなる。
      else
        current=${rightChild[$current]};
        #存在すれば、次の着目ノードに移って繰り返し。
        if [ -z "$current" ];then
          #次の着目ノードが存在しなければ（現在の着目ノードが葉であれば）、次の着目ノードの位置にデータを挿入。
          rightChild[$parent]=$iData;
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
  echo "root:$root"
  while [ "$current" != "$key" ] ;do
    if [ "$key" -lt "$current" ];then
      echo "go left"
      current=${leftChild["$current"]};
    else
      echo "go right"
      current=${rightChild["$current"]};
    fi
    if [ -z "$current" ];then
      echo "null" #didn't find it
      return;
    fi

    echo "$current" #found it  

  done
  echo "####"
}

function main(){
  #デフォルトでいくつか値を入れる
  theTree_insert "50" "1.5";
  theTree_insert "25" "1.2";
  theTree_insert "75" "1.7";
  theTree_insert "12" "1.5";
  theTree_insert "37" "1.2";
  theTree_insert "43" "1.7";
  theTree_insert "30" "1.5";
  theTree_insert "33" "1.2";
  theTree_insert "87" "1.7";
  theTree_insert "93" "1.5";
  theTree_insert "97" "1.5";
  
  theTree_find "92";
  
  theTree_find "93";

  theTree_find "12";

   

}

main;
