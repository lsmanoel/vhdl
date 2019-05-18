#Cria Biblioteca
vlib work

#Compila Projeto
vcom reg3232.vhd
vcom sevenSeg.vhd
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
#add wave -radix binary -label clocl_adc_10 /adc_clk_10
#add wave -radix binary -label clocl_1_50 /max10_clk1_50
#add wave -radix binary -label clocl_2_50 /max10_clk2_50

#------------------------------------------------------------------------------------------
add wave -radix hex -label sw_3_downto_0 /de0_lite_vhd/sw(3:0)
add wave -radix dec -color orange -label reg32n_data_logic_vector /de0_lite_vhd/reg32n_data_logic_vector

add wave -radix hex -label sw_7_downto_4 /de0_lite_vhd/sw(7:4)
add wave -radix dec -color orange -label reg32n_write_addreshex /de0_lite_vhd/reg32n_write_address_integer
add wave -radix dec -color orange -label reg32n_read_addresshex /de0_lite_vhd/reg32n_read_address_integer

add wave -radix binary -label sw_8 /de0_lite_vhd/sw(8)
add wave -radix binary -label sw_9 /de0_lite_vhd/sw(9)

#------------------------------------------------------------------------------------------
#add wave -radix dec -label sevenSeg_seg_in_0 /de0_lite_vhd/sevenSeg_seg_in(0)
#add wave -radix dec -label sevenSeg_seg_in_1 /de0_lite_vhd/sevenSeg_seg_in(1)
#add wave -radix dec -label sevenSeg_seg_in_2 /de0_lite_vhd/sevenSeg_seg_in(2)
#add wave -radix dec -label sevenSeg_seg_in_3 /de0_lite_vhd/sevenSeg_seg_in(3)
#add wave -radix dec -label sevenSeg_seg_in_4 /de0_lite_vhd/sevenSeg_seg_in(4)
#add wave -radix dec -label sevenSeg_seg_in_5 /de0_lite_vhd/sevenSeg_seg_in(5)

#add wave -radix binary -label hex0 /de0_lite_vhd/hex0
#add wave -radix binary -label hex1 /de0_lite_vhd/hex1
#add wave -radix binary -label hex2 /de0_lite_vhd/hex2
#add wave -radix binary -label hex3 /de0_lite_vhd/hex3
#add wave -radix binary -label hex4 /de0_lite_vhd/hex4
#add wave -radix binary -label hex5 /de0_lite_vhd/hex5

#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps