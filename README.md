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


While working on this I realized that instead of trying to build up
the kernel from scratch in Nim, a potentially better approach could be
to "infuse" Nim into working kernel. This way, I could have a "working
kernel" all the time. So I started
git@github.com:ckkashyap/nimxv6.git - and looks like the idea is
working. I took a working 64bit C version of xv6 and replaced uart.c
with uart.nim and it works! So, essentially, I have a working kernel
that has Nim source in it. Now, it's a matter of replacing more and
more of the C source with Nim - but always having the pleasure of a
working unix kernel.
