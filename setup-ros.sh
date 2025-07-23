#!/bin/bash
ROS_DISTRO=$(ls /opt/ros)

sudo apt update
sudo apt install ros-${ROS_DISTRO}-leo -y
sudo apt install ros-${ROS_DISTRO}-realsense2-description -y
sudo apt install ros-${ROS_DISTRO}-rqt-image-view -y
sudo apt install ros-${ROS_DISTRO}-compressed-image-transport -y