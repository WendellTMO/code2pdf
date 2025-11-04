FILTER=include-code-files.lua

build: source.pdf source2.pdf

source.pdf: python_source/*.py scripts/*.sh
	pandoc \
        --to html \
		--lua-filter=${FILTER} \
		--output source.pdf \
		source.md

source.html: python_source/*.py scripts/*.sh
	pandoc \
        --standalone \
		--lua-filter=${FILTER} \
		--css style.css \
		--output source.html \
		source.md

source2.pdf: source.html
	wkhtmltopdf \
        --enable-local-file-access \
        -T 20 -B 20 -L 20 -R 20 \
        source.html source2.pdf

clean:
	rm -f source.pdf
	rm -f source2.pdf
	rm -f source.html
