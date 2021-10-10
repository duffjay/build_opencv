# CUDA 11.2.2  cuDNN 8  Ubuntu 20.04
# - expecting nvidia-docker
#
# docker build -t build_opencv:tf25 .
# https://gist.github.com/raulqf/f42c718a658cddc16f9df07ecc627be7

FROM nvidia/cuda:11.2.2-cudnn8-devel-ubuntu20.04

# this will eliminate interactive dialog on installation steps
ARG DEBIAN_FRONTEND=noninteractive

MAINTAINER jduff <duffjay@gmail.com>

# Install updates and upgrade your system
RUN apt-get update && apt-get install -y 
RUN apt-get install -y apt-utils
RUN apt-get install -y sudo
RUN apt-get install -y wget

# Install required libraries
RUN apt-get install -y build-essential cmake pkg-config unzip yasm git checkinstall
RUN apt-get install -y libjpeg-dev libpng-dev libtiff-dev
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libavresample-dev 
RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
RUN apt-get install -y libxvidcore-dev x264 libx264-dev libfaac-dev libmp3lame-dev libtheora-dev  
RUN apt-get install -y libfaac-dev libmp3lame-dev libvorbis-dev

RUN apt-get install -y libopencore-amrnb-dev libopencore-amrwb-dev

RUN apt-get install -y libdc1394-22 libdc1394-22-dev libxine2-dev libv4l-dev v4l-utils 
RUN cd /usr/include/linux 
RUN ln -s -f ../libv4l1-videodev.h videodev.h 
RUN cd ~

RUN apt-get install -y libgtk-3-dev

# python 3.8 -- to match current object detection
# use anaconda -- to match  current object detection
RUN apt-get install -y python3.8
RUN apt-get install -y python3.8-dev 
RUN apt-get install -y python3-pip 
RUN apt-get install -y python3-testresources

# -- installed 3.8 only -- 
# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 3
RUN update-alternatives  --set python /usr/bin/python3.8

# C++ Parallellism
RUN apt-get install -y libtbb-dev
# Optimization
RUN apt-get install -y libatlas-base-dev gfortran

# Optional
RUN apt-get install -y libprotobuf-dev protobuf-compiler 
RUN apt-get install -y libgoogle-glog-dev libgflags-dev 
RUN apt-get install -y libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

RUN python -m pip install --upgrade pip


CMD ["echo", "run post installation script"]
