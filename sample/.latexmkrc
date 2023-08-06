# LuaLaTeX のビルドコマンド
$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
# Biber, BibTeX のビルドコマンド
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'pbibtex %O %B';
# makeindex のビルドコマンド
$makeindex = 'upmendex %O -o %D %S';

$pdf_mode = 4;