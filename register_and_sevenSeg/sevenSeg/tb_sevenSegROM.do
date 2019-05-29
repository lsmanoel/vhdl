#Cria Biblioteca
vlib work

#Compila Projeto
vcom sevenSegROM.vhd
vcom tb_sevenSegROM.vhd

#Simula
vsim -t ns work.tb_sevenSegROM

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label SW /SW

#------------------------------------------------------------------------------------------
add wave -radix binary -label HEX0 /HEX0
add wave -radix binary -label HEX1 /HEX1
add wave -radix binary -label HEX2 /HEX2
add wave -radix binary -label HEX3 /HEX3
add wave -radix binary -label HEX4 /HEX4
add wave -radix binary -label HEX5 /HEX5

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps