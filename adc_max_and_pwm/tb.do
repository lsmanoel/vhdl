#******************************************************************************
#                                                                             *
#                  Copyright (C) 2016 IFSC                                    *
#                                                                             *
#                                                                             *
# All information provided herein is provided on an "as is" basis,            *
# without warranty of any kind.                                               *
#                                                                             *
# File Name: tb.do          							    				  *
#                                                                             *
#                                                                             *
# REVISION HISTORY:                                                           *
#  Revision 0.1.0    25/02/2017 - Initial Revision                            *
#******************************************************************************

vlib work
vcom hex2dig.vhd
vcom sevenSegArray.vhd
vcom sevenSegROM.vhd
vcom display_dec.vhd sram.vhd testbench.vhd

vsim -t ns work.testbench

# view wave
add wave -radix binary /sys_clk
add wave /reset

add wave -radix unsigned rdaddress
add wave response_valid

#------------------------------------------------------------------------------------------
#SEVENSEG
add wave -radix binary -label HEX0 /HEX0
add wave -radix binary -label HEX1 /HEX1
add wave -radix binary -label HEX2 /HEX2
add wave -radix binary -label HEX3 /HEX3
add wave -radix binary -label HEX4 /HEX4
add wave -radix binary -label HEX5 /HEX5

run 120 us

wave zoomfull
