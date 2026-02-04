#import "/template.typ": *
#import "@preview/codelst:2.0.2": *

#show: project.with(
  week: 4,
  date: datetime(year: 2026, month: 2, day: 4)
)

== 問題(401) PIT

PIT (Programmable Interval Timer) では、 発振器の周波数は、1193182Hz である。
再設定用のレジスタを 1193 に設定したら、何秒に 1 回、割り込みが発生するか。

=== 解答

== 問題(402) モノトニック時刻の利用

カーネルの中で、カレンダ時刻ではなくてモノトニック時刻が使われている場所がある。
その理由を簡単に説明しなさい。
その場所をカレンダ時刻を使うようにすると、「ある操作をした場合」に「ある不都合」が生じる。
このことを、例を使って説明しなさい。

=== 解答

== 問題(403) struct timer_listの利用

関数 `f()` を実行している時に、次の関数 `h()` を、20 ミリ秒後に実行したいとする。

#sourcecode[```c
void h(int a,int b, int c) {
   ....
}
```]

これを実現するために、どのようなコードを書けばよいか。以下の空欄を埋めなさい。

#sourcecode[```c
struct timer_list my_timer;

int my_arg_a,my_arg_b,my_arg_c;

void f(unsigned long data) {
    timer_setup( /*空欄(a)*/, /*空欄(b)*/, 0);
    my_timer.expires  = /*空欄(c)*/;
    /*空欄(d)*/;
}
void my_timer_func(/*省略*/) {
     h( my_arg_a,my_arg_b,my_arg_c );
}
```]

=== 解答

== 問題(404) sched_class

`struct task_struct` のフィールド `sched_class` は、プロセスのスケジューリング・ポリシーに応じていくつかの値がセットされる。
ポリシーが `SCHED_NORMAL` の時、どのような値がセットされるか。この Web ページの資料の中から選んで答えなさい。

またポリシーが `SCHED_NORMAL` の時、`EEVDF` で `sched_class->enqueue_task()` として呼ばれる関数を答えなさい。

=== 解答

== 問題(405) 二分探索木によるレディ・キューの実装

以下の図は、4 つの要素を持つリストを表している。
各要素には、キーがあり、優先度を表しているものとする。

#figure(
  image("proc-list-next.png"),
  caption: [4 つの要素を持つリスト構造]
)

このリストを表現した二分探索木を１つ作り、節と枝（矢印）を用いて図示しなさい。
ただし、木はバランスをしていなくても良いものとする。

注意: 正しい二分探索木は、複数存在する。

=== 解答
