{.push stack_trace: off, profiler:off.}

import uart

proc rawoutput(s: cstring) =
  uartPutStr(s)
  while true:
    asm """
      nop
    """


proc panic(s: cstring) =
  rawoutput(s)

# Alternatively we also could implement these 2 here:
#
# template sysFatal(exceptn: typeDesc, message: string)
# template sysFatal(exceptn: typeDesc, message, arg: string)

{.pop.}
