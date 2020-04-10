/**
 円環キュー Circular Queue

 映画館の待ち行列なら、先頭の一人が列を去ったら、列全体が前に進みます。
 キューでも、削除のたびに全ての項目を移動する事は出来ますが、しかしその時間が無駄です。
 むしろ項目はそのままにしておいて、キューの前端や後端が動いた方が簡単なのです。
 しかしその場合の問題は、キューの後端がすぐに配列の終端に達してしまいます。
 まだ満杯ではないのに新たなデータを挿入できないというこの問題を解決するために、
 キューのfrontとrear矢印は配列の先頭へラップアラウンド（最初に戻る）します。
 その結果として円環キューというものができあがります。リングバッファとも呼ばれます。
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int queue[MAX];
int array[MAX];
int nElems=10;
int maxSize=5;
int front;
int rear;
//
void display(){
  for(int n=0;n<nElems;n++){
    printf("%d %d\n",n,array[n]);
  }
  printf("------\n");
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
void CircularQDisplay(){
  for(int i=0;i<maxSize;i++){
      printf("%d : %d\n",i,queue[i]);
  }
  printf("------\n");
}
//
void CircularQDequeue(){
  front++;
  if(front==maxSize){
    front=0;
  }
}
//
void CircularQEnqueue(int n){
  if(rear==(maxSize-1)){
    rear=-1;
  }
  queue[++rear]=n;
}
//
void CircularQPeek(){
  printf("peek :front:%d rear:%d\npeek :queue[%d]=%d\n",front,rear,front,queue[front]);
}
//
void execCircularQ(){
  rear=-1; //後ろ端（enqueueされるほう）
  front=0; //前端（peek/dequeueされるほう)
  CircularQEnqueue(10);
  CircularQEnqueue(20);
  CircularQEnqueue(30);
  CircularQEnqueue(40);
  printf("データを4つenqueue\n");
  CircularQPeek();
  CircularQDisplay();
  //----
  CircularQDequeue();
  CircularQDequeue();
  printf("データを2つdequeue\n");
  CircularQPeek();
  CircularQDisplay();
  //----
  CircularQEnqueue(50);
  printf("データを1つenqueue\n");
  CircularQPeek();
  CircularQDisplay();
  //----
  CircularQEnqueue(60);
  CircularQEnqueue(70);
  printf("データを2つenqueue\n");
  CircularQPeek();
  CircularQDisplay();
  CircularQDequeue();
  CircularQDequeue();
  CircularQDequeue();
  printf("データを3つdequeue\n");
  CircularQPeek();
  CircularQDisplay();
}
//
int main(){
  execCircularQ();
  return 0;
}
