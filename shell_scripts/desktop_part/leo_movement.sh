#!/bin/bash
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/podman/bin:$PATH
xhost +si:localuser:$USER


## Running shell script with joy teleoperation roslaunch in ubuntu 20.04 distrobox image
SCRIPT_PATH=@@REPO_PATH@@/shell_scripts/ros_part/joy_teleop.sh
distrobox enter @@CONTAINER_NAME@@ -- ${SCRIPT_PATH}

## Killing terminal left after the script finished executing (needed only when the .desktop file has option Terminal set to True)
# kill -9 $PPID