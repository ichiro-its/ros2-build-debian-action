ROS2_DISTRO="$1"

# Add ROS 2 GPG key
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg || exit $?

# Add ROS 2 repository to the source list
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null || exit $?

# Install required tools
sudo apt update && sudo apt install -y \
  debhelper \
  dh-python \
  python3-bloom \
  python3-catkin-pkg \
  python3-colcon-common-extensions \
  python3-rosdep \
  fakeroot || exit $?

# Initialize and update rosdep
sudo rosdep init || true
rosdep update || exit $?
