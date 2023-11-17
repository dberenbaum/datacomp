#!/bin/bash
# This is saved in s3://dvcx-datacomp-sandbox-workspace/init_env.sh
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.10 python3.10-dev
