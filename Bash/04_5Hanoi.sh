#!/bin/bash

# 起動方法  ./ファイル名 円盤の数
# ./Hanoni.sh 5 
#
# グローバル変数
declare -i DISKS=$1;
declare -i E_NOPARAM=86;
declare -i E_BADPARAM=87;   
declare -i E_NOEXIT=88;
declare -i Moves=0;
declare -i MWIDTH=7;
declare -i MARGIN=2;
declare -a Rod1; # 軸１
declare -a Rod2; # 軸２
declare -a Rod3; # 軸３
#
DELAY=0.3    # ディレクをかける
#
##
# <>repeat()
#
function repeat(){  
  for((i=0;i<$2;i++)){
    echo -n "$1";
  }
}
##
# <>FromRod()
#
function FromRod  {
  local rod summit weight sequence
  while true; do
    rod=$1;
    test ${rod/[^123]/} || continue;
    sequence=$(echo $(seq 0 $disks1 | tail -r ));
    for summit in $sequence; do
      eval weight=\${Rod${rod}[$summit]};
      test $weight -ne 0 &&
           { echo "$rod $summit $weight"; return; }
    done
  done
}
##
# <>ToRod()
#
function ToRod  { 
  local rod firstfree weight sequence
  while true; do
    rod=$2;
    test ${rod/[^123]} || continue;
    sequence=$(echo $(seq 0 $disks1 | tail -r));
    for firstfree in $sequence; do
      eval weight=\${Rod${rod}[$firstfree]};
      test $weight -gt 0 && { (( firstfree++ )); break; };
    done
    test $weight -gt $1 -o $firstfree = 0 &&
         { echo "$rod $firstfree"; return; }
  done
}
##
# <>PrintRods()
#
function PrintRods  {
  local disk rod empty fill sp sequence;
  tput cup 5 0;
  repeat " " $spaces1;
  echo -n "|";
  repeat " " $spaces2;
  echo -n "|";
  repeat " " $spaces2;
  echo "|";
  sequence=$(echo $(seq 0 $disks1 | tail -r));
  for disk in $sequence;do
    for rod in {1..3};do
      eval empty=$(( $DISKS - (Rod${rod}[$disk] / 2) ));
      eval fill=\${Rod${rod}[$disk]};
      repeat " " $empty;
      test $fill -gt 0 && repeat "*" $fill || echo -n "|";
      repeat " " $empty;
    done
    echo;
  done
  repeat "=" $basewidth   ;
  echo
}
##
# <>display()
#
function display(){
  echo;
  PrintRods;
  first=( `FromRod $1` );
  eval Rod${first[0]}[${first[1]}]=0;
  second=( `ToRod ${first[2]} $2` );
  eval Rod${second[0]}[${second[1]}]=${first[2]};
  if [ "${Rod3[lastmove_t]}" = 1 ];then   
    tput cup 0 0;
    echo; echo "+  Final Position: $Moves moves";
    PrintRods;
  fi
  sleep $DELAY;
}
##
# <>dohanoi()
#
function dohanoi() {   
  case $1 in
  0)
  ;;
  *)
    dohanoi "$(($1-1))" $2 $4 $3
    if [ "$Moves" -ne 0 ];then
      tput cup 0 0;
      echo; echo "+  Position after move $Moves";
    fi
    ((Moves++));
    echo -n "   Next move will be:  ";
    echo $2 "-->" $3;
    display $2 $3;
    dohanoi "$(($1-1))" $4 $3 $2;
  ;;
  esac
}
##
# setup_arrays()
#
function setup_arrays(){
  local dim n elem;
  let "dim1 = $1 - 1";
  elem=$dim1;
  for n in $(seq 0 $dim1);do
    let "Rod1[$elem] = 2 * $n + 1";
    Rod2[$n]=0;
    Rod3[$n]=0;
    ((elem--));
  done
}
##
# メイン
#
let "basewidth = $MWIDTH * $DISKS + $MARGIN" 
let "disks1 = $DISKS - 1"
let "spaces1 = $DISKS" 
let "spaces2 = 2 * $DISKS" 
let "lastmove_t = $DISKS - 1"                
trap "tput cnorm" 0
tput civis;
clear;                # 画面のクリア
setup_arrays $DISKS;  # 配列の作成
tput cup 0 0;
echo; echo "+  Start Position";
case $# in 
  1) 
    case $(($1>0)) in     
      1)
        disks=$1;
        dohanoi $1 1 3 2;
        echo;
        exit 0;
      ;;
      *)
        echo "$0: Illegal value for number of disks";
        exit $E_BADPARAM;
      ;;
    esac
  ;;
  *)
    echo "実行方法: $0 N";
    echo "       Where \"N\" is the number of disks.";
    exit $E_NOPARAM;
  ;;
esac
exit $E_NOEXIT;  
