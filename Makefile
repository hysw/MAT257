ifdef SystemRoot
   RM = del /Q
   FixPath = $(subst /,\,$1)
else
   ifeq ($(shell uname), Linux)
      RM = rm -f
      FixPath = $1
   endif
endif


USELESSPOSTFIX=aux,toc,out,idx,log,backup,gls,glo,glsdefs,xdy,ilg,ind,ist,acn,glg

all: MAT257.pdf clean_useless

pdf: MAT257.pdf

MAT257.pdf: *.tex
	pdflatex MAT257.tex
	# texindy MAT257.idx
	# note, run twice to ensure indexing is correct
	pdflatex MAT257.tex

clean_useless:
	#rm -f *.{$(USELESSPOSTFIX)} */*.{$(USELESSPOSTFIX)} *~
	$(RM) *.{$(USELESSPOSTFIX)} */*.{$(USELESSPOSTFIX)} */*/*.{$(USELESSPOSTFIX)} *~

clean: clean_useless
	#rm -f *.pdf
	$(RM) *.pdf

commit: MAT257.pdf clean_useless
	git commit -a -m "update at `date --rfc-2822`" && git pull && git push

.PHONY: pdf clean commit clean_useless
