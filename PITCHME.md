---
theme: black
center: false
transition: slide
highlightTheme: solarized
customTheme: PITCHME
separatorVertical: "^\n--\n$"
---

<!-- .slide: class="center" -->
# エンジョイ中間言語

sei0o inoue

---

## 誰

<div class="twocol">
  <div>
    ![sei0o](assets/me5.jpg)
  </div>
  <div>
    <ul style="margin-top: 10px">
      <li>sei0o inoue ([@sei0o](http://twitter.com/sei0o))</li>
      <li>明石高専 2E</li>
      <li>[o0i.es](http://o0i.es)</li>
      <li>Rubyとか なんかいろいろ 広く浅く</li>
      <li>春休みは遊んでました</li>
  </div>
</div>

---

## Agenda

- VMについて
- What is 中間言語?
- Why use 中間言語?
- ちょろちょろっと概念
- 読んでみる!

---

## VMについて
- コンパイル言語・スクリプト言語
- 分け方の一つであって、実装はどちらでもよい
- Ruby → YARV
- PHP → HHVM (Hack)

---

図(コンパイラ vs VM(JITコンパイラ + ランタイム))

---

## What is 中間言語？

- ソースコードを機械語にコンパイルする際に間に挟む言語
- ここではIR (Intermediate Representation)やバイトコードも含めちゃいます

---

図(バイナリ(->アセンブラ)->中間言語->プログラミング言語)

---

## どこで使うの？

- .NET (C#)
- JVM (Java, Kotlin)
- Go
- LLVM
- V8, Chakra (JavaScript)
- Python
- Ruby (コンパイラと密結合)

---

## Why use 中間言語?
- アセンブラはしんどい
  - 命令が細かすぎる
  - アーキテクチャへの依存性が高い

```asm
push ebp
mov ebp, esp
sub esp, 0x40
```

- コードの最適化
  - 命令数を減らして高速に

---

## 最適化
- Dead Code Elimination
- Common Subexpression Elimination
- Bounds Check Elimination

---

## 静的単一代入 (SSA)
```
  a = b + 3
  a = a * b
  print(a)
```

↓

```
  a1 = b1 + 3
  a2 = a1 * b1
  print(a2)
```

---

図(SSAグラフ)

---

図(AST vs SSA; 'common subexpression elimination')

---

## 読んでみる

- 言語の解説
- 実行までの道のり
- ソースコードと中間言語/バイトコードの比較
- ノリで読んでます

---

## .NET (C#, F#)
- Windowsアプリ?
- CIL (Common Intermediate Language) / MSIL
- CLR (Common Language Runtime)
- 2つの血筋
  - .NET Framework → Windows
  - Mono → Linuxなど (今回はこっちを利用)
- 逆コンパイル (ILSpyなど)

--

- [.NET Core / .NET Framework / Xamarin / Monoの関係を整理する](http://ascii.jp/elem/000/001/156/1156721/)
![](assets/dotnet-today.png)
- .NET NativeというAOTコンパイラもあるらしい
<small>[Introducing .NET Standard](https://blogs.msdn.microsoft.com/dotnet/2016/09/26/introducing-net-standard/)より引用</small>

---

### 構成

<img src="assets/CLR_diag.png" style="background-color: white; width: 100%">
<small>Wikipediaより引用, CC-BY-SA Rursus</small>

---

<div class="twocol">
  <code><pre>
using System;

class <span class="blue">MainClass</span> {
  public static <span class="blue">void Main(string[] args)</span> {
    <span class="pink">Console.WriteLine(<span class="orange">"Hello!"</span>);</span>
  }
}

// 生成方法
// $ mcs hello.cs
// $ monodis hello.exe --output=hello.il
  </pre></code>
  <code><pre>
.class private auto ansi beforefieldinit <span class="blue">MainClass</span>
  extends [mscorlib]System.Object {

  <span class="green">// コンストラクタ
  .method public hidebysig specialname rtspecialname instance default void '.ctor' () cil managed {
    ...
  }</span>

  .method public static hidebysig default <span class="blue">void Main (string[] args)</span> cil managed {
    .entrypoint
    .maxstack 8
    IL_0000:  ldstr <span class="orange">"Hello!"</span>
    IL_0005:  call void class [mscorlib]<span class="pink">System.Console::WriteLine(string)</span>
    IL_000a:  ret
  }

}
  </pre></code>
</div>

---

## 最適化
- [The Mono JIT](http://www.mono-project.com/docs/advanced/runtime/jitslides/)

---

## JVM (Java)
- "Write Once, Run Anywhere"
- HotSpot
- Clojure, Scala, Kotlinなど → バイトコードを生成
- JRubyなど → JVM上でそのまま動作

---



---

## Go

<div class="twocol">
  <div style="width:40%">
    <img src="assets/gophercolor.png">
    Gopherくん
  </div>
  <div>
    <ul>
      <li>並列処理が得意</li>
      <li><strong>SSA</strong>ベースの最適化
        <ul>
          <li>1.6までAST(構文木)ベース</li>
        </ul>
      </li>
    </ul>
  </div>
</div>

<small>The Go gopher was designed by Renée French.</small>

---

### 比較
```bash
$ GOSSAFUNC=main go build
```

---

### 最適化の例
- [generic.rules](https://github.com/golang/go/blob/master/src/cmd/compile/internal/ssa/gen/generic.rules) (1200行ぐらい)
- コメントがていねい→**読める!**

```
// Convert x * 1 to x.
(Mul(8|16|32|64) (Const(8|16|32|64) [1]) x) -> x
```

```
// fold negation into comparison operators
(Not (Eq(64|32|16|8|B) x y)) -> (Neq(64|32|16|8|B) x y)
(Not (Neq(64|32|16|8|B) x y)) -> (Eq(64|32|16|8|B) x y)
```

- φ関数

```
// basic phi simplifications
(Phi (Const8  [c]) (Const8  [c])) -> (Const8  [c])
(Phi (Const16 [c]) (Const16 [c])) -> (Const16 [c])
(Phi (Const32 [c]) (Const32 [c])) -> (Const32 [c])
(Phi (Const64 [c]) (Const64 [c])) -> (Const64 [c])
```

---

### 最適化の例

- 定数をカッコの外に出す

```
// x + (C + z) -> C + (x + z)
(Add64 (Add64 i:(Const64 <t>) z) x) 
  && (z.Op != OpConst64 && x.Op != OpConst64)
 -> (Add64 i (Add64 <t> z x))
```

- if文の省略

```
(If (Not cond) yes no) -> (If cond no yes)
(If (ConstBool [c]) yes no) && c == 1 -> (First nil yes no)
(If (ConstBool [c]) yes no) && c == 0 -> (First nil no yes)
```

---

### 最適化の例

- こんな記述が…

<code class="hljs lisp">
<pre>
// strength reduction of divide by a constant.
// See <em>../magic.go</em> for a detailed description of these algorithms.
</pre>
</code>
<br>

- [magic.go](https://github.com/golang/go/blob/master/src/cmd/compile/internal/ssa/magic.go)を見てみる
- 定数での除算を乗算に置き換える
  - CPUの除算は乗算に比べて遅い

<code>
<pre>
// Machine <em>division instructions are slow</em>, so we try to
// compute this division with a multiplication + a few
// other cheap instructions instead.
</pre>
</code>

---

### magic?

```
//   ⎣x * m / 2^e⎦
// Which we want to be equal to ⎣x / c⎦ for 0 <= x < 2^n-1
// where n is the word size.
// Setting x = c gives us c * m >= 2^e.
// We'll chose m = ⎡2^e/c⎤ to satisfy that equation.
// What remains is to choose e.
// Let m = 2^e/c + delta, 0 <= delta < 1
//   ⎣x * (2^e/c + delta) / 2^e⎦
//   ⎣x / c + x * delta / 2^e⎦
// We must have x * delta / 2^e < 1/
```

- つらそう
- よく見るとただの式変形
- 本題とはずれるので説明はしません

---

### 最適化の例
- [ssa/gen/](https://github.com/golang/go/tree/master/src/cmd/compile/internal/ssa/gen)にはアーキテクチャ個々についての最適化も
  - x86
  - ARM
  - MIPS

---

## LLVM

<div class="twocol">
  <div style="width:50%">
    <img src="assets/DragonMedium.png">
    <del>ちょっとこわい</del>
  </div>
  <div>
    <ul>
      <li>「コンパイラ基盤」
        <ul>
          <li>VMではない</li>
        </ul>
      </li>
      <li>「巨人の肩に乗る」</li>
      <li>[scratch86](https://github.com/bobbybee/scratch86)</li>
    </ul>
  </div>
</div>

<small>[LLVM公式サイト](https://llvm.org/)より</small>

---

### LLVM (C, C++)
- clangから利用される
  - Apple謹製

<img src="assets/clang@2x.png">

<small>[OS X 10.10 Yosemite: The Ars Technica Review](https://arstechnica.com/gadgets/2014/10/os-x-10-10/22/)より引用</small>

---

<div class="twocol">
  <code><pre>
<span class="orange">#include &lt;stdio.h&gt;</span>

<span class="blue">int main ()</span> { // テストで減点されます
  <span class="fragment highlight-current-red" data-fragment-index="1">printf(</span><span class="green">"Hello!"</span><span class="fragment highlight-current-red" data-fragment-index="1">)</span>;
  <span class="fragment highlight-current-red" data-fragment-index="2">return 0;</span>
}

// 生成方法
// $ clang -S -emit-llvm hello.c -o hello.ll

// LLVM IR → 実行形式
// $ clang hello.ll
  </pre></code>
  <code><pre>
<span class="green">@.str = private unnamed_addr constant [7 x i8] c"Hello!\00", align 1</span>

<span class="blue">define i32 @main(i32, i8\*\*) #0</span> {
  ; 消しても動いた
  ; %1 = alloca i32, align 4
  ; store i32 0, i32\* %1, align 4
  %1 = <span class="fragment highlight-current-red" data-fragment-index="1">call i32 (i8\*, ...) @printf(i8\* getelementptr inbounds ([7 x i8], [7 x i8]\* <span class="fragment highlight-current-green" data-fragment-index="1">@.str</span>, i32 0, i32 0))</span>
  <span class="fragment highlight-current-red" data-fragment-index="2">ret i32 0</span>
}

<span class="orange">// あとからリンクする?
declare i32 @printf(i8\*, ...) #1</span>
  </pre></code>
</div>

---

### LLVM (Swift)
- iOSアプリ開発に利用
- swiftcから利用される
- SIL + LLVM IR の2段階戦略

<img src="assets/swiftc@2x.png">

<small>[OS X 10.10 Yosemite: The Ars Technica Review](https://arstechnica.com/gadgets/2014/10/os-x-10-10/22/)より引用</small>

---

## GCC (C)
- [?](ftp://gcc.gnu.org/pub/gcc/summit/2003/Tree%20SSA%20-%20A%20New%20optimization%20infrastructure.pdf)
- [GCC internals](https://gcc.gnu.org/onlinedocs/gccint/index.html#Top)

---

## BEAM (Erlang/Elixir)
- 並列処理が得意
- "Let it crash"

- Elixirはいいぞ

---

## V8 (JavaScript)
- Chromeに積まれている
- Ignition

---

## Chakra (JavaScript)
- Edgeに積まれている

<img src="assets/chakracore_pipeline.png">

<small>[Architecture Overview - Microsoft/ChakraCore Wiki](https://github.com/Microsoft/ChakraCore/wiki/Architecture-Overview/)より引用</small>


---

## アーキテクチャごとの最適化

---

## まとめ
- 中間言語は楽しい!!
- コンパイラは案外読める!!
- 工夫がすごい!!


---

## 参考資料
- [Static Single Assignment for Decompilation](https://yurichev.com/mirrors/vanEmmerik_ssa.pdf)
- LLVM
  - [LLVMを始めよう！ 〜 LLVM IRの基礎はclangが教えてくれた・Brainf**kコンパイラを作ってみよう 〜](https://itchyny.hatenablog.com/entry/2017/02/27/100000)
  - [Kaleidoscope](https://llvm.org/docs/tutorial/) コンパイラ自作のチュートリアル
  - [LLVM Language Reference Manual](https://llvm.org/docs/LangRef.html)

---

<!-- .slide: class="center" -->
おしまい  
<small>Powered by Reveal.js</small>