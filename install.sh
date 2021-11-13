source $stdenv/setup

mkdir -p $out/bin

headerFile=$out/header.tex
cp $src/header.tex $headerFile

buildLatexProject=$out/bin/buildLatexProject
watchLatexProject=$out/bin/watchLatexProject

substitute \
    ./buildLatexProject.sh \
    $buildLatexProject \
    --subst-var texlive \
    --subst-var headerFile

substitute \
    ./watchLatexProject.sh \
    $watchLatexProject \
    --subst-var buildLatexProject \
    --subst-var watchexec \
    --subst-var xdg_open

chmod +x $buildLatexProject $watchLatexProject
