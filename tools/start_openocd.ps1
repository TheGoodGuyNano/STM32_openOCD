#! /bin/bash

$OPENOCD_HOME="C:\Opt\openocd\v0.12.0"

$IF="interface\stlink-v2.cfg"
$BOARD=".\stlinkv2_stm32f103c8_blue_pill.cfg"

openocd -f "$OPENOCD_HOME\share\openocd\scripts\$IF" -f "$BOARD"
