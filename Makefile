all:
	make -C boot/x86_64
	nim c --noLinking --os:standalone --deadCodeElim:on --noMain --gcc.exe:$(GCC) main.nim
	$(LD) -m elf_x86_64 -nodefaultlibs -nostdlib -T boot/x86_64/kernel64.ld -o kernel.elf boot/x86_64/entry64.o boot/x86_64/main.o nimcache/stdlib_system.o nimcache/main.o nimcache/x86asm.o -b binary boot/x86_64/initcode boot/x86_64/entryother


run: all
	qemu-system-x86_64  -kernel kernel.elf -vnc :1  -s

clean:
	rm -rf nimcache/
	rm -f kernel.elf
	make -C boot/x86_64 clean
