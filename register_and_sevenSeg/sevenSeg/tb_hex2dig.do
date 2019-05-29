#Cria Biblioteca
vlib work

#Compila Projeto
vcom hex2dig.vhd
vcom tb_hex2dig.vhd

#Simula
vsim -t ns work.tb_hex2dig

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label clock_50_0_logic /clock_50_0_logic

#------------------------------------------------------------------------------------------
add wave -radix dec -label DATA /data_integer
add wave -radix dec -label DIG0 /dig0_integer
add wave -radix dec -label DIG1 /dig1_integer
add wave -radix dec -label DIG2 /dig2_integer
add wave -radix dec -label DIG3 /dig3_integer
add wave -radix dec -label DIG4 /dig4_integer
add wave -radix dec -label DIG5 /dig5_integer

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps