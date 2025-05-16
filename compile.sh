#!/bin/bash

SRC=Cyphal_Specification

# https://tex.stackexchange.com/a/52994/132781
export max_print_line=1000
export error_line=254
export half_error_line=238

function once()
{
    pdflatex -interaction=nonstopmode -file-line-error --halt-on-error --shell-escape $@
}

./clean.sh || exit 1

cd specification
once $SRC.tex || exit 1
#bibtex $SRC  || exit 1
once $SRC.tex || exit 1
once $SRC.tex || exit 1

echo 'Success.'
