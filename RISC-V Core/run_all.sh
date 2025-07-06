#!/bin/bash

cd python_if
echo "Running assembler..."
python assembler.py
mv instructions.mem ../instructions.mem
cd ..
cd sim
echo "Running simulation..."
bash run.sh
mv memory_write.log ../memory_write.log