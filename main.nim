proc nimMain()  {.exportc.} =
  while true:
    asm """
      "mov $0x1234,%eax"
    """


nimMain()

