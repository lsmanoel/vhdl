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
#CLOCK
add wave -radix binary -label clock_50_0_logic /clock_50_0_logic
#add wave -radix binary -label clock_50_PI_logic /clock_50_PI_logic

#------------------------------------------------------------------------------------------
#DATA
add wave -radix hex -color yellow -label data_unsigned /data_unsigned

#------------------------------------------------------------------------------------------
#WR_ADDRESS
add wave -radix dec -color yellow -label w_address_integer /w_address_integer
add wave -radix dec -color orange -label r_address_integer /r_address_integer

#------------------------------------------------------------------------------------------
#WE
add wave -radix binary -label we_logic /we_logic

#------------------------------------------------------------------------------------------
#Q
add wave -radix hex -label q_unsigned /q_unsigned
add wave -radix dec -label q_integer /q_integer

#------------------------------------------------------------------------------------------
#REG3232

#------------------------------------------------------------------------------------------
run 400 ns

wave zoomfull
write wave wave.ps