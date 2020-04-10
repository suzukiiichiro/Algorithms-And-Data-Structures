/**
 再帰-階乗値

 3人の順序の種類は
 3 * 2 * 1 で求められる = 6通り

 5人の順序の種類は
 5 * 4 * 3 * 2 * 1 で求められる = 120通り

 5の階乗は 5! と表現する

 10の階乗を求める場合 
 10! = 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 1 = ?

 階乗を求めるメソッドfactorialは、行うべき処理を実現するために、
 メソッドfactorialを呼び出します。このようなメソッド呼び出しを再帰呼び出しと言います。
*/ 
#include <stdio.h>
//
int factorial(int n){
  if(n==1){
    return 1;
  }else{
    //再帰
    return n * factorial(n-1);
  }
}
//
int main(){
  printf("%d\n",factorial(10));
  return 0;
}
