# add ROS 2 GPG key
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# add ROS 2 repository to the source list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install required tools
sudo apt update && sudo apt install \
  python3-bloom \
  python3-colcon-common-extensions \
  python3-rosdep \
  fakeroot

# install ROS 2 project dependencies
sudo rosdep init && rosdep update && rosdep install -y --rosdistro ${ROS2_DISTRO} --from-paths .
