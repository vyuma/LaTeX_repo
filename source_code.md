# 最強のLaTeX 環境構築 Windows版 付録


## [1] .latexmk 設定用ファイル
```perl
# 通常の LaTeX ドキュメントのビルドコマンド
$latex = 'uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode %S';
# pdfLaTeX のビルドコマンド
$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode %S';
# LuaLaTeX のビルドコマンド
$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
# XeLaTeX のビルドコマンド
$xelatex = 'xelatex %O -no-pdf -synctex=1 -shell-escape -interaction=nonstopmode %S';
# Biber, BibTeX のビルドコマンド
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
# makeindex のビルドコマンド
$makeindex = 'upmendex %O -o %D %S';
# dvipdf のビルドコマンド
$dvipdf = 'dvipdfmx %O -o %D %S';
# dvipd のビルドコマンド
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf.exe %O %S %D';

# PDF の作成方法を指定するオプション
## $pdf_mode = 0; PDF を作成しない。
## $pdf_mode = 1; $pdflatex を利用して PDF を作成。
## $pdf_mode = 2; $ps2pdf を利用して .ps ファイルから PDF を作成。
## pdf_mode = 3; $dvipdf を利用して .dvi ファイルから PDF を作成。
## $pdf_mode = 4; $lualatex を利用して .dvi ファイルから PDF を作成。
## $pdf_mode = 5; xdvipdfmx を利用して .xdv ファイルから PDF を作成。
$pdf_mode = 4;

# PDF viewer の設定
if ($^O eq 'MSWin32') {
  $pdf_previewer = "start %S";  # "start %S": .pdf に関連付けられた既存のソフトウェアで表示する。
} else {
  $pdf_previewer = "open %S";
}

## Windows では SyncTeX(PDF をビューアーで開いたまま中身の更新が可能で更新がビューアーで反映される機能) が利用できる SumatraPDF 等が便利。
## ぜひ SyncTeX 機能のあるビューアーをインストールしよう。
## SumatraPDF: https://www.sumatrapdfreader.org/free-pdf-reader.html
## $pdf_previewer = 'SumatraPDF -reuse-instance';
```

## [2] setting.json ソースコード
```json
// 日本語文書で単語移動を使うため、助詞や読点、括弧を区切り文字として指定する
    "editor.wordSeparators": "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?　、。「」【】『』（）！？てにをはがのともへでや",

    // 設定: LaTeX Workshop

    // LaTeX Workshop ではビルド設定を「Tool」と「Recipe」という2つで考える
    //   Tool: 実行される1つのコマンド。コマンド (command) と引数 (args) で構成される
    //   Recipe: Tool の組み合わわせを定義する。Tool の組み合わせ (tools) で構成される。
    //           tools の中で利用される Tool は "latex-workshop.latex.tools" で定義されている必要がある。
    
    // latex-workshop.latex.tools: Tool の定義
    "latex-workshop.latex.tools": [
      
        // latexmk を利用した lualatex によるビルドコマンド
        {
          "name": "Latexmk (LuaLaTeX)",
          "command": "latexmk",
          "args": [
            "-f", "-gg", "-pv", "-lualatex", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
          ]
        },
        // latexmk を利用した xelatex によるビルドコマンド
        {
          "name": "Latexmk (XeLaTeX)",
          "command": "latexmk",
          "args": [
            "-f", "-gg", "-pv", "-xelatex", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
          ]
        },
        // latexmk を利用した uplatex によるビルドコマンド
        {
          "name": "Latexmk (upLaTeX)",
          "command": "latexmk",
          "args": [
            "-f", "-gg", "-pv", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
          ]
        },
        // latexmk を利用した platex によるビルドコマンド
        // 古い LaTeX のテンプレートを使いまわしている (ドキュメントクラスが jreport や jsreport ) 場合のため
        {
          "name": "Latexmk (pLaTeX)",
          "command": "latexmk",
          "args": [
            "-f", "-gg", "-pv", "-latex='platex'", "-latexoption='-kanji=utf8 -no-guess-input-env'", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
          ]
        }
    ],

    // latex-workshop.latex.recipes: Recipe の定義
    "latex-workshop.latex.recipes": [
        // LuaLaTeX で書かれた文書のビルドレシピ
        {
          "name": "LuaLaTeX",
          "tools": [
            "Latexmk (LuaLaTeX)"
          ]
        },
        // XeLaTeX で書かれた文書のビルドレシピ
        {
          
          "name": "XeLaTeX",
          "tools": [
            "Latexmk (XeLaTeX)"
          ]
        },
        // LaTeX(upLaTeX) で書かれた文書のビルドレシピ
        {
          "name": "upLaTeX",
          "tools": [
            "Latexmk (upLaTeX)"
          ]
        },
        // LaTeX(pLaTeX) で書かれた文書のビルドレシピ
        {
          "name": "pLaTeX",
          "tools": [
            "Latexmk (pLaTeX)"
          ]
        },
    ],

    // latex-workshop.latex.magic.args: マジックコメント付きの LaTeX ドキュメントをビルドする設定
    // '%!TEX' で始まる行はマジックコメントと呼ばれ、LaTeX のビルド時にビルドプログラムに解釈され、
    // プログラムの挙動を制御する事ができる。
    // 参考リンク: https://blog.miz-ar.info/2016/11/magic-comments-in-tex/
    "latex-workshop.latex.magic.args": [
      "-f", "-gg", "-pv", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
    ],

    // latex-workshop.latex.clean.fileTypes: クリーンアップ時に削除されるファイルの拡張子
    // LaTeX 文書はビルド時に一時ファイルとしていくつかのファイルを生成するが、最終的に必要となるのは
    // PDF ファイルのみである場合などが多い。また、LaTeX のビルド時に失敗した場合、失敗時に生成された
    // 一時ファイルの影響で、修正後のビルドに失敗してしまう事がよくある。そのため、一時的なファイルを
    // 削除する機能 (クリーンアップ) が LaTeX Workshop には備わっている。
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux", "*.bbl", "*.blg", "*.idx", "*.ind", "*.lof", "*.lot", "*.out", "*.toc", "*.acn", "*.acr", "*.alg", "*.glg", "*.glo", "*.gls", "*.ist", "*.fls", "*.log", "*.fdb_latexmk", "*.synctex.gz",
        // for Beamer files
        "_minted*", "*.nav", "*.snm", "*.vrb",
    ],

    // latex-workshop.latex.autoClean.run: ビルド失敗時に一時ファイルのクリーンアップを行うかどうか
    // 上記説明にもあったように、ビルド失敗時に生成された一時ファイルが悪影響を及ぼす事があるため、自動で
    // クリーンアップがかかるようにしておく。

    "latex-workshop.latex.autoClean.run": "onBuilt",

    // latex-workshop.view.pdf.viewer: PDF ビューアの開き方
    // VSCode 自体には PDF ファイルを閲覧する機能が備わっていないが、
    // LaTeX Workshop にはその機能が備わっている。
    // "tab" オプションを指定すると、今開いているエディタを左右に分割し、右側に生成されたPDFを表示するようにしてくれる
    // この PDF ビュアーは LaTeX のビルドによって更新されると同期して内容を更新してくれる。
    "latex-workshop.view.pdf.viewer": "tab",

    // latex-workshop.latex.autoBuild.run: .tex ファイルの保存時に自動的にビルドを行うかどうか
    // LaTeX ファイルは .tex ファイルを変更後にビルドしないと、PDF ファイル上に変更結果が反映されないため、
    // .tex ファイルの保存と同時に自動的にビルドを実行する設定があるが、文書が大きくなるに連れてビルドにも
    // 時間がかかってしまい、ビルドプログラムの負荷がエディタに影響するため、無効化しておく。
    "latex-workshop.latex.autoBuild.run": "never",

    "[tex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
    },

    "[latex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
    },

    "[bibtex]": {
        // インデント幅を2にする
        "editor.tabSize": 2
    },


    // ---------- LaTeX Workshop ----------

    // 使用パッケージのコマンドや環境の補完を有効にする
    "latex-workshop.intellisense.package.enabled": true,

    // 生成ファイルを "out" ディレクトリに吐き出す
    "latex-workshop.latex.outDir": "out",
```
## スニペット設定ファイル
```json
{
    "report":{
        "prefix": "report",
        "body": [
            "\\documentclass[a4paper,11pt]{ltjsarticle}",
            "",
            "",
            "% 数式",
            "\\usepackage{amsmath,amsfonts}",
            "\\usepackage{bm}",
            "% 画像",
            "\\usepackage{graphics}",
            "\\usepackage{graphicx}",
            "\\usepackage{here} %画像の表示位置調整用",
            "\\usepackage{type1cm}",

            "",
            "%A4: 21.0 x 29.7cm",
            "${4}",
            "",
            "\\begin{document}",
            "",
            "\\title{${5}}",
            "\\author{${6}}",
            "\\date{${7:\\today}}",
            "\\maketitle",
            "",
            "",
            "$0",
            "",
            "",
            "\\end{document}"
        ],
        "description": "授業レポート用テンプレート"
    },

    "img2":{
        "prefix": "img2",
        "body": ["%横に2枚の画像(jpg/png)表示",
            "\\begin{figure}[H]",
        "\\begin{${1:center}}",
        "\\begin{tabular}{c}",
        "\\begin{minipage}{0.5\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:8cm}]{${3:sources}/$4}",
        "\\end{${1:center}}",
        "\\caption{$5}",
        "\\label{$6}",
        "\\end{minipage}",
        "\\begin{minipage}{0.5\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:8cm}]{${3:sources}/$7}",
        "\\end{${1:center}}",
        "\\caption{$8}",
        "\\label{$9}",
        "\\end{minipage}",
        "\\end{tabular}",
        "\\end{${1:center}}",
        "\\end{figure}",
        "\n",
        "$10"
        ]

    },

    "img3":{
        "prefix": "img3",
        "body": ["%横に3枚の画像(jpg/png)表示",
            "\\begin{figure}[H]",
        "\\begin{${1:center}}",
        "\\begin{tabular}{c}",
        "\\begin{minipage}{0.33\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:5cm}]{${3:sources}/$4}",
        "\\end{${1:center}}",
        "\\caption{$5}",
        "\\label{$6}",
        "\\end{minipage}",
        "\\begin{minipage}{0.33\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:5cm}]{${3:sources}/$7}",
        "\\end{${1:center}}",
        "\\caption{$8}",
        "\\label{$9}",
        "\\end{minipage}",
        "\\begin{minipage}{0.33\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:5cm}]{${3:sources}/$10}",
        "\\end{${1:center}}",
        "\\caption{$11}",
        "\\label{$12}",
        "\\end{minipage}",
        "\\end{tabular}",
        "\\end{${1:center}}",
        "\\end{figure}",
        "\n",
        "$13"
        ]

    },

    "img4":{
        "prefix": "img4",
        "body": ["%横に4枚の画像(jpg/png)表示",
            "\\begin{figure}[H]",
        "\\begin{${1:center}}",
        "\\begin{tabular}{c}",

        "\\begin{minipage}{0.25\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:4cm}]{${3:sources}/$4}",
        "\\end{${1:center}}",
        "\\caption{$5}",
        "\\label{$6}",
        "\\end{minipage}",

        "\\begin{minipage}{0.25\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:4cm}]{${3:sources}/$7}",
        "\\end{${1:center}}",
        "\\caption{$8}",
        "\\label{$9}",
        "\\end{minipage}",

        "\\begin{minipage}{0.25\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:4cm}]{${3:sources}/$10}",
        "\\end{${1:center}}",
        "\\caption{$11}",
        "\\label{$12}",
        "\\end{minipage}",

        "\\begin{minipage}{0.25\\hsize}",
        "\\begin{${1:center}}",
        "\\includegraphics[width=${2:4cm}]{${3:sources}/$13}",
        "\\end{${1:center}}",
        "\\caption{$14}",
        "\\label{$15}",
        "\\end{minipage}",

        "\\end{tabular}",
        "\\end{${1:center}}",
        "\\end{figure}",
        "\n",
        "$16"
        ]
    }
}
```
## 現在の作者のsetting.json
```json
{
  
        "files.autoSave": "afterDelay",
        "editor.fontSize": 15,
        "workbench.colorTheme": "Visual Studio Dark",
  // Python の設定
        "terminal.integrated.defaultProfile.windows": "Command Prompt",
        "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [
                "/k",
                "chcp",
                "65001"
            ],
            "icon": "terminal-cmd"
        },
        "Git Bash": {
            "source": "Git Bash"
        }
    },
    "terminal.integrated.fontSize": 17, 
  //  LaTeXの設定
    "editor.wordSeparators": "./\\()\"'-:,.;<>~!@#$%^&*|+=[]{}`~?　、。「」【】『』（）！？てにをはがのともへでや",

    // 設定: LaTeX Workshop

    // LaTeX Workshop ではビルド設定を「Tool」と「Recipe」という2つで考える
    //   Tool: 実行される1つのコマンド。コマンド (command) と引数 (args) で構成される
    //   Recipe: Tool の組み合わわせを定義する。Tool の組み合わせ (tools) で構成される。
    //   tools の中で利用される Tool は "latex-workshop.latex.tools" で定義されている必要がある。
    
    // latex-workshop.latex.tools: Tool の定義
    "latex-workshop.latex.tools": [
      // latexmk を利用した lualatex によるビルドコマンド
      {
        "name": "Latexmk (LuaLaTeX)",
        "command": "latexmk",
        "args": [
          "-f", "-gg", "-lualatex", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
        ]
      },
      // latexmk を利用した xelatex によるビルドコマンド
      {
        "name": "Latexmk (XeLaTeX)",
        "command": "latexmk",
        "args": [
          "-f", "-gg", "-xelatex", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
        ]
      },
      // latexmk を利用した uplatex によるビルドコマンド
      {
        "name": "Latexmk (upLaTeX)",
        "command": "latexmk",
        "args": [
          "-f", "-gg", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
        ]
      },
      // latexmk を利用した platex によるビルドコマンド
      // 古い LaTeX のテンプレートを使いまわしている (ドキュメントクラスが jreport や jsreport ) 場合のため
      {
        "name": "Latexmk (pLaTeX)",
        "command": "latexmk",
        "args": [
          "-f", "-gg", "-pv", "-latex='platex'", "-latexoption='-kanji=utf8 -no-guess-input-env'", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
        ]
      },

      {
        "name": "pLaTeX",
        "command": "platex",
        "args": [
          "%DOC%","-file-line-error","-interaction=nonstopmode","-halt-on-error"
        ],
        "env": {}
      },
      {
        "name": "dvipdfmx",
        "command": "dvipdfmx",
        "args": [
          "-V 4",
          "%DOC%"
        ]
      },
      {
        "name": "Biber",
        "command": "biber",
        "args": [
          "%DOCFILE%"
        ]
      },
  ],

    // latex-workshop.latex.recipes: Recipe の定義
"latex-workshop.latex.recipes": [
        // LuaLaTeX で書かれた文書のビルドレシピ
        {
          "name": "LuaLaTeX",
          "tools": [
            "Latexmk (LuaLaTeX)"
          ]
        },
        // XeLaTeX で書かれた文書のビルドレシピ
        {
          
          "name": "XeLaTeX",
          "tools": [
            "Latexmk (XeLaTeX)"
          ]
        },
        // LaTeX(upLaTeX) で書かれた文書のビルドレシピ
        {
          "name": "upLaTeX",
          "tools": [
            "Latexmk (upLaTeX)"
          ]
        },
        // LaTeX(pLaTeX) で書かれた文書のビルドレシピ
        {
          "name": "pLaTeX + dvipdfmx",
          "tools": [
            "pLaTeX", // 相互参照のために2回コンパイルする
            "pLaTeX",
            "dvipdfmx"
          ]
        },
        {
          "name": "pLaTeX + Biber + dvipdfmx",
          "tools": [
            "pLaTeX",
            "Biber",
            "pLaTeX",
            "pLaTeX",
            "dvipdfmx"
          ]
        },
    ],

    // latex-workshop.latex.magic.args: マジックコメント付きの LaTeX ドキュメントをビルドする設定
    // '%!TEX' で始まる行はマジックコメントと呼ばれ、LaTeX のビルド時にビルドプログラムに解釈され、
    // プログラムの挙動を制御する事ができる。
    // 参考リンク: https://blog.miz-ar.info/2016/11/magic-comments-in-tex/
    "latex-workshop.latex.magic.args": [
      "-f", "-gg", "-pv", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%DOC%"
    ],

    // latex-workshop.latex.clean.fileTypes: クリーンアップ時に削除されるファイルの拡張子
    // LaTeX 文書はビルド時に一時ファイルとしていくつかのファイルを生成するが、最終的に必要となるのは
    // PDF ファイルのみである場合などが多い。また、LaTeX のビルド時に失敗した場合、失敗時に生成された
    // 一時ファイルの影響で、修正後のビルドに失敗してしまう事がよくある。そのため、一時的なファイルを
    // 削除する機能 (クリーンアップ) が LaTeX Workshop には備わっている。
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux", "*.bbl", "*.blg", "*.idx", "*.ind", "*.lof", "*.lot", "*.out", "*.toc",
         "*.acn", "*.acr", "*.alg", "*.glg", "*.glo", "*.gls", "*.ist", "*.fls", "*.log",
          "*.fdb_latexmk", 
        // for Beamer files
        "_minted*", "*.nav", "*.snm", "*.vrb",
    ],

    // latex-workshop.latex.autoClean.run: ビルド失敗時に一時ファイルのクリーンアップを行うかどうか
    // 上記説明にもあったように、ビルド失敗時に生成された一時ファイルが悪影響を及ぼす事があるため、自動で
    // クリーンアップがかかるようにしておく。

    "latex-workshop.latex.autoClean.run": "onBuilt",

    // latex-workshop.view.pdf.viewer: PDF ビューアの開き方
    // VSCode 自体には PDF ファイルを閲覧する機能が備わっていないが、
    // LaTeX Workshop にはその機能が備わっている。
    // "tab" オプションを指定すると、今開いているエディタを左右に分割し、右側に生成されたPDFを表示するようにしてくれる
    // この PDF ビュアーは LaTeX のビルドによって更新されると同期して内容を更新してくれる。
    "latex-workshop.view.pdf.viewer": "tab",

    // latex-workshop.latex.autoBuild.run: .tex ファイルの保存時に自動的にビルドを行うかどうか
    // LaTeX ファイルは .tex ファイルを変更後にビルドしないと、PDF ファイル上に変更結果が反映されないため、
    // .tex ファイルの保存と同時に自動的にビルドを実行する設定があるが、文書が大きくなるに連れてビルドにも
    // 時間がかかってしまい、ビルドプログラムの負荷がエディタに影響するため、無効化しておく。
    "latex-workshop.latex.autoBuild.run": "never",

    "[tex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
    },

    "[latex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
        
    }, 


    "[bibtex]": {
        // インデント幅を2にする
        "editor.tabSize": 2
    },
    


    // ---------- LaTeX Workshop ----------

    // 使用パッケージのコマンドや環境の補完を有効にする
    "latex-workshop.intellisense.package.enabled": true,
    "window.zoomLevel": -1,
    "catex.greek-completion": {
    
      "name": "CaTeX Greek Completion",
      "languages": [
        "latex"
      ],
      "triggers": [
        ":"
      ],
      "dictionary": "$GIM/defaults/greeks.json",
      "renderMode": "latex"
    },

    // 、を,に変えることができる設定latexindent.yamlを用いて設定。

}
```
## LaTeXの動作確認用コード
```LaTeX
\documentclass{ltjsarticle}
% ltjsarticle: lualatex 用の 日本語 documentclass
% 他のタイプセットエンジンを使ってビルドする場合は、 \documentclass[dvipdfmx]{jsarticle} などとする。

\begin{document}

\title{はじめての\LaTeX }
\author{Meidai}
\maketitle
\section{はじめての\LaTeX Lua\LaTeX }
%\section{はじめての\LaTeX Lua\TeX}


\subsection{小見出し！}
Hello world!
今日は\LaTeX を覚えていってください。
\LaTeX + VSCode は最強の組み合わせ。

\end{document}
```
## cloud latex 用設定
workspace 設定に以下の内容を組み込む。
```json
// Workspace: settings.json
{
    "[latex]": {
      "editor.formatOnSave": false,
    },
  // LaTeX Workshop
    "latex-workshop.latex.autoBuild.run": "never",
    "latex-workshop.latex.outDir": "./.workspace",
    "latex-workshop.latex.recipes": [],
  // Cloud LaTeX Extension for VSCode
    "cloudlatex.enabled": true,
    "cloudlatex.supressIcon": false,
    "cloudlatex.projectId": 20210101,
    "cloudlatex.outDir": "./.workspace",
    "cloudlatex.autoCompile": false,
}
```
## Ultra math preview の設定
```json
"umath.preview.renderer": "mathjax",
"umath.preview.macros": [
		"\\require{physics}",
		"\\require{HTML}",
		"\\require{mathtools}",
		"\\require{mhchem}",
		"\\require{empheq}",
		"\\def\\l{\\left}",
		"\\def\\r{\\right}",
		"\\newcommand{\\drac}[2]{\\mathchoice{\\displaystyle\\frac{\\, #1\\, }{\\, #2 \\,}}{\\displaystyle\\frac{\\, #1\\, }{\\, #2 \\, }}{\\scriptstyle\\frac{#1}{#2}}{\\scriptscriptstyle\\frac{#1}{#2}}}",
		"\\newcommand{\\tdv}[3][]{\\drac{\\Delta^{#1} {#2}}{\\Delta {#3}^{#1}}}",
		"\\newcommand{\\bm}[1]{\\boldsymbol{#1}}",
		"\\newcommand{\\divisionsymbol}{÷}",
		"\\def\\div{\\vnabla\\vdot}",
		"\\newcommand{\\divi}{\\divisionsymbol}",
		"\\newcommand{\\si}[1]{\\mathrm{#1}}",
		"\\newcommand{\\e}{e}",
        "\\scriptsize{}",
	],
	"umath.preview.position": "top",
	"umath.preview.customCSS": [
		"background-color: rgba(0, 0, 0, 0.5);",
	],
  ```


