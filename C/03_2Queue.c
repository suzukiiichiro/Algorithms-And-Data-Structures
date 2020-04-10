/**
 Queue
 
 キューはデータ構造の一つです。
 キューは待ち行列とも呼ばれ、その名の通り行列に並ぶ事を考えるとイメージしやすいです。
 行列においては、先に並んだ人ほど優先されます。 
 キューにデータを追加する場合、データは一番最後に追加されます。
 キューにデータを追加する操作をenqueueと呼びます。
 キューからデータを取り出す場合、最も古くに追加されたデータから取り出されます。
 キューからデータを取り出す操作をdequeueと呼びます。
 このような、先に入れたものを先に出す先入れ先出しの仕組みを
 「First In First Out」を略してFIFOと呼びます。
*/ 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int array[MAX];
int nElems=10;
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
int front;
int rear;
int queue[MAX];
void queueDisplay(){
  for(int i=front;i<rear;i++){
      printf("%d : %d\n",i,queue[i]);
  }
  printf("------");
}
//
void dequeue(){
  front++;
}
//
void enqueue(int n){
  queue[rear++]=n;
}
//
void peek(){
  printf("peek : %d : %d\n",front,queue[front]);
}
//
void execQueue(){
  rear=0;   //後ろ端（enqueueされるほう）
  front=0;  //前端（peek/dequeueされるほう)
  enqueue(10);
  enqueue(20);
  enqueue(30);
  enqueue(40);
  printf("データを4つenqueue\n");
  peek();
  queueDisplay();
  printf("----\n");
  dequeue();
  dequeue();
  printf("データを2つdequeue\n");
  peek();
  queueDisplay();
  printf("----\n");
  enqueue(50);
  printf("データを1つenqueue");
  peek();
  queueDisplay();
  printf("----\n");
}
//
int main(){
  execQueue();
  return 0;
}
