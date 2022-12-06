#!/bin/bash
#SBATCH --job-name=TWCC-Hands-on-ResNet50
#SBATCH --nodes=2                ## 索取 2 節點
#SBATCH --ntasks-per-node=1      ## 每個節點運行 8 srun tasks
#SBATCH --cpus-per-task=1        ## 每個 srun task 索取 4 CPUs
#SBATCH --gres=gpu:1             ## 每個節點索取 8 GPUs
#SBATCH --account=ent211343      ## PROJECT_ID 請填入計畫ID(ex: MST108XXX)，扣款也會根據此計畫ID
#SBATCH --partition=gpENT211343  ## gtest 為測試用 queue，後續測試完可改 gp1d(最長跑1天)、gp2d(最長跑2天)、gp4d(最長跑4天)
    
module purge
module load singularity
    
srun singularity exec --nv /work/TWCC_cntr/tensorflow_20.09-tf1-py3.sif python tensorflow_synthetic_benchmark.py --model ResNet50 --batch-size 256
