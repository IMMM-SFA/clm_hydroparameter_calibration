Submit a collection of CLM cases to be built in parallel on compute nodes.

To use:

* Create your case folders using other scripts available in this repository.
* Submit the job with the command `./batch_build.sh /glob/to/case/folders/*`, updating the glob appropriately.
* This will empty and recreate the directory `$SCRATCH/clm_hydroparameter_calibration/batch_build`, which will have a list of cases and the SLURM logs.
* The job will be submitted as a SLURM job array, so you will only see one entry in the `sqs` until jobs are running.
* Remember that the job array cannot have more than 5000 jobs, so create your glob accordingly.

