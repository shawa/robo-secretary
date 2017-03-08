PROC_UNITS ?= $(shell nproc || echo 1)
MAKEFLAGS += --jobs=$(PROC_UNITS)
# for being parallel
print-%  : ; @echo $* = $($*)
# for silly debugging

ORG_FILES := $(wildcard src/*.org)
TXT_FILES := $(wildcard src/*.txt)
PDF_FILES := $(addprefix pdf/, $(notdir $(TXT_FILES:.txt=.pdf)))

BOOK_PANDOC_FLAGS := -f markdown --number-sections --toc --variable fontsize=12pt
BOOK_DESTINATION := /srv/webspace/$(shell whoami)/minutes.pdf
MAILING_LIST_ADDRESS:="council-sages@lists.netsoc.tcd"

.PHONY: all mail meetings book clean publish
all: meetings $(BOOK_DESTINATION)

# the per-minute meetings
meetings: $(PDF_FILES)

# a book of everything we've done this year
$(BOOK_DESTINATION): src/*.txt cover.txt
	sed -e '$$s/$$/\n\n\\pagebreak\n/' -s cover.txt src/*.txt \
		| pandoc --number-sections --toc -f markdown -o $@

pdf/%.pdf: src/%.txt
	pandoc -f markdown -o $@ $<

LATEST:=$(shell ls src | tac | head -n 1 | cut -d '.' -f 1)
mail: src/$(LATEST).txt pdf/$(LATEST).pdf greeting.py
	echo "`python greeting.py`\n\n---\n\n `cat $<`" \
	| mailx -s 'Netsoc Minutes $(LATEST)' -a $(word 2,$^) $(MAILING_LIST_ADDRESS)

clean:
	/bin/rm -rf pdf/*
	/bin/rm $(BOOK_DESTINATION)
