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

import spinlock
import mmu
import types
import consts
import memlayout
import console
import stdlib
import uart
import unsigned

type KMem = object
  lock: Spinlock
  useLock: bool
  #TODO - this structure is incomplete


var kmem = KMem ()
var physicalMemEnd: Address;

proc kfree(v: Address) =
  if ((int64(v) mod int64(PGSIZE)) != 0) or (v < physicalMemEnd) or (v2p(v) >= PHYSTOP):
    panic("kfree")
  var x = memsetNIM(cast[ArbitraryPointer](v), 1, PGSIZE)

  ## TODO not complete
  acquire(addr kmem.lock)


proc freeRange(startAddress: Address, endAddress: Address) =
  var sa = PGROUNDUP(startAddress)
  while true:
    kfree(sa)
    sa = sa + PGSIZE
    if sa > endAddress:
      break


proc kinit1*(startAddress: Address, endAddress: Address) =
  physicalMemEnd = startAddress
  initlock(addr kmem.lock, "kmem")
  kmem.useLock = false
  freeRange(startAddress, endAddress)




