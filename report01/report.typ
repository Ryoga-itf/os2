#import "/template.typ": *
#import "@preview/codelst:2.0.2": *

#show: project.with(
  week: 1,
  date: datetime(year: 2026, month: 1, day: 15)
)

== 問題(101) システム・コールとライブラリ関数の相違点

システム・コールとライブラリ関数は共にC言語でプログラムを書く時にはAPIとなる。
システム・コールとライブラリ関数の相違点を3つ示しなさい。

=== 解答

- システム・コールはカーネル（システム）のプログラムを直接的に利用するが、ライブラリはカーネルの機能を直接的には使わない。
- システム・コールはプロセスの外に働きかけるが、ライブラリは（システム・コールの助けなしでは）メモリの内容を書き換えるだけである。
- システム・コールは実装で特権命令が使えるが、ライブラリは実装で特権命令が使えない。

== 問題(102) stat() システムコールの引数と結果

stat() システム・コールのマニュアルには、次のような記述がある。

#sourcecode[```
STAT(2)                    Linux Programmer's Manual                   STAT(2)

NAME
       stat, fstat, lstat, fstatat - get file status

SYNOPSIS
       #include <sys/types.h>
       #include <sys/stat.h>
       #include <unistd.h>

       int stat(const char *pathname, struct stat *statbuf);
...
DESCRIPTION
       These  functions return information about a file, in the buffer pointed
       to by statbuf.  No permissions are required on the file itself,  but--in
       the  case of stat(), fstatat(), and lstat()--execute (search) permission
       is required on all of the directories in  pathname  that  lead  to  the
       file.
...
RETURN VALUE
       On success, zero is returned.  On error, -1 is returned, and  errno  is
       set appropriately.
```]

このシステム・コールを処理する関数がカーネルの中でどのように定義されているか、その概略(引数と結果の宣言)を示しなさい。
関数の内容は空で解答しなさい。マクロを利用しても利用しなくてもどちらでもよい。実際のコードとは関係なく、今日の授業の範囲で回答しなさい。

#sourcecode[```
引数と結果の宣言
{
   /*内容省略*/
}
```]

=== 解答

#sourcecode[```
引数と結果の宣言
{
   /*内容省略*/
}
```]

== 問題(103) Ready 状態のプロセス

オペレーティング・システムでは、「一般に」プロセスは、実行待ち(Ready)、実行中(Running)、待機中(Waiting、Blocked)という３つの状態を持つ。
Linux において、プロセスが Ready 状態であることを示すために、task struct のフィールド state に、何という値を設定しているか。

== 問題(104) fork() システム・コール

今日の授業資料の中から fork() システムコールの実装で task_struct をコピーするために呼び出される関数を3つ選び、答えなさい。
その中で単純にその構造体をコピーしているものを選びなさい。

== 問題(105) getgid システム・コール

getgid() (Get Group ID) システム・コールを実装の概略を、今日の授業の範囲内で答えなさい。
利用する重要な変数、マクロ、構造体を列挙しなさい。そして、どのようにポインタをたどっていくかを示しなさい。
概略を記述するためには、簡易的な C 言語、日本語、または、英語を使いなさい。
なお、実際の getgid() システム・コールの実装は、名前空間の導入により複雑になっており、今日の授業の範囲を超えている。
この課題では、実際のコードではなく、この授業の範囲内で答えなさい。（実際のコードをそのまま回答しても、得点を与えない。）
