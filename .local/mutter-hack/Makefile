# paths
PREFIX = ${HOME}/.local
APPPREFIX = ${PREFIX}/share/applications

# libs
CFLAGS=$(shell pkg-config --cflags libmutter-2) -Wl,-rpath,/usr/lib/mutter
LDFLAGS=$(shell pkg-config --libs libmutter-2)


mutter-hack: main.c
	${CC} $^ -o $@ ${CFLAGS} ${LDFLAGS}

install: mutter-hack
	@mkdir -p ${PREFIX}/bin
	@cp mutter-hack ${PREFIX}/bin

all: mutter-hack

.PHONY: all install
