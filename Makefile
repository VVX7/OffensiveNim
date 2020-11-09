vpath %.exe bin/
vpath %.dll bin/
vpath %.nim src/

NIMFLAGS = -d=release -d=mingw -d=strip --opt=size

SRCS_BINS = $(notdir $(wildcard src/*_bin.nim))
SRCS_LIBS = $(notdir $(wildcard src/*_lib.nim))
BINS = $(patsubst %.nim,%.exe,$(SRCS_BINS))
DLLS = $(patsubst %.nim,%.dll,$(SRCS_LIBS))

.PHONY: clean

default: $(BINS) $(DLLS)

clean:
	rm -rf bin/*.exe
	rm -rf bin/*.dll

%.exe : %.nim
	nim c $(NIMFLAGS) --app=console --cpu=amd64 --out=bin/$*_64.exe $<
	nim c $(NIMFLAGS) --app=console --cpu=i386 --out=bin/$*_32.exe $<

%.dll: %.nim
	nim c $(NIMFLAGS) --app=lib --nomain --cpu=amd64 --out=bin/$*_64.dll $<
	nim c $(NIMFLAGS) --app=lib --nomain --cpu=i386 --out=bin/$*_32.dll $<