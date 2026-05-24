#!/bin/bash

# sudo apt install calibre

if [[ $# -ne 2 ]]; then
    echo "usage: $0 input.epub output.pdf"
    exit 1
fi

infile=$1
outfile=$2

if [[ ! -e $infile ]]; then
    echo "$infile not found"
    exit 1
fi

if [[ -e $outfile ]]; then
    echo "$outfile already exists"
    exit 1
fi

ebook-convert ${infile} ${outfile} --pdf-default-font-size 11 --base-font-size 11 --embed-font-family "DejaVu Serif"

exit 0
