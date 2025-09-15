#!/bin/bash
rm -f vsim.wlf transcript *.vcd wlftjd*

vlib work
vlog ../components/alu_pkg.sv
vlog -sv +acc=rn ../components/*.sv

if [ "$#" -eq 0 ]; then
    vsim -l sim.log -c -do sim.do
elif [ "$1" == "gui" ]; then
    vsim -l sim.log -do sim.do
else
    echo "----------------------------------------"
    echo "SCRIPT ERROR: Invalid argument. Use 'gui' for GUI mode or no argument for console mode."
    echo "----------------------------------------"
    exit 1
fi
