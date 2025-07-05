# Create and map the work library
vlib work

# Compile your sources
vlog -sv +acc=rn *.sv *.vh

# Launch simulation and write VCD
vsim -voptargs=+acc -do {
    do waves.do
    vcd file dump.vcd
    vcd add -r /*                  ;# Log all signals
    run 1100
    view wave
} work.core_top_tb
