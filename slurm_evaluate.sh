#!/bin/bash

#SBATCH -p queue1
#SBATCH -J "eval"
#SBATCH -e "/mnt/efs/logs/%x_%j.err"
#SBATCH -o "/mnt/efs/logs/%x_%j.out"
#SBATCH --requeue

TRAIN_OUTPUT_DIR=$1
DATA_DIR=$2
OUTPUT_DIR=$3

# Setup env
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.10-dev python3.10-venv
source ./.venv/bin/activate

# Run evaluation

python evaluate.py \
	--train_output_dir $TRAIN_OUTPUT_DIR \
	--data_dir $DATA_DIR \
	--output_dir $OUTPUT_DIR \
	--submit --method_name="foo" --author="bar" --email="a@b.com" \
	--hf_username=baz --hf_repo_name=qux

echo "finished evaluation"