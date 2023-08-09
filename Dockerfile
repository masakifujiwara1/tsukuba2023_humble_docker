FROM dustynv/ros:humble-desktop-l4t-r35.4.1

WORKDIR /home
ENV HOME /home

# install vim
RUN apt-get update && apt-get install -y vim

# set ros2 workspace
RUN mkdir -p ~/ros2_ws/src && cd ~/ros2_ws/src && git clone https://github.com/masakifujiwara1/adi_driver2.git && git clone -b foxy-devel https://github.com/haruyama8940/icart_mini_driver && git clone https://github.com/openspur/yp-spur && git clone https://github.com/ros2/teleop_twist_joy
RUN /bin/sh -c '. /opt/ros/humble/install/setup.sh; cd ~/ros2_ws ; colcon build --symlink-install '
RUN source /opt/ros/humble/install/setup.bash && source ~/ros2_ws/install/setup.bash

COPY config/.bashrc ~/.bashrc
COPY config/.vimrc ~/.vimrc