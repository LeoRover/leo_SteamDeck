#!/bin/bash
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/podman/bin:$PATH
xhost +si:localuser:$USER


## Running shell script with joy teleoperation + rviz in ubuntu 20.04 distrobox image
LIDAR_RVIZ_CONFIG=@@REPO_PATH@@/configs/rviz/lidar_config.rviz
SCRIPT_PATH=@@REPO_PATH@@/shell_scripts/ros_part/rviz.sh
distrobox enter @@CONTAINER_NAME@@ -- ${SCRIPT_PATH} ${LIDAR_RVIZ_CONFIG}

## Killing terminal left after the script finished executing (needed only when the .desktop file has option Terminal set to True)
# kill -9 $PPID