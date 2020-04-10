/**
 マージソート
 
 マージソートは数字列を整列するアルゴリズムの１つです。
 
 6   4   3   7   5   1   2

 始めに数列を半分ずつに分割していきます。

 6   4   3   7    |  5   1   2

         ↓               ↓
 6   4  |  3   7  |  5   1  |  2

         ↓               ↓
  6 | 4 |  3 | 7  |  5 | 1  |  2

 分割が完了したら、分割して出来高くグループを合体していきます。
 合体するときは、合体後のグループ内で数字が小さい順に並ぶように小さい数字から順に移動します。
 
  6 | 4 |  3 | 7  |  5 | 1  |  2
    ↓        ↓        
  4   6 |  3   7  |  5   1  |  2

 複数の数字を含むグループを合体する場合、先頭の数を比較し、小さい方の数を移動します。

  4   6 |  3   7  |  5   1  |  2

 この場合は、４と３を比較します。同容易残った列の先頭の数を比較し、4<7なので4を移動します。

  4   6 |  3   7  |  5   1  |  2
    ↓        ↓
  3   4           |  5   1  |  2

 6<7なので6を移動します。

  3   4    6      |  5   1  |  2

 残った７を移動します。

  3   4    6   7  |  5   1  |  2

 グループの合体の操作は、全ての数が１つのグループになるまで再帰的に繰り返します。

  3   4    6   7  |  5   1  |  2
                       ↓       ↓
  3   4    6   7  |  1   5  |  2
                       ↓       ↓
  3   4    6   7  |  1   2     5
                ↓
  1   2    3   4     5   6     7

 合体が完了し、数列がソートされました。


 バブルソート、挿入ソート、選択ソートがO(N^2)の時間を要するのに対し、
 マージソートはO(N*logN)です。
 例えば、N(ソートする項目の数）が10,000ですと、N^2は100,000,000ですが、
 n*logNは40,000です。別の言い方をすると、マージソートで４０秒を要するソートは、
 挿入ソートでは約２８時間かかります。
 マージソートの欠点は、ソートする配列と同サイズの配列をもう一つ必要とする事です。
 元の配列がかろうじてメモリに治まるという大きさだったら、マージソートは使えません。
 
  https://www.youtube.com/watch?v=EeQ8pwjQxTM
　平均計算時間が O(n Log n)
　安定ソートです。

 コメント
 50以下挿入ソート、5万以下マージソート、あとはクイックソート
*/
//
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int array[MAX];
int workArray[MAX];
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
  srand((unsigned int)time(NULL));
  for(int i=0;i<n;i++){
    insert(rand()%n+1);
  }
}
//
//lowPtr : 下半分の部分配列が始まる位置
//highPtr : 上半分の部分配列が始まる位置
//upperBound : 上半分の配列の上限位置
void mergeSortLogic(int lowPtr,int highPtr,int upperBound){
  //作業スペースのインデクス
  int j=0; 
  //下半分の配列の上限位置
  int _lowerBound=lowPtr ;
  int _mid=highPtr-1;
  //項目の数
  int n=upperBound-_lowerBound+1;
  //マージする列が２つある場合
  while(lowPtr<=_mid&&highPtr<=upperBound){
    //小さい値をコピー
    if(array[lowPtr]<array[highPtr]){
      workArray[j]=array[lowPtr++];
      j++;
    }else{
      workArray[j]=array[highPtr++];
      j++ ;
    }
  }
  //前半分のリスト
  while(lowPtr<=_mid){
    //前半分の要素をそのまま作業用配列にコピー
    workArray[j]=array[lowPtr++];
    j++ ;
  }
  //後半分のリスト
  while(highPtr<=upperBound){
    //後半分の要素を逆順に作業用配列にコピー
    workArray[j]=array[highPtr++];
    j++ ;
  }
  //昇順に整列するよう１つのリストにまとめる
  //作業用配列の両端から取り出したデータをマージして配列に入れる
  for(int j=0;j<n;j++){
    array[_lowerBound+j]=workArray[j];
  }
}
//
void mergeSort(int lowerBound,int upperBound){
  //範囲が１なら再帰呼び出しの終了 基底条件
  if(lowerBound==upperBound){
    return ;
    //ソートは不要
  }else{
    //列を２つに分割する中間点を見つける
    int mid=(lowerBound+upperBound)/2;
    //前半分をソート
    mergeSort(lowerBound,mid);
    //後半分をソート
    mergeSort(mid+1,upperBound);
    //両者をマージ
    mergeSortLogic(lowerBound,mid+1,upperBound);
  }
}
//
void execSort(int n){
  setArray(n);
  display();
  mergeSort(0,nElems-1);
  display();
}
//
int main(){
  execSort (10);
  return 0;
}
