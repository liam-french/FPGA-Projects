#!/bin/bash

# Create and map the work library
vlib work

# Compile your sources
vlog -sv ../components/*.sv ../components/*.vh

# Launch simulation in command-line mode and execute sim.do
vsim -c -l sim.log work.core_top_tb -do sim.do