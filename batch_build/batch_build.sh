#!/usr/bin/env bash

# check argument, which should be a list of case folders
if ! [[ -n "$1" ]]; then
    echo Usage: $0 /path/to/case/one /path/to/case/two ...
    exit 1
fi

name=clm_hydroparameter_calibration/batch_build

# slurm logs will go to this directory
workdir=$SCRATCH/$name

# setup the working directory
rm -rf $workdir/*
mkdir -p $workdir

# copy the batch script
cp ./batch_build.sl $workdir/

# create a list of the cases
for c in "$@"; do
    echo $c >> $workdir/cases.txt
done

# submit the job
cd $workdir
sbatch --array=1-$# batch_build.sl $workdir/cases.txt

echo "Check the task logs at: $workdir"
