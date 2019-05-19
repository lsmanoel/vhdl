#Cria Biblioteca
vlib work

#Compila Projeto
vcom sevenSeg.vhd
vcom tb_sevenSeg.vhd

#Simula
vsim -t ns work.tb_sevenSeg

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label data_logic_vector /data_logic_vector
add wave -radix dec -label data_integer /data_integer

add wave -radix binary -label sevenSeg_q_logic_vector /sevenSeg_q_logic_vector
add wave -radix dec -label sevenSeg_q_integer /sevenSeg_q_integer
#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps