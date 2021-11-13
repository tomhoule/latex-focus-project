mkdir -p $out/bin
cp $src/header.tex $out/header.tex

BUILD_FILE=$out/bin/buildLatexProject

echo "#!/usr/bin/env bash" > $BUILD_FILE
echo "HEADER_FILE=$out/header.tex" >> $BUILD_FILE
cat $src/buildLatexProject.sh >> $BUILD_FILE

chmod +x $BUILD_FILE
