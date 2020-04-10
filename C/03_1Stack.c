/**
 stack (push/pop)

 スタックはデータ構造の一つです。
 スタックの仕組みは、ものを縦に積み上げる事を考えるとイメージしやすいです。
 積み上げられた山からものを取り出す場合、上から順番に取り出す事になります。
 スタックにデータを追加する場合、データは一番最後に追加されます。
 スタックにデータを追加する操作をpushと呼びます。
 スタックからデータを取り出す場合、最も新しく追加されたデータから取り出されます。
 スタックからデータを取り出す操作をpopと呼びます。
 このような、後から入れたものを先に出す「後入れ先出し」の仕組みを
 「Last In First Out 」を略してLIFOと呼びます。
 
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//
#define MAX 10
int array[MAX];
int nElems=0;
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
void stackPeek(char* peek){
  printf("%s : %d:%d\n",peek,nElems,array[nElems]);
  display();
}
//
void stackPush(int n){
  srand((unsigned int)time(NULL)); 
  array[nElems]=rand()%n+1;
  printf("pushします : %d:%d\n",nElems,array[nElems]);
  nElems++;
  display();
}
//
void stackPop(){
  if(nElems!=0){
    nElems--;
    stackPeek("popします");
  }else{
    printf("Stack is empty\n\n");
  }
}
//
void stack(){
  printf("display()\n");
  display();
  stackPop();
  stackPush(10);
  stackPush(10);
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop();
  stackPop(); 
}
//
void execStack(int n){
 setArray(n);
 stack();
}
//
int main(){
  execStack(10);
  return 0;
}
