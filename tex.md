---
marp: true
theme: academic
paginate: true
math: katex
---
<!-- _class: lead -->
# VScode で$\LaTeX$を書く
#### ~VSCode の機能を使いこなす~
<br>

**裕磨**
学術サーバー
2022/2/10

---

<!-- _header: 目次 -->
<!-- 真ん中寄りにして、行間もいじる。 文字をおおきくする。-->
1. VSCode のインストール
2. $\LaTeX$ workshop の設定
3. setting.json の使い方と解説


---
<!--  _header: 初めに-->
### VSCode  とはマイクロソフト社が無償で提供する
### 統合開発環境である
<!-- 色を変える。_headerの色に合わせる。 -->
#### VScodeの特徴
* 無料で頒布されている
* 動作が軽い。とにかく軽い‼
* クロスプラットフォームである（様々なOSに対応している)
* 最新トレンド全部入り

---
<!--  _header: VSCode のインストール-->

VSCode のダウンロードは次のURL からダウンロードできる。
https://code.visualstudio.com/

ページに入ったらDown lode のボタンを押して何も触らずに,Next だけを押せばダウンロードできる。
この時かならず自分の使用するパソコンの機種を選ぶこと。$^1$
対応OS は
- Windows 
- Mac
- Linux

---
<!-- _header:  LaTeX workshop の設定  -->
#### LaTeXmK の設定をしよう。
$\LaTeX$mk とは何か？
* $\LaTeX$のコンパイルは相互参照のために複数回おこなわなければならないがそれを代行してくれる便利機能のこと。


設定するためには？
まずはルートディレクトリ直下に隠しファイルとして.latexmkのファイルを置く。

---
<!-- _header:  LaTeX workshop の設定  -->
#### LaTeX workshop をインストールしよう。
##### LaTeX workshop とは？

- $\LaTeX$workshopはVSCode の拡張機能であり無償で使用できる。
- $\LaTeX$ を効率的に打つために必要な素材が全部そろっている。

---

<!-- _header:  LaTeX workshop の設定  -->
#### インストール方法
VSCode を開いた拡張機能のマークをクリックして出てくる検索ボックスにLatex workshop と打ち込むと出てくる。


正しくインストールされるとサイドバーに$\TeX$のアイコンが
表示される。

---
<!-- _header: setting.jsonの解説 -->
### JSON形式ファイルの作法(LaTeXworkshop用)
JSONファイルは、全体を{}でくくる必要がある。
キーと値をコロンで区切って記述します。次のように
```json
{
 "kye1":"value1",
 "kye2":"value2"
}
```

のようにキー値と値は:で区切り、複数ある場合はカンマで区切ることができる。

---
<!-- _header: setting.jsonの解説 -->
### そのほかの書き方について

```json
["Engish","LaTeX",]
```
のように配列は、[]によって書く。
オブジェクトは、
```json
"object_name":{"propaty":ture}
```
のように書くことができる。オブジェクトとプロパティ$^1$が設定できる。
> 1:ソフトウェアが取り扱う対象（オブジェクト）の持つ設定や状態、属性などの情報をプロパティという.(引用元:(https://e-words.jp/w/%E3%83%97%E3%83%AD%E3%83%91%E3%83%86%E3%82%A3.html))

---


<!-- _header:  setting.json の設定  -->
#### setting.json の設定をおこなう。
setting.json はCtrl+shift+P でsetting.jsonを開くで出てくる。

Lua$\LaTeX$を使う場合のsetting.jsonは次のようになる。
```json
"latex-workshop.latex.tools": [
{
        "name": "Latexmk (LuaLaTeX)",
        "command": "latexmk",
        "args": [
          "-f", "-gg", "-lualatex", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
        ]
      }
]
```


---

<!-- _header:  setting.json の解説  -->
"latex-workshop.latex.tools"
tools は次に出てくるrecipes で使うためのツールを指定する形式になっている。


"name"
$\TeX$のコマンドの名前を指定する欄


"command"
操作するコマンドを指定する欄


"args"
コマンドの引数を記述

---

<!-- _header:  setting.json の解説  -->
##### args の中身の解説

|引数|動作|
|:---:|---|
|"-synctex=1"|.synctex ファイルを生成する。|
|"-file-line-error"|error 発生時にerror で止める|
|"interaction=nonstopmode"|error をある程度スキップする|
|"%DOC%"|現在開いているLaTeXファイルのパスと拡張子".tex"を抜いたファイル名を置換するプレイスホルダー$^1$である。|
> 1 プレースホルダー（英：placeholder）とは、あとから入力される文字・値の代わりに、仮に入力されている文字や値のこと:引用(https://jetb.co.jp/12262)

---
<!-- _header:  recipes の解説 -->
##### recipes の解説
Lua$\LaTeX$のrecipes である。

```json
    // latex-workshop.latex.recipes: Recipe の定義
"latex-workshop.latex.recipes": [
        // LuaLaTeX で書かれた文書のビルドレシピ
        {
          "name": "LuaLaTeX",
          "tools": [
            "Latexmk (LuaLaTeX)"
          ]
        },
]
```
---

<!-- _header:  recipes の解説 -->
##### recipes の解説
recipes は配列で書かれる。その為何個も入れることが可能。
|キーのname|仕様|
|:---:|---|
|"name"|$\LaTeX$ workshop のタブの名前を決める。|
|"tools"|"latex-workshop.latex.tools"で定義されたツールを入れる.入れた順番によって動作の順が変わる。|

---
<!--_header: setting.json の解説 -->

次のコードは、単語に関連したナビゲーションまたは操作を実行するときに、単語の区切り文字として使用される文字についての設定。
```json
{
    "editor.wordSeparators": "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?　、。「」【】『』（）！？てにをはがのともへでや",
}
```
##### ナビゲーションとは？
VSCode の基本機能であるマルチカーソルや、置換機能、スニペット等を使うときに必要となる設定。VSCodeで和文を編集する時に必要になる。

---
<!--_header: 使用ソフトMarpについて -->
使用ソフトウェア
VSCode 
Marp
使用スタイル:academic 
"https://raw.githubusercontent.com/kaisugi/marp-theme-academic/main/themes/academic.css"
### 参考文献
https://qiita.com/you8/items/8165fd492e7c20252815
https://qiita.com/Yarakashi_Kikohshi/items/a9357dd469320ffb65a0


