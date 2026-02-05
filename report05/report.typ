#import "/template.typ": *
#import "@preview/codelst:2.0.2": *

#show: project.with(
  week: 5,
  date: datetime(year: 2026, month: 2, day: 6)
)

== 問題(501) Work Queue の初期化

Work Queue を使って次の関数 `f()` を、割り込み処理の後半で呼び出したい。

#sourcecode[```c
void f(int arg1, int arg2) {
   省略;
}
```]

これを実現するために、どのような Work Queue のハンドラと初期化コードを書けばよいか。
以下の空欄を埋めなさい。

#sourcecode[```c
static struct /*空欄(a)*/ wq1;

void work_queue_handler(struct work_struct *work) { /* Work Queue ハンドラ */
    int arg1, arg2;
    arg1 = 省略; /* f() の引数 */
    arg2 = 省略; /* f() の引数 */
    /*空欄(b)*/
}

初期化
{
    /*空欄(c)*/(&wq1, /*空欄(d)*/);
}
```]

=== 解答

#sourcecode[```c
static struct work_struct wq1;

void work_queue_handler(struct work_struct *work) { /* Work Queue ハンドラ */
    int arg1, arg2;
    arg1 = 省略; /* f() の引数 */
    arg2 = 省略; /* f() の引数 */
    f(arg1, arg2);
}

初期化
{
    INIT_WORK(&wq1, work_queue_handler);
}
```]

- 空欄(a): `work_struct`
- 空欄(b): `f(arg1, arg2);`
- 空欄(c): `INIT_WORK`
- 空欄(d): `work_queue_handler`

== 問題(502) Work Queue ハンドラの実行

次のコードは、割り込みの前半部分（ハードウェアの割り込み）の一部である。
割り込み処理の後半で、問題 (501) で定義した Work Queue のハンドラを呼ぶように、空欄を埋めなさい。

#sourcecode[```c
irqreturn_t irq_handler(int irq, void *dev) {
    /*空欄(e)*/(/*空欄(f)*/);
    return IRQ_HANDLED;
}
```]

=== 解答

#sourcecode[```c
irqreturn_t irq_handler(int irq, void *dev) {
    schedule_work(&wq1);
    return IRQ_HANDLED;
}
```]

- 空欄(e): `schedule_work`
- 空欄(f): `&wq1`

== 問題(503) struct file の役割

Linux カーネルの中で、ファイルを表現するためのオブジェクトとして `struct inode` と `struct file` がある。
1 種類 `struct inode` に集約しても、ファイルの操作（読み、書き、属性変更）では十分と思えるが、2 種類使われている。
`struct inode` にはない、`struct file` の重要な役割を 1 つ選んで簡単に説明しなさい。

=== 解答

同じ inode でも、プロセスがファイルを `open()` するたびに、別々の `struct file` が作られ、その中にそのオープンに固有の情報、例えばファイルのシーク位置などを持つ。

一方 `struct inode` はファイル実体側のメタデータ（所有者・パーミッション・サイズ・タイムスタンプ等）を表すので、複数の `open()` で共有される前提で、オープンごとに変わる状態は持ちにくい。

== 問題(504) Ext4 ファイルシステム

このページに掲載されている Ext4 ファイルシステムの関数うち、次のシステム・ コールが呼ばれた時に呼ばれると思われる関数を１つ上げなさい。

- `read()`
- `open()`

=== 解答

- `read()`: `ext4_file_read_iter()`
- `open()`: `ext4_file_open()`

== 問題(505) symlink() システムコール

次の関数は、`symlink()` システム・コール、および、`symlinkat()` システム・コールを実装している `vfs_symlink()` の一部である。
空欄を埋めて完成させなさい。
`dir` は、作成するシンボリック・リンクの親ディレクトリ、`dentry` は、作成するシンボリック・リンクの名前となるファイル名、`oldname` は、新たに作成するシンボリック・リンクの内容となる文字列を含む。

#sourcecode[```c
int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
                struct dentry *dentry, const char *oldname)
{
        int error;
...
        if (!/*空欄(g)*/->i_op->/*空欄(h)*/)
                return -EPERM;
...
        error = /*空欄(g)*/->i_op->/*空欄(h)*/(idmap, /*空欄(i)*/, /*空欄(j)*/, /*省略*/);
...
        return error;
}
```]

=== 解答

== 問題(506) 期末試験とアンケート

期末試験について、次の事柄を答えなさい。

- 日付:
- 曜日:
- 開始時刻:
- 持ち込めるもの:

授業評価アンケートについて、自分の態度を次の中から選びなさい。

- アンケートに回答した。
- これからアンケートに回答する。
- 回答しない。
- 決めていない。
- その他。

== 解答

期末試験について

- 日付: 2026年2月6日
- 曜日: 金曜日
- 開始時刻: 12時15分
- 持ち込めるもの: 授業で配布した資料 （Webページを印刷したもの）、その他の紙の資料

授業評価アンケートについて

- これからアンケートに回答する
