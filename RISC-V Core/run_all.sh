#!/bin/bash

cd python_if
echo "Running assembler..."
python assembler.py
mv instructions.mem ../instructions.mem
cd ..
cd sim
echo "Running simulation..."
bash run.sh
echo "Simulation complete. Moving log files..."
mv sim.log ../sim.log
mv memory_write.log ../memory_write.log