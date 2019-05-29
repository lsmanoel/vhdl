#Cria Biblioteca
vlib work

#Compila Projeto
vcom sevenSegArray.vhd
vcom tb_sevenSegArray.vhd

#Simula
vsim -t ns work.tb_sevenSegArray

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
add wave -radix binary -label clock_50_0_logic /clock_50_0_logic

#------------------------------------------------------------------------------------------
add wave -radix dec -label int2dig_data_integer /sevenSegArray_vhd/int2dig_data_integer
add wave -radix dec -label int2dig_dign_integer_array_0 /sevenSegArray_vhd/int2dig_dign_integer_array(0)
add wave -radix dec -label int2dig_dign_integer_array_1 /sevenSegArray_vhd/int2dig_dign_integer_array(1)
add wave -radix dec -label int2dig_dign_integer_array_2 /sevenSegArray_vhd/int2dig_dign_integer_array(2)
add wave -radix dec -label int2dig_dign_integer_array_3 /sevenSegArray_vhd/int2dig_dign_integer_array(3)
add wave -radix dec -label int2dig_dign_integer_array_4 /sevenSegArray_vhd/int2dig_dign_integer_array(4)
add wave -radix dec -label int2dig_dign_integer_array_5 /sevenSegArray_vhd/int2dig_dign_integer_array(5)

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