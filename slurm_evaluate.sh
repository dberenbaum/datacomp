#!/bin/bash

#SBATCH -p queue1
#SBATCH -J "eval"
#SBATCH -e "/mnt/efs/logs/%x_%j.err"
#SBATCH -o "/mnt/efs/logs/%x_%j.out"
#SBATCH --requeue

TRAIN_OUTPUT_DIR=$1
DATA_DIR=$2
OUTPUT_DIR=$3

# Run evaluation

/mnt/efs/datacomp/.venv/bin/python evaluate.py \
	--train_output_dir $TRAIN_OUTPUT_DIR \
	--data_dir $DATA_DIR \
	--output_dir $OUTPUT_DIR \
	--submit --method_name="foo" --author="bar" --email="a@b.com" \
	--hf_username=baz --hf_repo_name=qux

echo "finished evaluation"
