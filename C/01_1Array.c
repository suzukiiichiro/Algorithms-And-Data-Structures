/**
 00 配列
 配列はデータ構造の一つで、複数の値を格納する事が出来ます。
 各要素には添え字（データの何番目かを表す数字）でアクセスできます。
 データはメモリーの連続した領域に、順番通りに格納されます。
 連続した領域に格納されているので、メモリアドレスが添え字を使って計算でき、各データにランダムアクセスが出来ます。
 また、配列の特徴として、任意の場所へのデータの追加・削除の操作がリストに比べてコストが高いです。
 
 a[0]   a[1]   a[2]
 blue   yellow red

 green

 greenを２番目に追加する事を考えます。
 まず配列の最後に追加する空間を確保します。
 
 a[0]   a[1]   a[2]  a[3]
 blue   yellow red   

 追加される空間を空けるため、一つずつデータをずらします。
 
 a[0]   a[1]   a[2]  a[3]
 blue   yellow       red   

        ↓
 a[0]   a[1]   a[2]   a[3]
 blue          yellow red   

        ↓
 空いた空間にgreenを追加して追加の操作が完了します。

 a[0]   a[1]   a[2]   a[3]
 blue   green  yellow red   

 逆に２番目の要素を削除するときは、
 まず２番目の要素を削除し、

 a[0]   a[1]   a[2]   a[3]
 blue          yellow red   

        ↓
 空いた空間にデータを一つずらして埋めます。
 a[0]   a[1]   a[2]   a[3]
 blue   yellow        red   

        ↓
 a[0]   a[1]   a[2]   a[3]
 blue   yellow red   

        ↓
 最後に余った空間を削除して削除の操作が完了します。
 a[0]   a[1]   a[2]
 blue   yellow red   

 こうした追加・削除の操作は以降のソートの処理で学びますので、ここではデータ配列を生成する処理を覚えます。
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
  // 現在時刻の情報で初期化
  srand((unsigned int)time(NULL)); 
  for(int i=0;i<n;i++){
      insert(rand()%n+1);
  }
}
//
void execArray(int n){
  setArray(n);
  display();
}
//
int main(){
  execArray(10);
  return 0;
}
