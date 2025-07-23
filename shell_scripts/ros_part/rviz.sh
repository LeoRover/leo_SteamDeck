#!/bin/bash
export ROS_MASTER_URI=http://master.lan:11311
export ROS_IP=$(hostname -I | xargs)
ROS_DISTRO=$(ls /opt/ros)
source /opt/ros/${ROS_DISTRO}/setup.bash

## Launching teleoperation nodes with custom config for steam deck axes mapping
CONFIG_FILE=@@REPO_PATH@@/configs/steam_deck_config.yaml
roslaunch leo_teleop joy_teleop.launch joy_config_file:=${CONFIG_FILE} &
LAUNCH_BACK_PID=$!

## Running Rviz with config file provided as command line argument
rviz -d $1 &
RVIZ_BACK_PID=$!

## Waiting for Rviz close
wait $RVIZ_BACK_PID
echo "Rviz closed"

## Killing the node responsible for joy controll
echo "Killing launch nodes"
kill $LAUNCH_BACK_PID

## Without the kill command on PID we need to kill the nodes manually
#rosnode kill /joy_node
#rosnode kill /joy_teleop_node