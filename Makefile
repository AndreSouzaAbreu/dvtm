include config.mk

SRC=dvtm.c vt.c
BIN=dvtm dvtm-status dvtm-editor dvtm-pager
VERSION=$(shell git describe --always --dirty 2>/dev/null || echo "0.15-git")
CFLAGS+=-DVERSION=\"${VERSION}\"
DEBUG_CFLAGS=${CFLAGS} -UNDEBUG -O0 -g -ggdb -Wall -Wextra -Wno-unused-parameter

all: dvtm dvtm-editor

config.h:
	cp config.def.h config.h

dvtm: config.h config.mk *.c *.h
	${CC} ${CFLAGS} ${SRC} ${LDFLAGS} ${LIBS} -o $@

dvtm-editor: dvtm-editor.c
	${CC} ${CFLAGS} $^ ${LDFLAGS} -o $@

debug: clean
	@$(MAKE) CFLAGS='${DEBUG_CFLAGS}'

clean:
	@echo cleaning
	@rm -f dvtm
	@rm -f dvtm-editor

install: all
	@mkdir -p ${DESTDIR}
	@for b in ${BIN}; do \
		echo "installing ${DESTDIR}/$$b"; \
		cp -f "$$b" "${DESTDIR}" && \
		chmod 755 "${DESTDIR}/$$b"; \
	done

uninstall:
	@for b in ${BIN}; do \
		echo "removing ${DESTDIR}/$$b"; \
		rm -f "${DESTDIR}/$$b"; \
	done

.PHONY: all clean install uninstall debug
