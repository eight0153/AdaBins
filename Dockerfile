# enables cuda support in docker
FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

# install python 3.6, pip and requirements for opencv-python
# (see https://github.com/NVIDIA/nvidia-docker/issues/864)
RUN apt-get update && apt-get -y install \
    python3 \
    python3-pip \
    libsm6 \
    libxext6 \
    libxrender-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# install python dependencies
RUN pip3 install --upgrade pip
RUN pip3 install  --no-cache-dir torch~=1.8 torchvision pillow numpy tqdm matplotlib scipy gdown

# Download basemodel
COPY download_basemodel.py .
RUN python3 download_basemodel.py && \
    gdown --id 1lvyZZbC9NLcS8a__YPcUP7rDiIpbRpoF && mkdir pretrained && mv AdaBins_nyu.pt pretrained/AdaBins_nyu.pt

