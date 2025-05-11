# Isaac Sim Docker + Isaac ROS Docker Setup Workspaces

This repo is a wrapper for setting up both **isaac-sim docker** + **isaac ros dev docker** with its example workspaces (this repo) to run the example navigation code in [isaac-sim nav example](https://docs.isaacsim.omniverse.nvidia.com/latest/ros2_tutorials/tutorial_ros2_navigation.html).

## Prerequisites 
See [Docker and Docker Nvidia Toolkit Installation]( https://docs.isaacsim.omniverse.nvidia.com/latest/installation/install_container.html) 

**References:** 
- [Docker](https://docs.docker.com/engine/install/) 
- [Docker nvidia toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 

## Isaac-sim Docker Setup 
0. Install [webrtc streaming client](https://docs.isaacsim.omniverse.nvidia.com/latest/installation/download.html#isaac-sim-latest-release) to run isaac-sim headless mode 
1. Run following commands to check your gpu driver version
	```
	docker pull nvcr.io/nvidia/isaac-sim:4.5.0
	```
2.  Run the following commands to start the docker container
	```
	docker run --name isaac_sim_container \
      --gpus '"device=0"' \
      --entrypoint bash \
      -it --rm \
      --network=host \
      -e "PRIVACY_CONSENT=Y" \
      -e "ACCEPT_EULA=Y" \
      -v /Path/to/User/docker/isaac-sim/cache/kit:/isaac-   sim/kit/cache:rw \
      -v /Path/to/User/docker/isaac-sim/cache/ov:/root/.cache/ov:rw \
      -v /Path/to/User/docker/isaac-sim/cache/pip:/root/.cache/pip:rw \
      -v /Path/to/User/docker/isaac-sim/cache/glcache:/root/.cache/nvidia/GLCache:rw \
      -v /Path/to/User/docker/isaac-sim/cache/computecache:/root/.nv/ComputeCache:rw \
      -v /Path/to/User/docker/isaac-sim/logs:/root/.nvidia-omniverse/logs:rw \
      -v /Path/to/User/docker/isaac-sim/data:/root/.local/share/ov/data:rw \
      -v /Path/to/User/docker/isaac-sim/documents:/root/Documents:rw \
      -v /dev/shm:/dev/shm \
      nvcr.io/nvidia/isaac-sim:4.5.0
	```
3. Run the following command to use isaac-sim ros2 built in library 
	```
	export isaac_sim_package_path=/isaac-sim
	
	export RMW_IMPLEMENTATION=rmw_fastrtps_cpp # Can only be set once per terminal.
	 
	# Setting this command multiple times will append the internal library path again potentially leading to conflicts
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$isaac_sim_package_path/exts/isaacsim.ros2.bridge/humble/lib 
	
	# Run Isaac Sim 
	$isaac_sim_package_path/runheadless.sh
	```
4. In isaacsim-webrtc streaming client, input the server ip address to enable streaming from server to client 
5. Verify if ros2 bridge has been started, In the menu tab, go to **Window -> Extensions -> search bar [ros2] -> ROS 2 BRIDGE** 
Then enable it if it has not been enabled

## Isaac ROS2 Dev Docker Setup 
1. Clone the modified [isaac-ros-common](https://github.com/audreych23/isaac_ros_common/tree/test-mod) repository 
	```
	git clone -b test-mod --single-branch https://github.com/audreych23/isaac_ros_common.git
	```
2. Clone this repository 
	```
	git clone https://github.com/audreych23/isaac-ros-vnc-workspace.git
	```
3. Run the following command to start the isaac-ros2 dev container with ros2 built in 
	```
	$PATH_TO_ISAAC_ROS_COMMON_REPO/scripts/run_dev.sh \
		-d $PATH_TO_THIS_REPO/humble_ws -a \
		"-v /dev/shm:/dev/shm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  -v $HOME/.Xauthority:/root/.Xauthority"
	```
4. Verify ros2
	```
	ros2 topic list 
	```
It should output /parameter and /rosout_event 

## Workflows (Reproducing Current Error)
1. In the isaac-sim webrtc streaming client, we should be able to see isaac-sim running in headless mode.
2. On the menu tab, go to **Window -> Examples -> Robotic Examples**
3. Besides **Console** tab, it should open a **Robotic Examples** tab below the main simulator screen 
4. Go to **ROS2 -> Navigation -> Carter** and load the example scene + carter robot 
5. Wait until the scene finish loading, then press run simulation 
6. [Go to the ROS2 docker terminal (step 6 and 7) ]
		Verify ROS2 topic list
	```
	ros2 topic list
	```
	There should be more topics outputs, such as /clock, /chassis, etc
7. **To reproduce the current error**: Test out if the ros2 could read the simulation time from isaac-sim with the commands below 
	```
	ros2 topic echo /clock 
	``` 
	Right now, this hangs indefinitely and does not output anything 


# Isaac Sim ROS & ROS2 Workspaces (More Details, This workspace is only used later in the future for running the examples after the error above is fixed) 

This repository contains two workspaces: `noetic_ws` (ROS Noetic) and `humble_ws` (ROS2 Humble). 

[Click here for usage and installation instructions with Isaac Sim](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html)

When cloning this repository, both workspaces are downloaded. Depending on which ROS distro you are using, follow the [setup instructions](https://docs.isaacsim.omniverse.nvidia.com/4.5.0/installation/install_ros.html#setting-up-workspaces) for building your specific workspace.

Reference: (isaac_ros_common)
https://github.com/NVIDIA-ISAAC-ROS/isaac_ros_common/tree/main
https://nvidia-isaac-ros.github.io/concepts/docker_devenv/index.html#development-environment
