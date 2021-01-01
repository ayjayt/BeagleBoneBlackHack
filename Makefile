all:
	pandoc -s -o index.html README.md
	$(foreach file, $(wildcard ./docs/*.md), pandoc -s -o $(basename $(file)).html $(file);)
	sed -i 's/.md/.html/' index.html
