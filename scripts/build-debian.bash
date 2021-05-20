ROS2_DISTRO="$1"
ROOT_DIR=$(pwd)

# Generate changelogs
catkin_generate_changelog --all

# Do for each ROS 2 packages path
for PACKAGE in $(colcon list | cut -f2)
do
  cd "$ROOT_DIR" && cd "$PACKAGE" || continue

  # Source ROS 2 environment
  source /opt/ros/$ROS2_DISTRO/setup.bash || continue

  # Generate Debian rules
  bloom-generate rosdebian --ros-distro "$ROS2_DISTRO" || continue

  # Build package using fakeroot
  fakeroot debian/rules binary || continue

  # Install all build result
  sudo dpkg --install ../*.deb || continue

  # Move build result to the output directory
  mkdir -p $ROOT_DIR/package &&
    mv ../*.deb $ROOT_DIR/package
    mv ../*.ddeb $ROOT_DIR/package
done
