#Cria Biblioteca
vlib work

#Compila Projeto
vcom reg32n.vhd
vcom tb_reg32n.vhd

#Simula
vsim -t ns work.tb_reg32n

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label reg32n_clock_logic /reg32n_clock_logic

#------------------------------------------------------------------------------------------
add wave -radix hex -label data_logic_vector /data_logic_vector
add wave -radix dec -label w_address_integer /w_address_integer
add wave -radix dec -label r_address_integer /r_address_integer
add wave -radix hex -label we_logic /we_logic
add wave -radix hex -label reg32n_q_logic_vector /reg32n_q_logic_vector

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps