Submit a collection of CLM cases to be built in parallel on compute nodes.

To use:

* Create your case folders using other scripts available in this repository. All the cases should be contained in one parent directory.
* Consider how many nodes and how much walltime you need. It takes about 5 minutes to build one case on one CPU of one node. Each KNL node has 64 CPUs, so you can theoretically build 64 cases per 5 minutes per node. The orchestration process needs one entire node for itself as well. So as an example, to build 512 cases in 5 minutes, you would need 9 nodes (1 + 512 / 64). Alternatively, to build 512 cases in an hour, you would just need 2 nodes (1 + (512 / 64) / (60 / 5) rounded up). You should leave some buffer room in your estimation though.
* Update the requested nodes and walltime in the `submit_taskfarmer.sl` file based on your decisions. The `-N` option controls the number of nodes and the `-t` option controls the walltime (in format hh:mm:ss).
* Submit the job with the command `./build_cases.sh /path/to/parent/directory`, updating the path appropriately.
* This will empty and recreate the directory `$SCRATCH/taskfarmer/build_cases`, which will have information about the job once it starts running.

