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

== 問題(102) `stat()` システムコールの引数と結果

`stat()` システム・コールのマニュアルには、次のような記述がある。

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

=== 解答

#sourcecode[```c
SYSCALL_DEFINE2(stat, const char *pathname, struct stat *statbuf)
{
   /*内容省略*/
}
```]

== 問題(103) Ready 状態のプロセス

オペレーティング・システムでは、「一般に」プロセスは、実行待ち (Ready)、実行中 (Running)、待機中 (Waiting、Blocked)という３つの状態を持つ。
Linux において、プロセスが Ready 状態であることを示すために、`task struct` のフィールド `state` に、何という値を設定しているか。

=== 解答

`TASK_RUNNING`（これは ```c #define TASK_RUNNING 0x00000000``` と定義されている）という値を設定している。

== 問題(104) fork() システム・コール

今日の授業資料の中から `fork()` システムコールの実装で `task_struct` をコピーするために呼び出される関数を3つ選び、答えなさい。
その中で単純にその構造体をコピーしているものを選びなさい。

=== 解答

`fork()` システムコールの実装で `task_struct` をコピーするために呼び出される関数は以下の通り：

- `copy_process()`
- `dup_task_struct()`
- `arch_dup_task_struct()`

また、その中で単純にその構造体をコピーしているものは `arch_dup_task_struct()` である。

== 問題(105) getgid システム・コール

`getgid()` (Get Group ID) システム・コールを実装の概略を、今日の授業の範囲内で答えなさい。
利用する重要な変数、マクロ、構造体を列挙しなさい。そして、どのようにポインタをたどっていくかを示しなさい。
概略を記述するためには、簡易的な C 言語、日本語、または、英語を使いなさい。
なお、実際の `getgid()` システム・コールの実装は、名前空間の導入により複雑になっており、今日の授業の範囲を超えている。
この課題では、実際のコードではなく、この授業の範囲内で答えなさい。（実際のコードをそのまま回答しても、得点を与えない。）

=== 解答

利用する重要な変数や構造体として

- `current` 変数
- `cred` 構造体

がある。
また `current->cred->gid` のようにポインタを辿っていくと Group ID が取れる。

「struct cred」の節によると、`cred` 構造体の定義は以下の通りである。

#sourcecode[```
linux-6.18.2/include/linux/cred.h
 111:	struct cred {
...
 113:	        kuid_t          uid;            /* real UID of the task */
 114:	        kgid_t          gid;            /* real GID of the task */
...
 141:	        struct group_info *group_info;  /* supplementary groups for euid/fsgid */
...
 147:	} __randomize_layout;

linux-6.18.2/include/linux/uidgid_types.h
  11:	typedef struct {
  12:	        gid_t val;
  13:	} kgid_t;

linux-6.18.2/include/linux/types.h
  38:	typedef __kernel_gid32_t        gid_t;

linux-6.18.2/include/uapi/asm-generic/posix_types.h
  50:	typedef unsigned int    __kernel_gid32_t;
```]

つまり、`cred` 内の `gid` は `kgid_t` 型として管理される。

「getuid()システム・コール」の節にあるコードを参考にすると（この箇所のコード内に gid 周りのコードもある）、
`getgid()` システム・コールの実装では、`getuid()` システム・コールの実装と似たような流れで以下のように展開されると考えられる。

- `current_gid()`
- `current_cred_xxx(gid)`
- `current_cred()->gid`
- `rcu_dereference_protected(current->cred, 1)->gid`

まとめると、`getgid()` システム・コールは、（名前空間が無効なら）次のようなコードと同じであるだろう。

#sourcecode[```
SYSCALL_DEFINE0(getgid)
{
	kgid_t kgid;
	gid_t gid;
	kgid = current->cred->gid;
	gid = kgid.val;
	return gid;
}
```]
