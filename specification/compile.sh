#!/bin/bash

SRC=UAVCAN_Specification

function once()
{
    pdflatex -interaction=nonstopmode -file-line-error --halt-on-error --shell-escape $@
}

./clean.sh || exit 1

once $SRC.tex || exit 1
#bibtex $SRC  || exit 1
once $SRC.tex || exit 1
once $SRC.tex || exit 1

echo 'Success.'
