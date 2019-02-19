MANPREFIX = ../man/man1
MANS = $(wildcard git-*.md)
MAN_PAGES = $(MANS:.md=.1)

default: man

man: $(MAN_PAGES)

%.1: %.md
	ronn -r --pipe $< > $@
	mv $@ $(MANPREFIX)

.PHONY: default man
