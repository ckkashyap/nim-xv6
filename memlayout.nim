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

import types
import unsigned

const EXTMEM*   = Address(0x0fffff)            # Start of extended memory
const PHYSTOP*  = Address(0xE000000)           # Top physical memory
const DEVSPACE* = Address(0xFE000000)          # Other devices are at high addresses

# Key addresses for address space layout (see kmap in vm.c for layout)

const KERNBASE* = Address(0xFFFFFFFF80000000)  # First kernel virtual address
const DEVBASE*  = Address(0xFFFFFFFF40000000)  # First device virtual address
const KERNLINK* = Address(KERNBASE + EXTMEM) # Address where kernel is linked

proc v2p*(a: Address): Address =
  a - KERNBASE

proc p2v*(a: Address): Address =
  a + KERNBASE

proc V2P*(a: Address): Address =
  a - KERNBASE

proc P2V*(a: Address): Address =
  a + KERNBASE

proc IO2V*(a: Address): Address =
  a + DEVBASE - DEVSPACE


proc V2P_WO*(a: Address): Address =
  a - KERNBASE

proc P2V_WO*(a: Address): Address =
  a + KERNBASE

