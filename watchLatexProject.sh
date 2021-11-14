export BUILD_DIR=`mktemp -d`;
export TARGET_LATEX_FILE="$BUILD_DIR/assembled_file.tex";
export TARGET_PDF="$BUILD_DIR/assembled_file.pdf";

@buildLatexProject@;
@xdg_open@ $TARGET_PDF;
@watchexec@/bin/watchexec --restart --clear --debounce 200 --watch src -- @buildLatexProject@
