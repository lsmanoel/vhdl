#Cria Biblioteca
vlib work

#Compila Projeto
vcom waveROM_package.vhd
vcom waveROM32n.vhd
vcom tb_waveROM.vhd

#Simula
vsim -t ns work.tb_waveROM

#Mosta forma de onda
view wave

#Adiciona ondas específicas
#radix: binary, hex, dec
#label: nome da forma de onda

#------------------------------------------------------------------------------------------
#CLOCK
add wave -radix binary -label clocl_1_50 /clk1_50_logic
add wave -radix binary -label clocl_2_50 /clk2_50_logic


#------------------------------------------------------------------------------------------
run 1000ns

wave zoomfull
write wave wave.ps