#! /usr/bin/bash

cd /home/$(whoami)/ros2_ws
source /opt/ros/${ROS_DISTRO}/setup.bash

echo
echo "Running rosdep update and install..."
echo "======================================"
rosdep update
rosdep install --from-paths src --ignore-src -y

echo
echo "Building ros2 workspace..."
echo "======================================"
colcon build && source install/setup.bash

exec "$@"
