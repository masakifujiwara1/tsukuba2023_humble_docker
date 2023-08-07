FROM osrf/ros:humble-desktop-full-jammy

WORKDIR /home
ENV HOME /home

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# install GLX-Gears
RUN apt-get update && apt-get install -y --no-install-recommends mesa-utils x11-apps && rm -rf /var/lib/apt/lists/*

# install vim
RUN apt-get update && apt-get install -y vim cheese

# set ros2 workspace
RUN mkdir -p ~/ros2_ws/src && cd ~/ros2_ws/src && git clone https://github.com/masakifujiwara1/adi_driver2.git
RUN /bin/sh -c '. /opt/ros/humble/setup.sh; cd ~/ros2_ws ; colcon build'
# RUN source ~/ros2_ws/install/setup.bash