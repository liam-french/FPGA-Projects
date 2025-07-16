#!/bin/bash

cd assembler
echo "----------------------------------------"
echo "Running python assembler..."
echo "----------------------------------------"
python assembler.py
mv instructions.mem ../instructions.mem
cd ..
cd sim
echo "----------------------------------------"
echo "Running simulation..."
echo "----------------------------------------"
if [ "$#" -eq 0 ]; then
    bash run.sh
elif [ "$1" == "gui" ]; then
    bash run.sh gui
else
    echo "----------------------------------------"
    echo "SCRIPT ERROR: Invalid argument. Use 'gui' for GUI mode or no argument for console mode."
    echo "----------------------------------------"
    exit 1
fi
echo "----------------------------------------"
echo "Simulation complete. Moving log files..."
echo "----------------------------------------"
mv sim.log ../sim.log
mv memory_write.log ../memory_write.log