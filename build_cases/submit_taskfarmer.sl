#!/bin/sh
#SBATCH -N 4 -c 272
#SBATCH -q regular
#SBATCH -t 02:00:00
#SBATCH -C knl

cd $SCRATCH/taskfarmer/build_cases
export THREADS=64

runcommands.sh tasks.txt

