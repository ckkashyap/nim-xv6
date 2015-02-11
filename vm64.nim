import procs

#var cpu* {.codegenDecl: "__thread dingo $# $#$#".} : ptr CPU 
#var cpu* {.codegenDecl: "$# $# asm(\"%fs:0\")".} : ptr CPU 
var cpu*{.threadvar.}: ptr CPU 



