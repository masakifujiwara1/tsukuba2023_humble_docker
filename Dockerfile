FROM dustynv/ros:humble-desktop-l4t-r35.4.1

WORKDIR /home
ENV HOME /home

# install
RUN apt-get update && apt-get install -y vim git lsb-release sudo gnupg htop gedit tmux

# set shell
SHELL ["/bin/bash", "-c"]

# set ros2 workspace
COPY config/git_clone.sh /home/git_clone.sh
RUN . /opt/ros/humble/setup.sh
RUN mkdir -p ~/ros2_ws/src && cd ~/ros2_ws && colcon build
RUN cd ~/ros2_ws/src && . /home/git_clone.sh
RUN . /opt/ros/humble/setup.sh && cd ~/ros2_ws && colcon build --symlink-install
RUN source /opt/ros/humble/setup.bash && source ~/ros2_ws/install/local_setup.bash

COPY config/.bashrc ~/.bashrc
COPY config/.vimrc ~/.vimrc