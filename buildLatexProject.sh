mkdir -p $BUILD_DIR/src

echo "Working directory: $BUILD_DIR"

cat $HEADER_FILE > $TARGET_LATEX_FILE;
echo "\begin{document}" >> $TARGET_LATEX_FILE;

for fragment in ./src/*; do
  ln -sf $fragment $BUILD_DIR/src/`basename $fragment`
  echo "\\include{$fragment}" >> $TARGET_LATEX_FILE;
done

echo "\end{document}" >> $TARGET_LATEX_FILE;

pdflatex -output-directory $BUILD_DIR \
  -output-format=pdf \
  -file-line-error \
  -halt-on-error \
  `basename $TARGET_LATEX_FILE`

