vsim -voptargs=+acc=rn work.core_top_tb

# Log all signals recursively
log -r /*

vcd file dump.vcd
vcd add -r /*

do wave.do

# Run simulation
run -all
