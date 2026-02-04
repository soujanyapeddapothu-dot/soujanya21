vlib work
vlog list.svh 
vsim -novopt -suppress 12110 top -assertdebug \
+test_name=nwr_nrd +n=4
add wave -position insertpoint sim:/top/pif/*
do wave.do
run -all
