#!/bin/bash

SRC=UAVCAN_Specification

#rm -rf out &> /dev/null
mkdir out &> /dev/null
cp -fP *.bib out/ &> /dev/null

rm out/$SRC.pdf

pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
#cd out
#bibtex $SRC
#cd ..
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex

rm *.pdf*
