#!/bin/bash
#SBATCH --job-name=1cpu_gptune
#SBATCH --account=perfopt
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --time=24:00:00
#SBATCH --output=stdout_gptune_dtla_run1_seed.%j

# module load nvhpc/21.5-oxhtyof
source /soft/anaconda3/2020.02/etc/profile.d/conda.sh
source activate /home/jkoo/.conda/envs/gptune/
cd ~/spack
. share/spack/setup-env.sh 
spack load gptune 
cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/syr2k_exp/syr2k_gptune_dtla
# rm -rf ./tmp_results*
# rm -rf ./tmp_files*
#################################
################################# 
cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/syr2k_exp/syr2k_gptune_dtla
# rm -rf ./tmp_results*
# rm -rf ./tmp_files*
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize sm -kernel_name syr2k -nparam 6 -param_start 0 -target sm -itarget 130 160 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 2022
mkdir ./TLA_experiments/SLA-GPTune-sm-tl_init_2022/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-sm-tl_init_2022/ 
mv tmp_files tmp_files_dtla_sm_init
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize ml -kernel_name syr2k -nparam 6 -param_start 0 -target ml -itarget 600 720 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 2022 
mkdir ./TLA_experiments/SLA-GPTune-ml-tl_init_2022/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-ml-tl_init_2022/
mv tmp_files tmp_files_dtla_ml_init
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize xl -kernel_name syr2k -nparam 6 -param_start 0 -target xl -itarget 2000 2600 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 2022 
mkdir ./TLA_experiments/SLA-GPTune-xl-tl_init_2022/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-xl-tl_init_2022/ 
mv tmp_files tmp_files_dtla_xl_init
rm -rf gptune.db
#################################
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize sm -kernel_name syr2k -nparam 6 -param_start 0 -target sm -itarget 130 160 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 9999
mkdir ./TLA_experiments/SLA-GPTune-sm-tl_init_9999/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-sm-tl_init_9999/ 
mv tmp_files tmp_files_dtla_sm_init
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize ml -kernel_name syr2k -nparam 6 -param_start 0 -target ml -itarget 600 720 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 9999 
mkdir ./TLA_experiments/SLA-GPTune-ml-tl_init_9999/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-ml-tl_init_9999/
mv tmp_files tmp_files_dtla_ml_init
#################################
# cd /lcrc/project/EE-ECP/jkoo/code/gptune/examples/XSBench_exp_gpu/xsbench-omp_gptune_dtla/offload
# mkdir ./tmp_results
rm -rf gptune.db
mkdir ./TLA_experiments
mpirun -np 1 python exec_dtla.py -nrun 30 -ntask 4 -optimization GPTune -dsize xl -kernel_name syr2k -nparam 6 -param_start 0 -target xl -itarget 2000 2600 -imin 20 30 -imax 3000 3800 -ninit 0 -seed 9999 
mkdir ./TLA_experiments/SLA-GPTune-xl-tl_init_9999/ 
mv gptune.db/* ./TLA_experiments/SLA-GPTune-xl-tl_init_9999/ 
mv tmp_files tmp_files_dtla_xl_init
rm -rf gptune.db

