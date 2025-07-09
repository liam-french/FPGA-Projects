#!/bin/bash
rm -f vsim.wlf transcript *.vcd wlftjd*

# Build
vlib work
vlog -sv +acc=rn ../components/*.sv ../components/*.vh

# Simulate
vsim -l sim.log -c -do sim.do
