#!/bin/bash

SCRIPT_DIR=$(pwd)

echo "--------------------------------------------------------------------------------"
echo "Running python assembler..."
echo "--------------------------------------------------------------------------------"

cd assembler
python assembler.py
mv instructions.mem ../instructions.mem

echo "--------------------------------------------------------------------------------"
echo "Running simulation..."
echo "--------------------------------------------------------------------------------"

cd ..
cd sim

if [ "$#" -eq 0 ]; then
    bash run.sh
elif [ "$1" == "gui" ]; then
    bash run.sh gui
else
    echo "--------------------------------------------------------------------------------"
    echo "SCRIPT ERROR: Invalid argument. Use 'gui' for GUI mode or no argument for console mode."
    echo "--------------------------------------------------------------------------------"
    exit 1
fi

echo "--------------------------------------------------------------------------------"
echo "Simulation complete. Moving log files..."
echo "--------------------------------------------------------------------------------"

mkdir -p ../output
mv sim.log ../output/sim.log
mv memory_write.log ../output/memory_write.log

cd $SCRIPT_DIR

mv instructions.mem output/instructions.mem