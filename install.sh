source $stdenv/setup

mkdir -p $out/bin

headerFile=$out/header.tex
cp $src/header.tex $headerFile

buildLatexProject=$out/bin/buildLatexProject
watchLatexProject=$out/bin/watchLatexProject
pdflatex=`command -v pdflatex`
watchexec=`command -v watchexec`

substitute \
    ./buildLatexProject.sh \
    $buildLatexProject \
    --subst-var pdflatex \
    --subst-var headerFile

substitute \
    ./watchLatexProject.sh \
    $watchLatexProject \
    --subst-var buildLatexProject \
    --subst-var watchexec

chmod +x $buildLatexProject $watchLatexProject
