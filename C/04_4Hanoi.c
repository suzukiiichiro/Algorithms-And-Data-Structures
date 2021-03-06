/**
 再帰-ハノイの塔

 実際に動いて試してみよう
 $bash 04_5Hanoi.sh 3

 ５枚の場合
 $bash 04_5Hanoi.sh 5


 古代インドの神話では、遠い秘境のお寺で僧侶達が毎日毎晩、
 ６４枚の黄金の円盤をダイヤモンドをちりばめた３つの塔の間で移し替え作業をしている。
 その移し替え作業が完了したら世界の終末が訪れるのだそうだ。

 http://www13.plala.or.jp/kymats/study/C++/Hanoi/Hanoi.html
 多くの有用なアルゴリズムは再帰的な構造をもっている。すなわち、
 与えられた問題を、その問題に関連した幾つかの部分問題を解くことによって解く。
 このようなアルゴリズムを、分割統治法と呼ぶ。
 (問題は、サイズが小さいほうが簡単に解けることが多いことに注意。)
 再帰によるバイナリサーチは分割統治方式の典型です。
 大きな問題を２つの小さな問題に分割して、それぞれを別々に解きます。
 そのそれぞれの小さな問題の解き方も、やはり同じです。つまりもっと小さな２つの問題に分割して、そのそれぞれを解きます。
 この分割課程が、基底条件に達するまで続きます。基底条件に達したら問題はそれ以上分割する必要なくその場で容易に解けます。

 分割統治法は次の3ステップからなります。

(分割 Divide) 与えられた大きなサイズの問題を、幾つかの部分問題に分割する。
(統治 Conquer) これらの部分問題のそれぞれを再帰的に解く。
(結合 Combine) 求められた部分問題の解から、元の問題の解を求める。

 分割統治方式を実装する再帰メソッドには、通常、自分自身を呼び出す再帰呼び出しが２つあります。
 それぞれ問題の上半分と下半分に対して自分を呼び出すのです。
 
 n枚の円盤すべてを移動させるには最低 2^n - 1 回の手数がかかる。
 ６４枚の円盤すべてを移動させるには、
 最低でも（264-1）回 = 18,446,744,073,709,551,615（1844京6744兆737億955万1615）回かかり、
 1枚移動させるのに1秒かかったとすると、最低でも約5,845億年かかる
 （なお、ビッグバンは今から約137億年前に発生したとされている）。
ハノイの塔の問題に対する再帰的な分割統治アルゴリズムによって得られる解は２のｎ乗-1回の移動からなる。

 n^2-1
 n=3
 2x2x2-1=7

 wiki pedia
 https://ja.wikipedia.org/wiki/ハノイの塔

bash-3.2$ gcc 04_4Hanoi.c  && ./a.out
move 65->67
move 65->66
move 67->66
move 65->67
move 66->65
move 66->67
move 65->67
 
*/
#include <stdio.h>
#include <stdlib.h>
//
int Moves=0;
char from;
char work;
char dest;
//
void Hanoi(int n,char from,char work,char dest) {
  if(n==1){
    printf("move %c->%c\n",from,dest);         
  }else{
    Hanoi(n-1,from,dest,work); 
    printf("move %c->%c\n",from,dest);         
    Hanoi(n-1,work,from,dest); 
  }
  Moves++;
}
//
void execHanoi(int n){
  //第二引数から第四引数へ n 枚の円盤を移動
  Hanoi(n,'A','B','C');
  printf("Total moves = %d\n",Moves);
}
//
int main(){
  execHanoi(3) ;
  return 0;
}
