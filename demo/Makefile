CC=i686-w64-mingw32-gcc
CC_64=x86_64-w64-mingw32-gcc
CCFLAGS=-shared -masm=intel -Wall -Wno-pointer-arit

all: demo.x64.bin demo.x86.bin

%.bin: %.o loader.spec libtcg.x64.zip libtcg.x86.zip
	link loader.spec $< $@

%.x64.o: %.c tcg.h
	$(CC_64) -DWIN_X64 $(CFLAGS) -c -o $@ $<

%.x86.o: %.c tcg.h
	$(CC) -DWIN_X86 $(CFLAGS) -c -o $@ $<

tcg.tgz:
	wget -O tcg.tgz https://tradecraftgarden.org/download/tcg20251201.tgz

libtcg.x64.zip libtcg.x86.zip tcg.h: tcg.tgz
	tar xvf tcg.tgz
	cd tcg/libtcg && \
	make all && \
	cp libtcg* src/tcg.h ../..
	rm -rf tcg

.PHONY: clean
clean:
	rm -rf *.o *.bin *.zip *.tgz tcg.h
