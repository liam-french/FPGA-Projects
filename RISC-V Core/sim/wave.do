onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /core_top_tb/uut/data_mem/data_mem
add wave -noupdate -radix hexadecimal -childformat {{{/core_top_tb/uut/reg_file/registers[0]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[1]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[2]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[3]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[4]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[5]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[6]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[7]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[8]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[9]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[10]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[11]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[12]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[13]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[14]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[15]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[16]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[17]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[18]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[19]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[20]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[21]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[22]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[23]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[24]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[25]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[26]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[27]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[28]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[29]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[30]} -radix hexadecimal} {{/core_top_tb/uut/reg_file/registers[31]} -radix hexadecimal}} -subitemconfig {{/core_top_tb/uut/reg_file/registers[0]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[1]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[2]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[3]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[4]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[5]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[6]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[7]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[8]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[9]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[10]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[11]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[12]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[13]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[14]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[15]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[16]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[17]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[18]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[19]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[20]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[21]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[22]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[23]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[24]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[25]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[26]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[27]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[28]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[29]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[30]} {-height 15 -radix hexadecimal} {/core_top_tb/uut/reg_file/registers[31]} {-height 15 -radix hexadecimal}} /core_top_tb/uut/reg_file/registers
add wave -noupdate /core_top_tb/uut/imem/read_addr
add wave -noupdate /core_top_tb/uut/imem/instruction
add wave -noupdate -expand -group UUT /core_top_tb/uut/clk_i
add wave -noupdate -expand -group UUT /core_top_tb/uut/reset_i
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/instruction
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/funct3
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/funct7
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/instruction_addr
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/next_addr
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/instruction_addr_trimmed
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/next_addr_trimmed
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/branch_addr
add wave -noupdate -expand -group UUT -group Addresses -radix hexadecimal /core_top_tb/uut/inc_addr
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/MemRead
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/MemWrite
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/MemtoReg
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/Branch
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/ALUSrc
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/RegWrite
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/Zero
add wave -noupdate -expand -group UUT -group {Control Signals} -radix hexadecimal /core_top_tb/uut/ALUOp
add wave -noupdate -expand -group UUT -group {ALU Signals} -radix hexadecimal /core_top_tb/uut/reg_data1
add wave -noupdate -expand -group UUT -group {ALU Signals} -radix hexadecimal /core_top_tb/uut/alu_in
add wave -noupdate -expand -group UUT -group {ALU Signals} -radix hexadecimal /core_top_tb/uut/Result
add wave -noupdate -expand -group UUT -group {ALU Signals} -radix hexadecimal /core_top_tb/uut/ALUCtl
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/data_mem_out
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/addr_trimmed
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/rs1
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/rs2
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/rd
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/reg_data2
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/write_data
add wave -noupdate -expand -group UUT -radix hexadecimal /core_top_tb/uut/immediate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {69 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 376
configure wave -valuecolwidth 195
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {56 ns} {73 ns}
