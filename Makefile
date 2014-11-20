all: MAT257.pdf

MAT257.pdf: *.tex
	pdflatex MAT257.tex
	# note, run twice to ensure indexing is correct
	pdflatex MAT257.tex

clean_useless:
	rm -f *.{aux,toc,out,idx,log,backup} *~

clean: clean_useless
	rm -f *.pdf

commit: MAT257.pdf clean_useless
	git commit -a -m "update at `date --rfc-2822`" && git pull && git push

.PHONY: clean commit clean_useless
