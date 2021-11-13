
# watchLatexProject
export BUILD_DIR=`mktemp -d`;
export TARGET_LATEX_FILE="$BUILD_DIR/assembled_file.tex";
export TARGET_PDF="$BUILD_DIR/assembled_file.pdf";

buildLatexProject;
xdg-open $TARGET_PDF;
watchexec --restart --clear --debounce 200 -- buildLatexProject
