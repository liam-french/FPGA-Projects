vsim -voptargs=+acc=rn work.core_top_tb

# Log all signals recursively
log -r /*

# Optional: also dump to .vcd for GTKWave
vcd file dump.vcd
vcd add -r /*

# Run simulation
run -all

# Quit (automatically writes vsim.wlf)
quit -f
