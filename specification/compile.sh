#!/bin/bash

SRC=UAVCAN_Specification

#rm -rf out &> /dev/null
mkdir out &> /dev/null
cp -fP *.bib out/ &> /dev/null

rm out/$SRC.pdf
rm out/$SRC.log

pdflatex --halt-on-error --shell-escape $SRC.tex
#cd out
#bibtex $SRC
#cd ..
pdflatex --halt-on-error --shell-escape $SRC.tex
pdflatex --halt-on-error --shell-escape $SRC.tex

mv $SRC.pdf out/$SRC.pdf
mv $SRC.log out/$SRC.log

rm $SRC.aux
rm $SRC.lof
rm $SRC.lot
rm $SRC.out
rm $SRC.toc
