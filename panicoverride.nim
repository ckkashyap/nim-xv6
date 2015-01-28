{.push stack_trace: off, profiler:off.}

proc rawoutput(s: string) =
  asm """
    "nop"
  """

proc panic(s: string) =
  rawoutput(s)

# Alternatively we also could implement these 2 here:
#
# template sysFatal(exceptn: typeDesc, message: string)
# template sysFatal(exceptn: typeDesc, message, arg: string)

{.pop.}
