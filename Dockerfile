FROM nvidia/cuda:8.0-cudnn6-devel

# set up environment
ENV DEBIAN_FRONTEND noninteractive

# update repos/ppas...
RUN apt-get update 
RUN apt-get install -y python-software-properties software-properties-common curl
RUN apt-add-repository -y ppa:x2go/stable
RUN apt-get update 

# install core packages
RUN apt-get install -y python-pip git
RUN apt-get install -y python-matplotlib python-scipy python-numpy
RUN apt-get install -y python-opencv

# install python packages
RUN pip install --upgrade pip
RUN pip install --upgrade ipython[all]
RUN pip install pyyaml
# RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0rc0-cp27-none-linux_x86_64.whl
RUN export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64"
RUN export CUDA_HOME=/usr/local/cuda
RUN pip install tensorflow-gpu
# set up gnuradio and related toolsm
RUN apt-get install -y sudo

# check out sources for reference
RUN mkdir /root/src/

# Gym deps
RUN apt-get install -y python-dev cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig pypy-dev automake autoconf libtool

# set up OpenAI Gym
RUN cd /root/src/ && git clone https://github.com/openai/gym.git && cd gym && pip install -e .
RUN pip install gym[atari] pachi_py
RUN mkdir /workspace

# pytorch
RUN pip install -U numpy
RUN pip install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp27-cp27mu-manylinux1_x86_64.whl 
RUN pip install torchvision


# # pytorch
# WORKDIR /
# RUN git clone https://github.com/pytorch/pytorch.git
# WORKDIR /pytorch
# RUN git submodule update --init
# RUN python setup.py install

