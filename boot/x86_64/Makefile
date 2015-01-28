all:
	gcc -fno-pic -static -fno-builtin -fno-strict-aliasing -Wall -MD -ggdb -fno-omit-frame-pointer -ffreestanding -fno-common -nostdlib -Iinclude -gdwarf-2 -m64 -DX64 -mcmodel=kernel -mtls-direct-seg-refs -mno-red-zone -O0 -fno-stack-protector -nostdinc -I. -o initcode.o -c initcode64.S
	ld -m elf_x86_64 -nodefaultlibs -N -e start -Ttext 0 -o initcode.out initcode.o
	objcopy -S -O binary initcode.out initcode
	gcc -fno-pic -static -fno-builtin -fno-strict-aliasing -Wall -MD -ggdb -fno-omit-frame-pointer -ffreestanding -fno-common -nostdlib -Iinclude -gdwarf-2 -m64 -DX64 -mcmodel=kernel -mtls-direct-seg-refs -mno-red-zone -O0 -fno-stack-protector -fno-pic -nostdinc -I. -o entryother.o -c entryother.S
	ld -m elf_x86_64 -nodefaultlibs -N -e start -Ttext 0x7000 -o bootblockother.o entryother.o
	objcopy -S -O binary -j .text bootblockother.o entryother
	gcc -gdwarf-2 -Wa,-divide -Iinclude -m64 -DX64 -mcmodel=kernel -mtls-direct-seg-refs -mno-red-zone -c -o entry64.o entry64.S
	gcc -fno-pic -static -fno-builtin -fno-strict-aliasing -Wall -MD -ggdb -fno-omit-frame-pointer -ffreestanding -fno-common -nostdlib -Iinclude -gdwarf-2 -m64 -DX64 -mcmodel=kernel -mtls-direct-seg-refs -mno-red-zone -O0 -fno-stack-protector -c -o main.o main.c
#ld -m elf_x86_64 -nodefaultlibs -T kernel64.ld -o kernel.elf entry64.o main.o -b binary initcode entryother


clean:
	rm -f initcode.o initcode.out initcode entryother.o entryother bootblockother.o entry64.o main.o kernel.elf *.d


run:
	qemu-system-x86_64 -kernel kernel.elf -vnc :1 -no-reboot -d int
