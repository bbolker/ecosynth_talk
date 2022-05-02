ecosynth.pdf: ecosynth.Rnw wnv.bib
	echo "knitr::knit2pdf(\"$<\")" | R --slave

clean:
	rm -f *.aux *.log *.out *.bbl *.blg *.nav *~ *.snm *.toc
