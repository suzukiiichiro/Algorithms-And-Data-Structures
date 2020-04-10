/*

  Bash(シェルスクリプト)で学ぶアルゴリズムとデータ構造  
  一般社団法人  共同通信社  情報技術局  鈴木  維一郎(suzuki.iichiro@kyo}ws.jp)
 
  ステップバイステップでアルゴリズムを学ぶ
  
  目次
  1. ソートアルゴリズム
    バブルソート
    選択ソート
    挿入ソート
    マージソート
    シェルソート
    クイックソート

*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAX 10
//
int array[MAX];
int nElems=0;
//
void display(){
  for(int i=0;i<nElems;i++){
    printf("%d  %d\n",i,array[i]);
  }
  printf("\n");
}
//
void insert(int rand){
  array[nElems++]=rand;
}
//
void setArray(int n){
  srand((unsigned int)time(NULL));
  for(int i=0;i<n;i++){
    insert(rand()%n+1);
  }
}
/*
  1. バブルソート 13404mm
  https://ja.wikipedia.org/wiki/バブルソート
  https://www.youtube.com/watch?v=8Kp-8OGwphY
    平均計算時間が O(N^2)
    安定ソート
    比較回数は「  n(n-1)/2  」
    交換回数は「  n^2/2  」
    派生系としてシェーカーソートやコムソート
*/
void bubbleSort(){
  int i,j,t,tmp;
  for(int i=nElems;i>0;i--){
    for(int j=0;j<i-1;j++){
      if(array[j]>array[j+1]){
        tmp=array[j];
        array[j]=array[j+1];
        array[j+1]=tmp;
      }
    }
  }
}
/*
  選択ソート 3294mm
  https://ja.wikipedia.org/wiki/選択ソート
  https://www.youtube.com/watch?v=f8hXR_Hvybo
    平均計算時間が O(N^2)
    安定ソートではない
    比較回数は「  n(n-1)/2  」
    交換回数は「  n-1  」
*/
void selectionSort(){
  int i,j,t,m,tmp,min; 
  for(int i=0;i<nElems;i++){
    min=i;
    for(int j=i+1;j<nElems;j++){
      if(array[m]>array[j]){
        min=j;
      }
    }
    if(min==i){continue;}
    tmp=array[min];
    array[min]=array[i];
    array[i]=tmp;
  }
}
/*
  挿入ソート 3511mm
  https://ja.wikipedia.org/wiki/挿入ソート
  https://www.youtube.com/watch?v=DFG-XuyPYUQ
    平均計算時間が O(N^2)
    安定ソート
    比較回数は「  n(n-1)/2以下  」
    交換回数は「  約n^2/2以下  」
*/ 
void insertionSort(){
  int o,i,t,out,in,tmp;
  for(int out=1;out<nElems;out++){
    tmp=array[out];
    for(int i=out;i>0&&array[i-1]>tmp;i--){
      array[i]=array[i-1];
    }
    array[i]=tmp;
  }
}
/**
  マージソート 1085mm
  https://ja.wikipedia.org/wiki/マージソート
  https://www.youtube.com/watch?v=EeQ8pwjQxTM
    平均計算時間が O(N(Log N))
    安定ソート
    50以下は挿入ソート、5万以下はマージソート、あとはクイックソートがおすすめ。
    バブルソート、挿入ソート、選択ソートがO(N^2)の時間を要するのに対し、マージ
    ソートはO(N*logN)です。
    例えば、N(ソートする項目の数）が10,000ですと、N^2は100,000,000ですが、
    n*logNは40,000です。別の言い方をすると、マージソートで４０秒を要するソート
    は、挿入ソートでは約２８時間かかります。
    マージソートの欠点は、ソートする配列と同サイズの配列をもう一つ必要とする事
    です。
    元の配列がかろうじてメモリに治まるという大きさだったら、マージソートは使え
    ません。
*/
void mergeSortLogic(int f,int m,int l){
  int first,mid,last;
  int workArray[MAX];
  int n,i,j,n1;
  n=l-f+1;
  for(int i=f,j=0;i<=l;){
    workArray[j++]=array[i++];
  }
  ((m>l))&&((m=(f+l)/2));
  ((n1=m-f+1));
  for(int i=f,j=0,k=n1;i<=l;i++){
    {
      if(j<n1){
        ((k==n))||{ 
          ((${w[j]}<${w[k]}))
        }
      }
    }&&{ 
      array[i]="${w[j++]}";
    }||{
      array[i]="${w[k++]}";
    }
  }
}
void mergeSort(){
    local f="$1" l="$2" m=; f:first l:last m:mid
    ((l>f))||return 0;
    m=$(((f+l)/2));
    mergeSort "$f" "$m";
    mergeSort "$((m+1))" "$l"
    mergeSortLogic "$f" "$m" "$l";
}

/**
  シェルソート 1052mm
  https://ja.wikipedia.org/wiki/シェルソート
  https://www.youtube.com/watch?v=M9YCh-ZeC7Y
    平均計算時間が O(N((log N)/(log log N))^2)
    安定ソートではない
    挿入ソート改造版
    ３倍して１を足すという処理を要素を越えるまで行う
*/
void shellSort(){
  local s=1 in t;s:shell in:inner t:temp
  while(s<nElems/3){
      s=$((s*3+1));
  }
  while(s>0){
    for(int i=s;i<nElems;i++){
      t="${array[i]}";
      in="$i";
      while(in>s-1&&array[in-s]>=t){
        array[in]="${array[in-s]}";
        in=$((in-s));
      }
      array[in]="$t";
    }
    s=$(((s-1)/3));
  }
}

/**
  クイックソート 1131mm
  https://ja.wikipedia.org/wiki/クイックソート
  https://www.youtube.com/watch?v=aQiWF4E8flQ
    平均計算時間が O(n Log n)
    安定ソートではない
    最大計算時間が O(n^2)
  データ数が 50 以下なら挿入ソート (Insertion Sort)
  データ数が 5 万以下ならマージソート (Merge Sort)
  データ数がそれより多いならクイックソート (Quick Sort)
*/

void quickSort() {
  local -i l r m p t i j k;r:right l:left m:middle p:part t:temp 
  ((l=i=$1,r=j=$2,m=(l+r)/2));
  p="${array[m]}";
  while(j>i){
    while [[ 1 ]];do
      ((array[i]<p))&&((i++))||break;
    }
    while [[ 1 ]];do
      ((array[j]>p))&&((j--))||break;
    }
    ((i<=j))&&{
      t="${array[i]}";
      array[i]="${array[j]}";
      array[j]="$t";
      ((i++,j--));
    }
  }
  ((l<j)) && quickSort $l $j;
  ((r>i)) && quickSort $i $r;
}

 実行メソッド

void SortCase(int n){
  setArray(n);
  display();
  case "$2" in
    bubbleSort) 
      printf( "bubbleSort";
      bubbleSort;;
    selectionSort) 
      printf( "selectionSort";
      selectionSort;;
    insertionSort) 
      printf( "insertionSort";
      insertionSort;;
    mergeSort) 
      printf( "mergeSort";
      mergeSort 0 $((nElems-1));;
    shellSort) 
      printf( "shellSort";
      shellSort;;
    quickSort) 
      printf( "quickSort";
      quickSort 0 $((nElems-1));;
  esac
  display;
}
//
void Sort(){
  SortCase( 1000, "bubbleSort");
  SortCase( 1000, "selectionSort)";
  SortCase( 1000, "insertionSort");
  SortCase( 1000, "mergeSort");
  SortCase( 1000, "shellSort");
  SortCase( 1000, "quickSort");
}
//
int main(){
  Sort();
  return 0;
}

