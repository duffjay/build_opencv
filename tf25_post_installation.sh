# build_opencv  - post installation
#
# ASSUMES
# - you have Anconda installed
# - opencv code present (you'll pull to get an update)
#   git clone https://github.com/opencv/opencv.git
# - opencv_contrib present (you'll pull)
#   git clone https://github.com/opencv/opencv_contrib.git
#
cd /project/opencv
git pull
cd /project/opencv_contrib
git pull


# run this ONCE after doing an image
# cd /project/docker/build_opencv/
# bash tf25_post_installation.sh

# from /project/docker/build_opencv

# ASSUME Anaconda is already installed
# cd ~/Downloads
# wget -O install_anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
# bash install_anaconda.sh -bu

# do NOT automatically activate conda
conda config --set auto_activate_base false
# To initialize your shell, run
source ~/anaconda3/etc/profile.d/conda.sh
conda update -y -n base -c defaults conda
conda init --all --dry-run --verbose

# environment for OpenCV
# - tensorflow 2.5
# - python 3.8
conda create -y -n tf25_38_cv python=3.8
conda activate tf25_38_cv


pip install numpy

# get to the project
# - deletes build directory every time!!
cd /project/opencv
rm -rf build
mkdir build
cd build

# what to change
# OPENCV_PYTHON3_INSTALL_PATH
# PYTHON_EXECUTABLE
# OPENCV_EXTRA_MODULES_PATH

# cmake options
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D WITH_TBB=ON \
-D ENABLE_FAST_MATH=1 \
-D CUDA_FAST_MATH=1 \
-D WITH_CUBLAS=1 \
-D WITH_CUDA=ON \
-D BUILD_opencv_cudacodec=OFF \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON \
-D CUDA_ARCH_BIN=7.5 \
-D WITH_V4L=ON \
-D WITH_QT=OFF \
-D WITH_OPENGL=ON \
-D WITH_GSTREAMER=ON \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_PC_FILE_NAME=opencv.pc \
-D OPENCV_ENABLE_NONFREE=ON \
-D OPENCV_PYTHON3_INSTALL_PATH=~/anaconda3/envs/tf25_38_cv/lib/python3.8/site-packages/ \
-D PYTHON_EXECUTABLE=~/anaconda3/envs/tf25_38_cv/bin/python \
-D OPENCV_EXTRA_MODULES_PATH=/project/opencv_contrib/modules \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D INSTALL_C_EXAMPLES=OFF \
-D BUILD_EXAMPLES=OFF ..
