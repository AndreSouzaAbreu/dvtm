# Customize below to fit your system
DESTDIR=${HOME}/.local/bin
INCS=-I.
LIBS=-lc -lutil -lncursesw
CPPFLAGS=-D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 -D_XOPEN_SOURCE_EXTENDED
CFLAGS+=-std=c99 ${INCS} -DNDEBUG ${CPPFLAGS}
CC?=cc
