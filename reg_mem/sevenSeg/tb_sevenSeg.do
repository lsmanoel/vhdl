
#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seven_segment_ctrl.vhd
vcom tb_sevenSeg.vhd

#Simula
vsim -t ns work.testbench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary -label value /value
add wave -radix binary -label y /y

run 1000ns

wave zoomfull
write wave wave.ps

 
