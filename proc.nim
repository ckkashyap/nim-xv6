# The MIT License (MIT)
# 
# Copyright (c) 2015 Kashyap
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

type Context = object
  r15: int64
  r14: int64
  r13: int64
  r12: int64
  r11: int64
  rbx: int64
  ebp: int64 #rbp
  eip: int64 #rip

type CPU = object
  id: uint8                    # index into cpus[] below
  apicid: uint8                # Local APIC ID
  scheduler: ptr Context       # swtch() here to enter scheduler
#TODO - not sure if this is even used in 64 bit  struct taskstate ts;         # Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   # x86 global descriptor table
  volatile uint started;       # Has the CPU started?
  int ncli;                    # Depth of pushcli nesting.
  int intena;                
