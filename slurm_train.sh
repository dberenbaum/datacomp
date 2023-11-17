#!/bin/bash

# Change these!
#SBATCH --partition=queue1
#SBATCH --job-name=train
#SBATCH --output=/mnt/efs/logs/%x_%j.out
#SBATCH --error=/mnt/efs/logs/%x_%j.err
#SBATCH --comment=first-try
#SBATCH --open-mode=append
#SBATCH --requeue

# Example usage:
# sbatch slurm_train.sh
# Run using conda and make sure to have the conda env activated when running sbatch.


module load openmpi
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
echo go $COUNT_NODE
echo $HOSTNAMES

# Change these as needed!
DATA_PATH=$1
SCALE="small"
SEED=0
OUTPUT_DIR="."
NUM_CHECKPOINTS=8
EXP_NAME=$2
PRECISION="amp"  # We recommend using amp_bfloat16 if supported by your hardware.
if [ "$SCALE" == "xlarge" ]; then
    PRECISION="amp_bfloat16" # amp results in a significant performance drop at xlarge scale
fi

# Change comment as needed
srun --comment "<comment>" --cpu_bind=v --accel-bind=gn \
    /mnt/efs/datacomp/.venv/bin/python train.py \
    --scale ${SCALE} \
    --data_dir ${DATA_PATH} \
    --output_dir ${OUTPUT_DIR} \
    --exp_name ${EXP_NAME} \
    --precision ${PRECISION} \
    --num_checkpoints ${NUM_CHECKPOINTS} \
    --seed ${SEED} \
    --accum_freq 1
