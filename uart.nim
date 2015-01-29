import x86asm

const COM1 = 0x3f8

var uart : bool = false

proc uartPutStr*(text: string) = 
  for i in 0 .. text.len - 1:
    var b = uint8(i)
    outb(COM1, 65)
  outb(COM1, 10)

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
  

  
