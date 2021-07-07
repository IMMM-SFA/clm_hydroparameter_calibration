#!/usr/bin/env /bin/bash
#SBATCH -q regular
#SBATCH -N 1
#SBATCH -t 00:15:00
#SBATCH -C haswell

case=`sed "${SLURM_ARRAY_TASK_ID}q;d" $1`
cd $case
./case.build
