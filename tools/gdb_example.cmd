target remote localhost:3333
set arm abi APCS
monitor reset halt
file "./blinky_example.elf"
load
monitor reset
break main.c:100
continue