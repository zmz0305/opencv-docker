FROM arm64v8/ubuntu
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
RUN apt-get update && apt-get install -y python3 python3-distutils python3-pip python3-apt python3-numpy \
cmake g++ wget unzip \
graphviz libgl1-mesa-glx libhdf5-dev openmpi-bin \
ffmpeg libsm6 libxext6 && mkdir opencv_build
WORKDIR opencv_build
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip && unzip opencv.zip && mkdir build
WORKDIR build
RUN cmake -DPYTHON3_EXECUTABLE=/usr/bin/python3 \
-DPYTHON3_INCLUDE_DIR=/usr/include/python3.10 \
-DPYTHON3_NUMPY_INCLUDE_DIRS=/usr/lib/python3/dist-packages/numpy/core/include \
../opencv-4.x && cmake --build . -j4 && pip3 install scikit-image opencv-python matplotlib imutils
