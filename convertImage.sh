usage() {
    echo "Please type the tex file."
    exit
}
generate() {
    echo "\documentclass{article}
\usepackage{tikz}
\usepackage{pgfplots}
\\\begin{document}
\\\begin{tikzpicture}
  \\\begin{axis}{
      title=Inv. cum. normal,
      xlabel={\$x\$},
      ylabel={\$y\$},
    }
    \\\addplot [mark=none, color=blue] table [y expr=\\\thisrowno{1}]  {$origin} ;
    \\\addplot [mark=none, color=green] table [y expr=\\\thisrowno{2}]  {$origin};
    \\\addplot [mark=none, color=red] table [y expr=\\\thisrowno{3}]  {$origin};
  \end{axis}
\end{tikzpicture}
\end{document}" > $target
}
if [[ $# == 0 ]]; then
    usage
fi
origin=$1
if [ -f $origin ]; then
    target=${origin%.*}.tex
    generate
    /usr/texbin/pdflatex $target
    # open $target
else
    echo File $origin doesn\'t exist or has other issue.
fi
