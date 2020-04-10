/**
 クイックソート

 クイックソートは数列を整列するアルゴリズムです。
 他のアルゴリズムに比べ、数の比較と交換回数が少ないのが特徴で、
 多くのケースで高速にソートが出来ます。

 初回の操作の対象は数列の全ての数とします。
 
 3   5   8   1   2   9   4   7   6 

 ソートの基準となる数を１つ選びます。この数の事をpivotと呼びます。
 pivotは通常、１つの数をランダムに選択します。
 今回は便宜上、常に一番右の数をpivotとして選ぶ事にします。
 
 わかりやすいようにpivotにマーカーをおきます。
 3   5   8   1   2   9   4   7  (6)
                                 P

 つづいて、一番左の数に左マーカーL、右の数に右マーカーRを設置します。 
(3)  5   8   1   2   9   4  (7)  6 
 L                           R   P

 クイックソートはこれらのマーカーを使い 一連の操作を再帰的に繰り返すアルゴリズムです。
 それでは、左マーカーを右に動かしていきます。
 3  (5)  8   1   2   9   4   7   6 
     L                       R   P

 【ルール1】左マーカーがpivotの数以上の場合、動きを止めます。
 今回は8>=6なので止まりました。

 ◎ 1.IF L>=P : 止まる
 3   5  (8)  1   2   9   4   7  (6)
         L                   R   P

 つづいて、右マーカーを左に動かしていきます。
 【ルール2】右マーカーはpivotより小さい数にたどり着いた場合動きを止めます。
 今回は4<6なので止まりました。

   1.IF L>=P : 止まる
 ◎ 2.IF R<P  : 止まる
 3   5   8   1   2   9  (4)  7  (6)
         L               R       P

 【ルール3】左右のマーカーが止まったとき、マーカーの数を入れ替えます。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
 ◎ 3.IF L>=P && R<P : L<->R
 3   5  (4)  1   2   9  (8)  7   6 
         L               R       P
 
 このように、左マーカーの役割はpivot以上の数を見つける事、
 右マーカーの役割はpivotより小さな数を見つける事です。
 数を入れ替える事で、数列の左側にpivotより小さな数、
 右側にpivot以上の数を集める事が出来ます。

 入れ替えた後は、再び左マーカーを右に動かしていきます。
 3   5   4  (1)  2   9   8   7   6 
             L           R       P

 3   5   4   1  (2)  9   8   7   6 
                 L       R       P

 9>=6なので止まりました。
 ◎ 1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
 3   5   4   1   2  (9)  8   7  (6)
                     L   R       P

 つづいて、右マーカーを左に動かします。
 3   5   4   1   2  (9)  8   7   6 
                     LR          P

 【ルール4】右マーカーが、左マーカーにぶつかった場合動きを止めます。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
 ◎ 4.IF L|<R  : 止まる
 3   5   4   1   2  (9)  8   7   6 
                     LR          P

  【ルール5】その後、LRとpivotの数を入れ替え、
 3   5   4   1   2  (6)  8   7  (9)
                     LR          P

  【ルール5続き】その後、LRを済みとします。

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
 3   5   4   1   2  (6)  8   7   9
 
 これで初回の操作が完了しました。
 一連の操作によって数列をpivotより左の「pivotより小さな数」と、
 pivotより右の「pivotより大きな数」に分ける事が出来ました。
 ２つに分かれた各数列に対して、一連の操作を再帰的に行っていきます。

 次は、分かれた左側の数列を操作の対象とします。
                     済          
 3   5   4   1   2   6   8   7   9 
 ←               →

 ３つのマーカーを設置します。
                     済          
 3   5   4   1   2   6   8   7   9 
 L           R   P  


 先程と同様の操作を行っていきます。
 すでにLはL>=P なので止まります。
 ◎ 1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<$ : 止まる : LR<->P : LR=済み
                     済          
(3)  5   4   1  (2)  6   8   7   9 
 L           R   P  

 すでにRもR<P なので止まります。
   1.IF L>=P : 止まる
 ◎ 2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
 3   5   4  (1) (2)  6   8   7   9 
 L           R   P 
 
 LとRを入れ替えます
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
 ◎ 3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
(1)  5   4  (3)  2   6   8   7   9 
 L           R   P  
 
 Lを右にずらします。
 LはL>=P なので止まります。
 ◎ 1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
 1  (5)  4   3   2   6   8   7   9 
     L       R   P  
 
 Rを左にずらします。
                     済          
 1   5  (4)  3   2   6   8   7   9 
     L   R       P  
 
 さらにRをひだりにずらすとLとRがぶつかったので止まります。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
 ◎ 4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
 1  (5)  4   3   2   6   8   7   9 
     LR          P  

 LRとPを交換して
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
                     済          
 1  (2)  4   3  (5)  6   8   7   9 
     LR          P  

 LRを済みとします。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
     済              済          
 1  (2)  4   3   5   6   8   7   9 
     

 さらに再帰的に一連の操作を繰り返します。
     済              済          
 1   2   4   3   5   6   8   7   9 
 ↑    

 L、R、Pivotを設置します。

     済              済          
 1   2   4   3   5   6   8   7   9 
LRP    

 【ルール6】対象の数列の数が１つだった場合、ソート済みとします。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
 ◎ 6.L|R|P : LRP=済み
 済  済              済          
 1   2   4   3   5   6   8   7   9 

 つづいて２回目の操作で分かれた右側の数列を操作の対象とします。
 済  済              済          
 1   2   4   3   5   6   8   7   9 
         ←       → 

 ３つのマーカーを設置します。
 済  済              済          
 1   2   4   3   5   6   8   7   9 
         L   R   P

 左マーカーを右に動かしていきます。
 左マーカーは右マーカーとぶつかっても止まりません。その点は右マーカーの動きとは異なります。
 済  済              済          
 1   2   4  (3)  5   6   8   7   9 
             LR  P

 【ルール7】左マーカーはpivotにたどり着いたら止まります。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
 ◎ 7.IF L>|P : 止まる
 済  済              済          
 1   2   4   3  (5)  6   8   7   9 
             R   LP

 次に、右マーカーを動かしますが、左マーカーに追い越されている場合には動かさずに終了し
 済  済              済          
 1   2   4  (3)  5   6   8   7   9 
             R   LP

 【ルール8】左マーカーが、操作対象の右端に達している場合pivotをソート済みとします。
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
 ◎ 8.IF L>|P && LP=済み
 済  済          済  済          
 1   2   4   3  (5)  6   8   7   9 
                 LP
 
 同様の操作を繰り返します。
 済  済          済  済          
 1   2   4   3   5   6   8   7   9 
         ←   →             

 済  済          済  済          
 1   2   4   3   5   6   8   7   9 
         LR  P             

 ◎ 1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済          済  済          
 1   2  (4)  3   5   6   8   7   9 
         LR  P

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
 ◎ 4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済          済  済          
 1   2  (4)  3   5   6   8   7   9 
         LR  P

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済      済  済          
 1   2  (3)  4   5   6   8   7   9 

 済  済  済      済  済          
 1   2   3   4   5   6   8   7   9 
            ←→         

 済  済  済      済  済          
 1   2   3  (4)  5   6   8   7   9 
            LRP

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
 ◎ 6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済          
 1   2   3  (4)  5   6   8   7   9 

 済  済  済  済  済  済          
 1   2   3   4   5   6   8   7   9 
                         ←       →

 済  済  済  済  済  済          
 1   2   3   4   5   6   8   7   9 
                         L   R   P

 済  済  済  済  済  済          
 1   2   3   4   5   6   8   7   9 
                             LR  P

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
 ◎ 7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済          
 1   2   3   4   5   6   8   7   9 
                             R   LP

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
 ◎ 8.IF L>|P && LP=済み
 済  済  済  済  済  済          済
 1   2   3   4   5   6   8   7   9 
                             

 済  済  済  済  済  済          済
 1   2   3   4   5   6   8   7   9 
                         ←   →

 済  済  済  済  済  済          済
 1   2   3   4   5   6   8   7   9 
                        LR   P

 ◎  1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済          済
 1   2   3   4   5   6  (8)  7   9 
                        LR   P
   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
 ◎ 4.IF L|<R : 止まる
   5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済          済
 1   2   3   4   5   6  (8)  7   9 
                         LR   P

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済  済      済
 1   2   3   4   5   6  (7)  8   9 
                         LR   P

 済  済  済  済  済  済  済      済
 1   2   3   4   5   6   7   8   9 
                            ←→                        

 済  済  済  済  済  済  済      済
 1   2   3   4   5   6   7  (8)  9 
                            LRP 

   1.IF L>=P : 止まる
   2.IF R<P  : 止まる
   3.IF L>=P && R<P : L<->R
   4.IF L|<R : 止まる
 ◎ 5.IF L|<R : 止まる : LR<->P : LR=済み
   6.L|R|P : LRP=済み
   7.IF L>|P : 止まる
   8.IF L>|P && LP=済み
 済  済  済  済  済  済  済  済  済
 1   2   3   4   5   6   7  (8)  9 
                            
 
<>quickSort
クイックソート
https://www.youtube.com/watch?v=aQiWF4E8flQ
　平均計算時間が O(n Log n)
　安定ソートではない
　最大計算時間が O(n^2)

データ数が 50 以下なら挿入ソート (Insertion Sort)
データ数が 5 万以下ならマージソート (Merge Sort)
データ数がそれより多いならクイックソート (Quick Sort)

 1. 一般的なクイックソート
 2. ３つのメジアンによる分割と、
    小さな配列の場合はマニュアルソートを取り入れたクイックソート
 3.
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int nElems=0;
int array[MAX];
//
void swap(int dex1,int dex2){
  double tmp=array[dex1];
  array[dex1]=array[dex2];
  array[dex2]=tmp;
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
/*
 3. 【完成版】小さな分割の場合に挿入ソートを行うクイックソート
 クイックソートのような強力なアルゴリズムが、再帰呼び出しの行き着く果てに、わ
 ずか２項目か３項目の小さな配列にも適用されるのは、妙な感じがします。最後の段
 階、いわゆる小さな分割の場合に挿入ソートを行うクイックソート完成版。 
 分割によってできる部分配列がある程度大きい間はクイックソートをして、それ以降
 の小さな部分配列はそのまま放置します。そうすると、配列全体としては、ほとんど
 ソートされた状態になります。その配列全体に対して、今度は挿入ソートを適用しま
 す。挿入ソートはほとんどソートされた状態の配列に対しては高速です。と、何人か
 の専門家は言っていますが、実は挿入ソートは、大きな配列を１つソートするより、
 小さなソートをたくさんするほうが向いているのです。
*/
//
// leftPtr 最初の成分の右
//rightPtr 分割値の左
int partitionIt3(int left,int right,int pivot){
  int leftPtr=left;
  int rightPtr=right-1;
  while(1){
    //より大きい項目を見つける
    while(array[++leftPtr]<pivot){}
    //より小さい項目を見つける
    while(array[--rightPtr]>pivot){}
    //ポインタが交差したら
    if(leftPtr>=rightPtr){
      //分割は終了
      break ;
    }else{
      swap(leftPtr,rightPtr);
    }
  }
  swap(leftPtr,right-1);
  //分割値の位置を返す
  return leftPtr;
}
//
double medianOf3_3(int left,int right){
  int center=(left+right)/2;
  if(array[left]>array[center]){
    swap(left,center);
  }
  if(array[left]>array[right]){
    swap(left,right);
  }
  if(array[center]>array[right]){
    swap(center,right);
  }
  swap(center,right-1);
  //メジアンの値を返す
  return array[right-1];
}
//挿入ソート
void iSort3(int left,int right){
  int in;
  for(int out=left+1;out<=right;out++){
    int tmp=array[out];
    in=out;
    while(in>left&&array[in-1]>=tmp){
      array[in]=array[in-1];
      --in;
    }
    array[in]=tmp;
  } 
}
void recQuickSort3(int left,int right){
  int size=right-left+1;
  //小さければ挿入ソート
  if(size<10){
    iSort3(left,right);
  }else{
    double median=medianOf3_3(left,right);
    //範囲を分割する 戻り値は $partition 
    int partition=partitionIt3(left,right,median);
    //左側をソート
    recQuickSort3(left,partition-1);
    //右側をソート
    recQuickSort3(partition+1,right);
  }
}
/*
 2. ３つのメジアンによる分割と
 要素数が３よりも小さな配列の場合はマニュアルソートを取り入れたクイックソート

 クイックソートの分割値の選び方は、これまでにいろんな方法が提案されています。
 その選び方は簡単でしかも最大や最小の値には決してならないという方法でなければ
 なりません。ランダムに選ぶのは方法としては簡単ですが、すでに見たように必ずし
 も常によい選択になるとは限りません。では全ての項目の値を調べて、そのメジアン
 をとるというのはどうでしょう？この方法は分割値の決め方としては理想的でもしか
 し、ソートそのものよりも多くの時間を要してしまいますから実用的ではありません。
 そこで妥協案として考えられたのが、配列の最初の項目、最後の項目、そして中央の
 項目の中央の値を分割値とする方法を、３つのメジアンと言います。
 さらに成分が３よりも少ない小さな配列をソートするmanualSort()を実装しています。
 このメソッドは、部分配列が１セル以下なら直ちにリターン、２セルなら必要な入れ
 替えを行い、３セルならソートをします。３のメジアン法は、配列が４成分以上でな
 いと使えませんから、３成分以下の配列に対しては今回のrecQuickSort()では使えな
 いのです。
*/
int partitionIt2(int left,int right,int pivot){
  int leftPtr=left; 
  int rightPtr=right-1;
  while(1){
    //より大きい項目を見つける
    while(array[++leftPtr]<pivot){}
    //より小さい項目を見つける
    while(array[--rightPtr]>pivot){}
    //ポインタが交差したら
    if(leftPtr>=rightPtr){
      break ;
    }else{
      swap(leftPtr,rightPtr);
    }
  }
  swap(leftPtr,right-1);
  return leftPtr;
}
//
void manualSort(int left,int right){
  int size=right-left+1; 
  if(size<=1){
    // ソート不要
    return ;
  }
  if(size==2){
    //２のソート leftとrightを入れ替える
    if(array[left]>array[right]){
      swap(left,right);
    }
    return ;
  }else{ //サイズが３
    //３のソート,left, center, (right-1) & right
    if(array[left]>array[right-1]){
      swap(left,right-1);
    }
    // left / right
    if(array[left]>array[right]){
      swap(left,right);
    }
    // center / right
    if(array[right-1]>array[right]){
      swap(right-1,right);
    }
  }
}
//
double medianOf3_2(int left,int right){
  int center=(left+right)/2;
  if(array[left]>array[center]){
    swap(left,center);
  }
  if(array[left]>array[right]){
    swap(left,right);
  }
  if(array[center]>array[right]){
    swap(center,right);
  }
  swap(center,right-1);
  // メジアンの値を返す
  return array[right-1];
}
//
void recQuickSort2(int left,int right){
  int size=right-left+1;
  if(size<=3){
    //小さければマニュアルソート
    manualSort(left,right);
  }else{
    double median=medianOf3_2(left,right);
    //範囲を分割する 戻り値は $partition 
    int partition=partitionIt2(left,right,median);
    //左側をソート
    recQuickSort2(left,partition-1);
    //右側をソート
    recQuickSort2(partition+1,right); 
  }
}

// 普通のクイックソート
int partitionIt1(int left,int right,int pivot){
  //最初の成分の右
  int leftPtr=left-1;
  int rightPtr=right;
  while(1){
    //より大きい項目を見つける
    while(array[++leftPtr]<pivot){}
    //より小さい項目を見つける
    while(rightPtr>0 && array[--rightPtr]>pivot){}
    //ポインタが交差したら
    if(leftPtr>=rightPtr){
      //分割は終了
      break ;
    }else{
      swap(leftPtr,rightPtr);
    }
  }
  swap(leftPtr,right);
  //分割値の位置を返す
  return leftPtr;
}
//
void recQuickSort1(int left,int right){
  if(right-left<=0){
    return;
  }else{
    double pivot=array[right];
    int partition=partitionIt1(left,right,pivot);
    //範囲を分割する 戻り値は $partition 
    partitionIt1(left,right,array[right]);
    //左側をソート
    recQuickSort1(left,partition-1);
    //右側をソート
    recQuickSort1(partition+1,right);
  }
}
//
void quickSort3(int n){
  setArray(n);
  display() ;
  recQuickSort3(0,nElems-1);
  display() ;
}
//
void quickSort2(int n){
  setArray(n);
  display() ;
  recQuickSort2(0,nElems-1);
  display() ;
}
//
void quickSort1(int n){
  setArray(n);
  display() ;
  recQuickSort1(0,nElems-1);
  display() ;
}
//
int main(){
//  quickSort1(100);
//  quickSort2(100);
  quickSort3(100);
  return 0;
}

