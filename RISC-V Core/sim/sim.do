# Create and map the work library
vlib work

# Compile your sources
vlog -sv +acc=rn ../components/*.sv ../components/*.vh

# Launch simulation and write VCD
vsim -debugDB -voptargs=+acc -do {
    do wave.do
    vcd file dump.vcd
    vcd add -r /*
    run 1100
    view wave
} work.core_top_tb
