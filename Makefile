# Makefile for Star Merchant
# It's a small program, so it's not very complicated (right now)
CC = gcc
RC = windres
TARGET = starmerch
HEADERS = src/cargo.h src/starports.h src/upgrades.h src/resource.h
OBJS = obj/resource.o obj/main.o 
VER = 1.1
SRCDISTFILE = $(OUTFILE)_$(VER).tar.gz
INCLUDE_DIRS = -I/mingw/include
WARNS = -Wall
LIBS = -lmingw32 -lpdcurses

CFLAGS = -O2 -funroll-loops -std=c99 -D UNICODE -D _UNICODE $(WARNS)
#CFLAGS = -O2 -std=c99 $(WARNS)
#LDFLAGS = -s -lmingw32 -lpdcurses -Wl,--subsystem,console
LDFLAGS = -s $(LIBS) 

all : merchAll

merchAll : $(OBJS)
	$(CC) -o $(TARGET).exe $(OBJS) $(LDFLAGS)
	
clean :
	rm -rf obj/*.o $(TARGET).exe

obj/%.o : src/%.c $(HEADERS)
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) -c $< -o $@

obj/resource.o : res/resource.rc res/Application.manifest res/app.ico src/resource.h
	$(RC) -I.\src -I.\res -i $< -o $@