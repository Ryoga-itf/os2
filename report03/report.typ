#import "/template.typ": *
#import "@preview/codelst:2.0.2": *

#show: project.with(
  week: 3,
  date: datetime(year: 2026, month: 1, day: 28)
)

== 問題(301) CMOS RTC のデバイスドライバ

`rtc-read-time.c` のプログラムでシステム・コールが実行されると、CMOS RTC のデバイス・ドライバに含まれる関数が実行される。
次のシステム・コールが実行された時に、どんな関数が実行されるかを答えなさい。
`drivers/rtc/{class.c,dev.c}` に含まれる関数の名前で答えなさい。

- `open()` システム・コール (23行目):
- `ioctl()` システム・コール (28行目):
- `close()` システム・コール (36行目):

=== 解答

== 問題(302) copy_from_user()とmemcpy()

関数 `rtc_dev_ioctl()` は、`copy_from_user()` を呼び出している。
これは正しいプログラムであるが、もしも `copy_from_user()` を `memcpy()` やポインタを操作して直接ユーザ空間のメモリにアクセスすると問題がある。
334 行目は、`copy_from_user()` を呼び出している。
これは正しいプログラムであるが、もしも `copy_from_user()` を `memcpy()` やポインタを操作して直接ユーザ空間のメモリにアクセスすると問題がある。
334 行目 を、`memcpy()` を使って「間違ったプログラム」に書き換えなさい。
ただし、`copy_from_user()` は必ず成功するものとして、エラー処理を省略しなさい。以下の「`/*空欄*/`」を埋めなさい。

#soucecode[```c
	if( memcpy( /*空欄(a)*/,/*空欄(b)*/,/*空欄(c)*/ ), 0 )
		return -EFAULT;
```]

なお、`memcpy()` のインタフェースは、次のようになっている。

#soucecode[```c
void * memcpy(void *destination, const void *source, size_t len);
```]

`source` は、コピー元、`destination` は、コピー先、`len` は長さ (バイト数) である。結果として `destination` を返す。
C言語の「`,`」演算子は、次のような意味である。

#soucecode[```c
    式1 , 式2
```]

「式1」を評価し、次に「式2」を評価し、全体としては、「式2」の値を返す。 この課題は、常に 0 (成功) を返すようにしている。

なお、`__user` は、ユーザ空間のアドレスを意味し、エラー・チェックに使われる、C プリプロセッサで空の文字列に展開されることもある。
この問題では空の文字列に展開されると考えなさい。

=== 解答

== 問題(303) x86 CMOS RTCからの分(minutes)データの入力

=== 解答

== 問題(304) 割り込み信号線の共有

=== 解答

== 問題(305) 割り込みコンテキスト

=== 解答

== 問題(306) 次回の授業

=== 解答

