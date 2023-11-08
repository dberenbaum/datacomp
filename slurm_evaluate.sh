#!/bin/bash

#SBATCH -p queue1
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH -G 1
#SBATCH -J "eval"
#SBATCH --mem 32G
#SBATCH -e "/mnt/efs/logs/%x_%j.err"
#SBATCH -o "/mnt/efs/logs/%x_%j.out"
#SBATCH --requeue
#SBATCH --constraint p3.2xlarge

TRAIN_OUTPUT_DIR=$1
DATA_DIR=$2
OUTPUT_DIR=$3

# Setup env
sudo apt install -y python3.9-dev python3.9-venv
source ./.venv/bin/activate

# Run evaluation

python evaluate.py \
	--train_output_dir $TRAIN_OUTPUT_DIR \
	--data_dir $DATA_DIR \
	--output_dir $OUTPUT_DIR \
	--submit --method_name="foo" --author="bar" --email="a@b.com" \
	--hf_username=baz --hf_repo_name=qux

echo "finished evaluation"