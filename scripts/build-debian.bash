ROS2_DISTRO="$1"
ROOT_DIR=$(pwd)

# Generate changelogs
catkin_generate_changelog --all

# Do for each ROS 2 packages path
for PACKAGE in $(colcon list | cut -f2)
do
  cd "$PACKAGE" || exit $?

  # Source ROS 2 environment
  source /opt/ros/$ROS2_DISTRO/setup.bash || exit $?

  # Generate Debian rules
  bloom-generate rosdebian --ros-distro "$ROS2_DISTRO" || exit $?

  # Build package using fakeroot
  fakeroot debian/rules binary || exit $?

  # Install all build result
  sudo dpkg --install ../*.deb || exit $?

  # Move build result to the output directory
  mkdir -p $ROOT_DIR/package && mv ../*.deb $ROOT_DIR/package

  cd $ROOT_DIR || exit $?
done
