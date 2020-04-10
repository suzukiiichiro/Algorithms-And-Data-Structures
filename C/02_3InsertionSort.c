/**
 挿入ソート

 挿入ソートは数列を整列するアルゴリズムの一つです。
 最初に、左端の数字を操作済みにします。

 済
 5   3   4   7   2   8   6   9   1
 
 つづいてまだ操作していないものの中で左端の数字を取り出し、
 左端の操作済みになっている数字と比較します。
 もし左の数字のほうが大きい場合、二つの数字を入れ替えます。

 済  ↓
 5   3   4   7   2   8   6   9   1
 
 この操作を自分より小さい数字が現れるか、数字が左端に到達するまで繰り返します。
 この場合、５＜３なので数字を入れ替えます。
 ← →
 3   5   4   7   2   8   6   9   1
 
 数字が左端に到達したので止まり、数字を操作済みにします。

 済　済
 3   5   4   7   2   8   6   9   1
 
 同様に左端の数字を取り出し

 済　済  ↓
 3   5   4   7   2   8   6   9   1

 左の数字と比較します。 
 済　済  ↓
 3   5   4   7   2   8   6   9   1

 5 < 4 なので数字を入れ替えます。

 済　↓   済
 3   4   5   7   2   8   6   9   1

 ３＜４でじぶんより小さい数字が現れたので交換せずに止まり、
 数字を交換済みとして、比較を右に一つ移動します。

 済  済  済  ↓
 3   4   5   7   2   8   6   9   1

 同様の操作を、全ての数字が操作済みになるまで繰り返します。

 済　済  済  済  ↓
 3   4   5   7   2   8   6   9   1

 済　済  済  済  済  ↓
 2   3   4   5   7   8   6   9   1

 済　済  済  済  済  済  ↓
 2   3   4   5   7   8   6   9   1

 済　済  済  済  済  済  済  ↓
 2   3   4   5   6   7   8   9   1

 済　済  済  済  済  済  済  済  ↓
 2   3   4   5   6   7   8   9   1

 済　済  済  済  済  済  済  済  済
 1   2   3   4   5   6   7   8   9


<> insertion Sort
挿入ソート
https://www.youtube.com/watch?v=DFG-XuyPYUQ
　平均計算時間が O(ｎ^2)
　安定ソート
　比較回数は「　n(n-1)/2以下　」
　交換回数は「　約n^2/2以下　」
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAX 10
//
int array[MAX];
int nElems=0;
//
void insertionSort(){
  int tmp;
  int in;
  for(int out=1;out<nElems;out++){
    tmp=array[out];
    for(in=out;in>0&&array[in-1]>tmp;in--){
      array[in]=array[in-1];
    }
    array[in]=tmp;
  }
}
//
void selectionSort(){
  int tmp;
  for(int i=0;i<nElems;i++){
    int min=i;
    for(int j=i+1;j<nElems;j++){
      if(array[min]>array[j]){
        min=j;
      }
    }
    tmp=array[min];
    array[min]=array[i];
    array[i]=tmp;
  }
}
//
void bubbleSort(){
  int tmp;
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
//
void display(){
  for(int i=0;i<nElems;i++){
    printf("%d %d\n",i,array[i]);
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
//
void execSort(int n){
  setArray(n);
  display();
  // bubbleSort();
  // selectionSort();
  insertionSort();
  display();
}
//
int main(){
  execSort(10);
  return 0;
}
