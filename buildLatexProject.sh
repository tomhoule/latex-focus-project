#!/usr/bin/env bash

pdflatex=@pdflatex@
headerFile=@headerFile@

if [[ $TMPDIR == "" ]]; then
    echo 'Error: $TMPDIR is not defined'
    exit 1
fi

echo "Working directory: $TMPDIR"

mkdir -p $TMPDIR/src

cat $headerFile > $TARGET_LATEX_FILE;
echo "\begin{document}" >> $TARGET_LATEX_FILE;

for fragment in ./src/*; do
  ln -sf $fragment $TMPDIR/src/`basename $fragment`
  echo "\\include{$fragment}" >> $TARGET_LATEX_FILE;
done

echo "\end{document}" >> $TARGET_LATEX_FILE;

$pdflatex -output-directory $TMPDIR \
  -output-format=pdf \
  -file-line-error \
  -halt-on-error \
  `basename $TARGET_LATEX_FILE`
