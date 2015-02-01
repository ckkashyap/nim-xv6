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
import consts
import unsigned

# // Segment Descriptor
# struct SegDesc {
# uint lim_15_0 : 16;  // Low bits of segment limit
# uint base_15_0 : 16; // Low bits of segment base address
# uint base_23_16 : 8; // Middle bits of segment base address
# uint type : 4;       // Segment type (see STS_ constants)
# uint s : 1;          // 0 = system, 1 = application
# uint dpl : 2;        // Descriptor Privilege Level
# uint p : 1;          // Present
# uint lim_19_16 : 4;  // High bits of segment limit
# uint avl : 1;        // Unused (available for software use)
# uint rsv1 : 1;       // Reserved
# uint db : 1;         // 0 = 16-bit segment, 1 = 32-bit segment
# uint g : 1;          // Granularity: limit scaled by 4K when set
# uint base_31_24 : 8; // High bits of segment base address
# };


type
  SegDesc* = uint64

type
  SegDescPointer* = ptr array [8, int8]

proc segmentBase(descPointer: SegDescPointer): int32 = 
  let base_31_24 = descPointer[7]
  let base_23_16 = descPointer[4]
  let base_15_08 = descPointer[2]
  let base_07_00 = descPointer[3]
  (base_31_24 shl 24) or (base_23_16 shl 16) or (base_15_08 shl 8) or base_07_00

proc `segmentBase=`(descPointer: SegDescPointer, val: int32) =
  descPointer[7] = cast[int8](0xff and (val shr 24))
  descPointer[4] = cast[int8](0xff and (val shr 16))
  descPointer[2] = cast[int8](0xff and (val shr 8))
  descPointer[3] = cast[int8](0xff and val)

proc segmentLimit(descPointer: SegDescPointer): int32 = 
  let limit_19_16 = cast[int8]((descPointer[6] shr 4) and 0xf)
  let limit_15_08 = cast[int8](descPointer[0])
  let limit_07_00 = cast[int8](descPointer[1])
  (limit_19_16 shl 12) or (limit_15_08 shl 8) or limit_07_00

proc `segmentLimit=`(descPointer: SegDescPointer, val:int32) = 
  descPointer[6] = cast[int8](0xf and (val shr 12))
  descPointer[0] = cast[int8](0xff and (val shr 8))
  descPointer[1] = cast[int8](0xff and val)



proc PGROUNDUP*(a: Address): Address =
  Address(bool(a + PGSIZE - 1) and (not bool(PGSIZE - 1)))

