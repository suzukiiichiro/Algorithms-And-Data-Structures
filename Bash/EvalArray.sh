#!/usr/bin/bash

declare -a aNode;
declare -i iD=0;
##
#
function insertNode(){
  local nElems=$1;
  local uID=$2;
  local value=$3;
  
  eval "${aNode[$nElems]}.getValue()      { echo "$value"; }"
  eval "${aNode[$nElems]}.getID()         { echo "$uID"; }"
}
##
#
function MAIN(){
  local nElems=0;
  local setValue=(10 4 16 1 7 12 15 20 32 42);

  #insert
  for value in "${setValue[@]}"; do
    local uID=$(uuidgen|tr -d '-');
    insertNode $((nElems++)) "$uID" "$value";
  done

  #display
  for((i=0;i<nElems;i++)){
    echo "ID   " $(${aNode[$nElems]}.getID);
    echo "Value" $(${aNode[$nElems]}.getValue);
  }
  echo "単体での出力";
  echo $( ${aNode[4]}.getID );
  echo $( ${aNode[4]}.getValue );
}
##
#
MAIN 10;
