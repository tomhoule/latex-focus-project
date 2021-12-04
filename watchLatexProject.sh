export TMPDIR=`mktemp -d`;
export TARGET_LATEX_FILE="$TMPDIR/assembled_file.tex";
export TARGET_PDF="$TMPDIR/assembled_file.pdf";

@buildLatexProject@;
xdg-open $TARGET_PDF &
@watchexec@ --restart --clear --debounce 200 --watch src -- @buildLatexProject@
