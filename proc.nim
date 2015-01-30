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

import mmu

const NSEGS = 7

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
  id: uint8                  # index into cpus[] below
  apicid: uint8              # Local APIC ID
  scheduler: ptr Context     # swtch() here to enter scheduler
  gdt: array[NSEGS, SegDesc] # x86 global descriptor table
  # TODO struct taskstate ts;         # Used by x86 to find stack for interrupt
  started: bool              # Has the CPU started?
  ncli: int                  # Depth of pushcli nesting.
  intena: int                # Were interrupts enabled before pushcli?                
  # TODO local needs to be figured out
