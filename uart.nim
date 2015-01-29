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

import x86asm

const COM1 = 0x3f8

var uart : bool = false


proc uartPutC(byte: uint8) = 
  if not uart:
    return
  for i in 0 .. 128:
    if 0 == (int8(inb(COM1+5)) and 0x20):
       break
  outb(COM1, byte)  

proc uartGetC() : int = 
  if not uart:
    return -1
  
  if 0 == (int8(inb(COM1+5)) and 0x01):
    return -1

  return int(inb(COM1))


proc uartPutStr*(text: cstring) = 
  for i in 0 .. text.len - 1:
    uartPutC(uint8(text[i]))

proc earlyInit* () =
  outb(COM1+2 , 0)

  #9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80)    # Unlock divisor
  outb(COM1+0, 12)      # 115200/9600
  outb(COM1+1, 0)
  outb(COM1+3, 0x03)    # Lock divisor, 8 data bits.
  outb(COM1+4, 0)
  outb(COM1+1, 0x01)    # Enable receive interrupts.


  var b = inb(COM1 + 5)
  if int(b) == 0xff:
    return

  uart = true

  uartPutStr("xv6...\n")

  var x = uartGetC()

  if x == 65:
    while true:
      uartPutStr("Capital A pressed\n")
  

  
