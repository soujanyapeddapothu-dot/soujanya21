vlib work
vlog list.svh
vopt top +cover=fcbest -o nwr_nrd 
vsim -coverage nwr_nrd  +test_name=nwr_nrd  +n=16
coverage save -onexit nwr_nrd.ucdb
do exclusion.do
add wave -r sim:/top/pif/*
run -all



