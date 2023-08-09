FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

WORKDIR /home
ENV HOME /home

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Tokyo

# install vim
RUN apt-get update -qq
RUN apt-get install -y tzdata
RUN apt-get update && apt-get install -y vim git lsb-release sudo gnupg htop gedit tmux

# install python3
RUN apt-get install -y python3 python3-pip

# install pytorch
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# ros2 humble setup
RUN git clone --depth 1 https://github.com/ryuichiueda/ros2_setup_scripts
RUN ./ros2_setup_scripts/setup.bash -xv

SHELL ["/bin/bash", "-c"]

# set ros2 workspace
RUN . /opt/ros/humble/setup.sh
RUN mkdir -p ~/ros2_ws/src && cd ~/ros2_ws/src && git clone https://github.com/masakifujiwara1/adi_driver2.git && git clone -b foxy-devel https://github.com/haruyama8940/icart_mini_driver && git clone https://github.com/openspur/yp-spur && git clone https://github.com/ros2/teleop_twist_joy
RUN . /opt/ros/humble/setup.sh; cd ~/ros2_ws && colcon build --symlink-install
# RUN colcon build --symlink-install
RUN source /opt/ros/humble/setup.bash && source ~/ros2_ws/install/local_setup.bash

COPY config/.bashrc ~/.bashrc
COPY config/.vimrc ~/.vimrc