/**
 選択ソート

 選択ソートは数列を整列するアルゴリズムの一つです。
 数列を線形探索し、最小値を探します。
 探索した最小値を、ソート済みではない列の左端の数と交換し、ソート済みにします。
 なお、最小値がすでに左端であった場合には、何の操作も行いません。
 同様の操作を全ての数字にソート済みになるまで繰り返します。

 5   9   3   1   2   8   4   7   6
 min 
 
     ↓
 5   9   3   1   2   8   4   7   6
 min 
 
         ↓
 5   9   3   1   2   8   4   7   6
        min 

             ↓
 5   9   3   1   2   8   4   7   6
            min 

                 ↓
 5   9   3   1   2   8   4   7   6
            min 

                     ↓
 5   9   3   1   2   8   4   7   6
            min 

                                 ↓
 5   9   3   1   2   8   4   7   6
            min 

 一番目の５とminの１を入れ替える
 1   9   3   5   2   8   4   7   6
   

 一番目を済みにしてminを一つ右へずらす
 1   9   3   5   2   8   4   7   6
 済 min 

 一番左端は配置済みなので探索の必要はない。
 右へ探索し最小値を探す      

     ↓
 1   9   3   5   2   8   4   7   6
 済 min 

         ↓
 1   9   3   5   2   8   4   7   6
 済     min 

             ↓
 1   9   3   5   2   8   4   7   6
 済     min 

                 ↓
 1   9   3   5   2   8   4   7   6
 済             min 

                     ↓
 1   9   3   5   2   8   4   7   6
 済             min 

 
 探索が右端まで到達したらソート済みではない左端の数値のminを交換します。
                                 ↓
 1   9   3   5   2   8   4   7   6
 済             min 

         ↓
 1   2   3   5   9   8   4   7   6
 済  済 min  

 同様の操作を、全ての数字がソート済みになるまで繰り返します。
 
 
 選択ソート
https://www.youtube.com/watch?v=f8hXR_Hvybo
　平均計算時間が O(ｎ^2)
　安定ソートではない
　比較回数は「　n(n-1)/2　」
　交換回数は「　n-1　」

 外側outは右側端nElems-1から左へ移動
 内側 inは左側0から右へinを移動。
 maxよりinが大きかったらinの値をmaxへ
 ターン終了後にoutとmaxを[必ず]入れ替え
 一番右側列からソート済み

 bubbleSort 比較 O(N2乗) 入れ替え O(N2乗) 
 selectSort 比較 O(N2乗) 入れ替え O(N) 
 入れ替え回数が少ない分bubbleSortよりも高速
 入れ替えに要する時間が比較の時間より相当大きい時にはその差も大きい
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAX 10
//
int array[MAX];
int nElems=0;
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
  selectionSort();
  display();
}
//
int main(){
  execSort(10);
  return 0;
}
