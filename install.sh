mkdir -p $out/bin

# buildLatexProject
BUILD_FILE=$out/bin/buildLatexProject

cp $src/header.tex $out/header.tex
echo "#!/usr/bin/env bash" > $BUILD_FILE
echo "HEADER_FILE=$out/header.tex" >> $BUILD_FILE
cat $src/buildLatexProject.sh >> $BUILD_FILE

# watchLatexProject
WATCH_FILE=$out/bin/watchLatexProject

cp $src/watchLatexProject.sh $WATCH_FILE

# Install
chmod +x $BUILD_FILE $WATCH_FILE
