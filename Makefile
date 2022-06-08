HTML=index.html
PDF=elag2022-voss.pdf
OPTIONS=--slide-level 2 --lua-filter=diagram-generator.lua

html: $(HTML)
pdf: $(PDF)

$(HTML): metadata.yaml slides.md
	pandoc -s -t revealjs \
        -V theme=white -V transition=fade -V backgroundTransition=fade \
		$(OPTIONS) \
		--extract-media=. \
		--slide-level 2 \
        --css style.css $^ -o $@

$(PDF): metadata.yaml slides.md
	pandoc -t beamer --pdf-engine=xelatex \
		$(OPTIONS) \
	   	--template vzg-slides.tex -o $@ $^

.PHONY: clean

all: $(HTML) $(PDF)

clean:
	rm -f *.svg
