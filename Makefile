slides.html: about.yaml slides.md
	pandoc -s -t revealjs \
        -V theme=white -V transition=fade -V backgroundTransition=fade \
		--lua-filter=diagram-generator.lua \
		--extract-media=. \
		--slide-level 2 \
        --css style.css $^ -o $@
