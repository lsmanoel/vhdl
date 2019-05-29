#Cria Biblioteca
vlib work

#Compila Projeto
vcom sram3232.vhd
vcom sram32n.vhd
vcom reg32.vhd
vcom reg32n.vhd
vcom sevenSeg.vhd
vcom romSevenSeg.vhd
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
add wave -radix binary -label clocl_adc_10 /adc_clk_10_logic
add wave -radix binary -label clocl_1_50 /max10_clk1_50_logic
add wave -radix binary -label clocl_2_50 /max10_clk2_50_logic

#------------------------------------------------------------------------------------------
#SW
add wave -radix binary -label sw /sw_logic_vector

#------------------------------------------------------------------------------------------
#REG3232
add wave -radix binary -label sram3232_clock_logic /de0_lite_vhd/sram3232_clock_logic
add wave -radix hex -label sram3232_data_logic_vector /de0_lite_vhd/sram3232_data_logic_vector
add wave -radix dec -label sram3232_write_address_integer /de0_lite_vhd/sram3232_write_address_integer
add wave -radix dec -label sram3232_read_address_integer /de0_lite_vhd/sram3232_read_address_integer
add wave -radix binary -label sram3232_we_logic /de0_lite_vhd/sram3232_we_logic
add wave -radix hex -label sram3232_q_logic_vector /de0_lite_vhd/sram3232_q_logic_vector

add wave -radix binary -label CLOCK /de0_lite_vhd/sram3232_vhd/CLOCK
add wave -radix hex -label DATA /de0_lite_vhd/sram3232_vhd/DATA
add wave -radix dec -label WRITE_ADDRESS /de0_lite_vhd/sram3232_vhd/WRITE_ADDRESS
add wave -radix dec -label READ_ADDRESS /de0_lite_vhd/sram3232_vhd/READ_ADDRESS
add wave -radix binary -label WE /de0_lite_vhd/sram3232_vhd/WE
add wave -radix hex -label Q /de0_lite_vhd/sram3232_vhd/Q

#------------------------------------------------------------------------------------------
#REG32n
#add wave -radix binary -label sram32n_clock_logic /de0_lite_vhd/sram32n_clock_logic
#add wave -radix hex -label sram32n_data_logic_vector /de0_lite_vhd/sram32n_data_logic_vector
#add wave -radix dec -label sram32n_write_address_integer /de0_lite_vhd/sram32n_write_address_integer
#add wave -radix dec -label sram32n_read_address_integer /de0_lite_vhd/sram32n_read_address_integer
#add wave -radix binary -label sram32n_we_logic /de0_lite_vhd/sram32n_we_logic
#add wave -radix hex -label sram32n_q_logic_vector /de0_lite_vhd/sram32n_q_logic_vector

#add wave -radix binary -label CLOCK /de0_lite_vhd/sram32n_vhd/CLOCK
#add wave -radix hex -label DATA /de0_lite_vhd/sram32n_vhd/DATA
#add wave -radix dec -label WRITE_ADDRESS /de0_lite_vhd/sram32n_vhd/WRITE_ADDRESS
#add wave -radix dec -label READ_ADDRESS /de0_lite_vhd/sram32n_vhd/READ_ADDRESS
#add wave -radix binary -label WE /de0_lite_vhd/sram32n_vhd/WE
#add wave -radix hex -label Q /de0_lite_vhd/sram32n_vhd/Q

#------------------------------------------------------------------------------------------
#SEVENSEG
add wave -radix binary -label sevenSeg_clock_logic_vector /de0_lite_vhd/sevenSeg_clock_logic_vector
add wave -radix binary -label sevenSeg_dot_logic_vector /de0_lite_vhd/sevenSeg_dot_logic_vector

#add wave -radix binary -label DOT /de0_lite_vhd/sevenSeg_vhd(0)/DOT

#add wave -radix dec -label sevenSeg_data_logic_vector_array_0 /de0_lite_vhd/sevenSeg_data_logic_vector_array(0)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_0 /de0_lite_vhd/sevenSeg_q_logic_vector_array(0)
#add wave -radix dec -label sevenSeg_data_logic_vector_array_1 /de0_lite_vhd/sevenSeg_data_logic_vector_array(1)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_1 /de0_lite_vhd/sevenSeg_q_logic_vector_array(1)
#add wave -radix dec -label sevenSeg_data_logic_vector_array_2 /de0_lite_vhd/sevenSeg_data_logic_vector_array(2)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_2 /de0_lite_vhd/sevenSeg_q_logic_vector_array(2)
#add wave -radix dec -label sevenSeg_data_logic_vector_array_3 /de0_lite_vhd/sevenSeg_data_logic_vector_array(3)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_3 /de0_lite_vhd/sevenSeg_q_logic_vector_array(3)
#add wave -radix dec -label sevenSeg_data_logic_vector_array_4 /de0_lite_vhd/sevenSeg_data_logic_vector_array(4)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_4 /de0_lite_vhd/sevenSeg_q_logic_vector_array(4)
#add wave -radix dec -label sevenSeg_data_logic_vector_array_5 /de0_lite_vhd/sevenSeg_data_logic_vector_array(5)
#add wave -radix binary -label sevenSeg_q_logic_vector_array_5 /de0_lite_vhd/sevenSeg_q_logic_vector_array(5)

add wave -radix binary -label hex0 /hex0_logic_vector
add wave -radix binary -label hex1 /hex1_logic_vector
add wave -radix binary -label hex2 /hex2_logic_vector
add wave -radix binary -label hex3 /hex3_logic_vector
add wave -radix binary -label hex4 /hex4_logic_vector
add wave -radix binary -label hex5 /hex5_logic_vector

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps