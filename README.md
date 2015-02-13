# nim-xv6
Translate xv6 to nim


## Build
Build depends on a devel version of Nim (0.10.3) and a C compiler that can emit x86_64

```bash
export GCC=gcc
export LD=ld
export OBJCOPY=objcopy
export NIM=nim
export QEMU=qemu-system-x86_64
make

