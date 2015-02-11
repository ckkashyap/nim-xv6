all:
	make -C boot/x86_64
	$(NIM) c --noLinking --os:standalone --deadCodeElim:on --noMain  --parallelBuild:1 --gcc.exe:$(GCC) --passC:"-I$(NIM)/tinyc/win32/include" --passC:"-w" --passC:"-O2" --passC:"-Wall" --passC:"-Wextra" --passC:"-ffreestanding" --passC:"-mcmodel=kernel" --threads:on   main.nim
	$(LD) -m elf_x86_64 -nodefaultlibs -nostdlib -T boot/x86_64/kernel64.ld -o kernel.elf boot/x86_64/entry64.o boot/x86_64/main.o  nimcache/*.o  -b binary boot/x86_64/initcode boot/x86_64/entryother


run: kernel.elf
	$(QEMU)  -kernel kernel.elf -vnc :1  -s -serial stdio

clean:
	rm -rf nimcache/
	rm -f kernel.elf
	make -C boot/x86_64 clean
