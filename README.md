# Isaac Sim ROS & ROS2 Workspaces

This repository contains two workspaces: `noetic_ws` (ROS Noetic) and `humble_ws` (ROS2 Humble). 

[Click here for usage and installation instructions with Isaac Sim](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html)

When cloning this repository, both workspaces are downloaded. Depending on which ROS distro you are using, follow the [setup instructions](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html#setting-up-workspaces) for building your specific workspace.

using run_dev.sh from isaac-ros in isaac_ros_common repo:
1. first copy .isaac_ros_common-config file in this repo to ~/.isaac_ros_common-config
2. depending on the path or name of path_to_humble_ws/my_custom_layer, modify the ~/.isaac_ros_common-config, example below 
```
CONFIG_IMAGE_KEY="ros2_humble.mine"
CONFIG_DOCKER_SEARCH_DIRS=(workspaces/isaac_ros-dev/ros_ws/mystuff)
```
3. run run_dev.sh 
```
$PATH_TO_ISAAC_ROS_COMMON/scripts/run_dev.sh -d $PATH_TO_ROS_WORKSPACE
```

Reference: (isaac_ros_common)
https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_common/tree/main
https://nvidia-isaac-ros.github.io/concepts/docker_devenv/index.html#development-environment
