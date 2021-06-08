#!/usr/bin/env bash

# check argument, which should be a path to a directory with case folders
if [[ -n "$1" ]]; then
    # make sure this is a path that exists
    if [ -d "$1" ]; then
        echo "Submitting build job for all subfolders in $1"
    else
        echo "Folder $1 does not exist; exiting."
	exit 1
    fi
else
    echo Usage: $0 /path/to/folder/with/cases
    exit 1
fi

# taskfarmer will work in this directory
workdir=$SCRATCH/taskfarmer/build_cases

# setup the working directory
rm -rf $workdir/*
mkdir -p $workdir
cp ./wrapper.sh $workdir/
cp ./submit_taskfarmer.sl $workdir/

# generate a list of the case folders based on the input
ls -d1 $1/*/ > $workdir/tasks.txt
# prepend the wrapper command to each task
sed -i -e "s;^;$workdir/wrapper.sh ;" $workdir/tasks.txt
# prepend the bash header to the file
sed -i '1s;^;#!/usr/bin/env bash\n;' $workdir/tasks.txt

# submit the taskfarmer job
module load taskfarmer
cd $workdir
sbatch submit_taskfarmer.sl

echo "Check the status of the taskfarmer at: $workdir"
