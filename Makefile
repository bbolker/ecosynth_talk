ecosynth.pdf: ecosynth.Rnw wnv.bib
	echo "knitr::knit2pdf(\"$<\")" | R --slave

upload:
	scp ecosynth.pdf ms.mcmaster.ca:~/public_html/misc/bolker_ecosynth.pdf

clean:
	rm -f *.aux *.log *.out *.bbl *.blg *.nav *~ *.snm *.toc
