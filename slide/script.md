# LateX入門
## LaTeXインストール
- LaTeX
- SmatraPDF
- VScode

## LaTeXとはなにか
TeX:クヌースが開発したプログラミング言語
LaTeX:クヌースがTeXを用いて開発した数式組版システム
<!--途中省略してもいいかも-->
LaTeX2e:高度な機能を使うために必要な拡張を加えたLaTeX
pLaTeX2e:LaTeX2eのいいかんじの拡張
<!--途中省略してもいいかも-->
upLaTeX2e:pLaTeX2eのUTF-8対応版
LuaLaTeX:
(ほかにもpdfLaTeXとかLuaLaTeXとかいろいろある)

LaTeX以下を指してLaTeXあるいはTeXということがある
TeXそのもを指すときにTeXLangageという言い方をすることがあるが、使う上ではほとんど広義のLaTeXしか出てこない

## なぜLaTeXを使うのか
- 数学系、物理系では論文執筆のデファクトスタンダード
- 数式がきれい
  - wordで書こうとするととんでもない数のクリックと精密なエイム力を要求される
- 見た目と論理構造を分離できる
- 修正、再利用が容易
- gitでバージョン管理できる
  - 共同編集が可能
- 貧弱なスペックのパソコンでも編集作業がやりやすい
- 無料

## LaTeXの環境構成
- VScode + LaTeXworkshop
  - 最強
- cloudLaTeX
  - オンライン実行環境
  - 環境構築の手間がない
  - カスタマイズ性は低い
  - 一方オンライン環境特有の問題も
- overLeaf
  - cloudLaTeXと同様オンライン実行環境
  - 日本語

## LaTeXの記法
最低限のコンパイル可能なLaTeX文書

## LaTeX文書のコンパイル
コンパイルとは
コンパイルコマンド
`uplatex test.tex`
`dvipdfmx test.dvi`(?)
`test.pdf`

## 数式環境
`\(\)`
`$$`
`\[\]`
`\brgin(align)`
`\end(align)`

a^2 + b^2 = c^2

## latexmx を使ったコマンドの一括実行

# VScode編
## VScodeのインストール
## VScodeの設定
- 自動保存
## 拡張機能LaTeXtoolbox
設定ファイルに設定を追記
編集環境(中級)の完成

# 上級編
- スニペット
  - レポートテンプレートの登録
  - 画像、表、etc ...
- キーボードショートカット
  - VScodeのデフォルトショートカット
  - 、。を, . に自動変換
  - CapsLockで$が入力できるようにする(英字キーボード限定)

## 参考文献
LaTeX2e美文書作成入門 奥田