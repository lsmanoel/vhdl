#Cria Biblioteca
vlib work

#Compila Projeto
vcom hex2dig.vhd
vcom sevenSegArray.vhd
vcom sevenSegROM.vhd
vcom de0_lite.vhd
vcom tb_de0_lite.vhd

#Simula
vsim -t ns work.tb_de0_lite

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
#CLOCK
#add wave -radix binary -label clocl_adc_10 /adc_clk_10_logic
add wave -radix binary -label clocl_1_50 /max10_clk1_50_logic
#add wave -radix binary -label clocl_2_50 /max10_clk2_50_logic

#------------------------------------------------------------------------------------------
#SEVENSEGARRAY
add wave -radix dec -label sva_data /de0_lite_vhd/sevenSegArray_data_integer
add wave -radix binary -label sva_hex0 /de0_lite_vhd/sevenSegArray_HEX0_logic_vector
add wave -radix binary -label sva_hex1 /de0_lite_vhd/sevenSegArray_HEX1_logic_vector
add wave -radix binary -label sva_hex2 /de0_lite_vhd/sevenSegArray_HEX2_logic_vector
add wave -radix binary -label sva_hex3 /de0_lite_vhd/sevenSegArray_HEX3_logic_vector
add wave -radix binary -label sva_hex4 /de0_lite_vhd/sevenSegArray_HEX4_logic_vector
add wave -radix binary -label sva_hex5 /de0_lite_vhd/sevenSegArray_HEX5_logic_vector

#------------------------------------------------------------------------------------------
#HEX2DIG
add wave -radix binary -label hex2dig_clock_logic /de0_lite_vhd/sevenSegArray_vhd/hex2dig_clock_logic
add wave -radix dec -label hex2dig_data_logic_vector /de0_lite_vhd/sevenSegArray_vhd/hex2dig_vhd/hex2dig_data_logic_vector

add wave -radix dec -label prob_dig0_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(0)
add wave -radix dec -label prob_dig1_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(1)
add wave -radix dec -label prob_dig2_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(2)
add wave -radix dec -label prob_dig3_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(3)
add wave -radix dec -label prob_dig4_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(4)
add wave -radix dec -label prob_dig5_integer /de0_lite_vhd/sevenSegArray_vhd/sevenSegROM_q_logic_vector_array(5)

add wave -radix dec -label prob_dig0_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig0_integer
add wave -radix dec -label prob_dig1_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig1_integer
add wave -radix dec -label prob_dig2_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig2_integer
add wave -radix dec -label prob_dig3_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig3_integer
add wave -radix dec -label prob_dig4_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig4_integer
add wave -radix dec -label prob_dig5_integer /de0_lite_vhd/sevenSegArray_vhd/hex2dig_dig5_integer
#------------------------------------------------------------------------------------------
#SEVENSEG
add wave -radix binary -label hex0 /hex0_logic_vector
add wave -radix binary -label hex1 /hex1_logic_vector
add wave -radix binary -label hex2 /hex2_logic_vector
add wave -radix binary -label hex3 /hex3_logic_vector
add wave -radix binary -label hex4 /hex4_logic_vector
add wave -radix binary -label hex5 /hex5_logic_vector

#------------------------------------------------------------------------------------------
run 100ns

wave zoomfull
write wave wave.ps