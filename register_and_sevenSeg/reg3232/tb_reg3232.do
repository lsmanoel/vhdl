#Cria Biblioteca
vlib work

#Compila Projeto
vcom reg3232.vhd
vcom tb_reg3232.vhd

#Simula
vsim -t ns work.tb_reg3232

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label reg3232_clock_logic /reg3232_clock_logic

#------------------------------------------------------------------------------------------
add wave -radix hex -label data_logic_vector /data_logic_vector
add wave -radix dec -label write_address_integer /write_address_integer
add wave -radix dec -label read_address_integer /read_address_integer
add wave -radix hex -label we_logic /we_logic
add wave -radix hex -label reg3232_q_logic_vector /reg3232_q_logic_vector

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps