#!/bin/bash
#SBATCH --job-name=restnet50     ## job name
#SBATCH --nodes=2                ## 索取 2 節點
#SBATCH --ntasks-per-node=8      ## 每個節點運行 8 srun tasks
#SBATCH --cpus-per-task=4        ## 每個 srun task 索取 4 CPUs
#SBATCH --gres=gpu:8             ## 每個節點索取 8 GPUs
#SBATCH --account=$project_ID    ## PROJECT_ID 請填入計畫ID(ex: MST108XXX)，扣款也會根據此計畫ID
#SBATCH --partition=gtest        ## gtest 為測試用 queue，後續測試完可改 gp1d(最長跑1天)、gp2d(最長跑2天)、gp4d(最長跑4天)
    
module purge
module load singularity
    
SIF=/work/TWCC_cntr/pytorch_20.09-py3_horovod.sif
SINGULARITY="singularity run --nv $SIF"
    
# pytorch horovod restnet50 script from
# wget https://raw.githubusercontent.com/horovod/horovod/master/examples/pytorch/pytorch_imagenet_resnet50.py
HOROVOD="python pytorch_imagenet_resnet50.py --train-dir resnet50-demo/train --val-dir resnet50-demo/val --epochs 2 "
    
# enable NCCL log
export NCCL_DEBUG=INFO
    
srun $SINGULARITY $HOROVOD
