/**

 Shell Sort


 シェルソートは挿入ソートの改良版です。
 挿入ソートの途中では、マーカーの左側の項目は内部的に（それらだけの間で）ソートされていて、
 マーカーの右側はまだ手つかずです。
 アルゴリズムは、マーカーの項目を取り去り、それを一時変数に保存します。
 次に、そうやって空になったセルの左隣から、
 ソート済みの項目を次々と右へシフトしていき（つまり空のセルを次々と左へ移動して）、
 一時変数に保存した項目が正しく納められる場所を作り出します。
 しかし、この点に挿入ソートの問題があります。
 仮に最大の項目がおさまるべき最も右端に小さな項目があったらどうなるでしょうか？
 その小さな項目を、左側の正しい場所に納めるためには、
 それより大きい全ての項目をいちいち右へシフトしなければなりません。
 これは、極端な場合にはほとんどＮ回のコピーになります。
 たった１個の項目のためにＮ回ですよ。
 もちろん全ての項目がＮ回のコピーを必要とするわけではありませんから、
 平均すると１項目につきN/2回のコピー、それに項目数Ｎをかけますと、N^2/2回のコピーとなります。
 従って挿入ソートの実効性能はＯ（Ｎ＾２）です。
 
 小さな項目を左へ移すとき、挿入ソートのようにその間の項目を全て右へシフトするのではなくて、
 その小さな項目だけを一挙に左に移す方法があれば、
 ソートの実効性能はかなり良くなるのではないでしょうか。
 
 シェルソートは大きな歩幅で飛び飛びに「挿入ソート」をすることによって、このような一挙移動を実現します。
 大きな歩幅によるソートが終わったら、今度はその最初の歩幅の間に並んでいる項目を、より狭い歩幅でソートが出来ます。
 配列を歩幅４でソートしたら、今度はそれを歩幅１でソートします。
 つまり通常の挿入ソートをします。
 この歩幅４と歩幅１の組み合わせは、最初から歩幅１だけでソートを行う通常の挿入ソートに比べると相当に早いのです。

 歩幅は伝統的にhで表しインターバル数列といいます。
 アルゴリズムの大家Knuthは最良のインターバル数列を求める公式は以下の通りです。

 h=(h-1)/3

<> Shell Sort
シェルソート
https://www.youtube.com/watch?v=M9YCh-ZeC7Y
　平均計算時間が O(ｎ^1.25)
　安定ソートではない
　挿入ソート改造版
　３倍して１を足すという処理を要素を超えるまで行う
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int nElems=0;
int array[MAX];
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
  for(int i=0; i<n; i++){
    insert(rand()%n+1);
  }
}
//
void shell(){
  //hの初期値
  int interval=1;
  int tmp;
  int inner;
  while(interval<=nElems/3){
    interval=interval*3+1;  //(1,4,13,40,121.....)
  }
  //h=1になるまでhを減らす
  while(interval>0){
    //hでソート
    for(int outer=interval;outer<nElems;outer++){
      tmp=array[outer];
      inner=outer;
      //１つの部分的パス(0,4,8)
      while(inner>interval-1&&array[inner-interval]>=tmp){
        array[inner]=array[inner-interval];
        inner=inner-interval;
      }
      array[inner]=tmp;
    }
    interval=(interval-1)/3;
  }
}
//
void shellSort(int n){
    setArray(n);
    display();
    shell();
    display();
}
//
int main(){
  shellSort(100);
  return 0;
}
