all:
	markdown README.md > index.html
	$(foreach file, $(wildcard ./docs/*.md), markdown $(file)	> $(basename $(file)).html)
	sed -i 's/.md/.html/' index.html
