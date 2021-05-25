ROS2_DISTRO="$1"
OUTPUT_DIR="$2"
UNIQUE_VERSION="$3"

ROOT_DIR=$(pwd)

# Generate changelogs
catkin_generate_changelog --all || true

# Do for each ROS 2 packages path
for PACKAGE in $(colcon list | cut -f2)
do
  cd $ROOT_DIR/$PACKAGE || continue

  # Source ROS 2 environment
  source /opt/ros/$ROS2_DISTRO/setup.bash || continue

  # Generate Debian rules
  if [ "$UNIQUE_VERSION" == "false" ]
  then
    bloom-generate rosdebian --ros-distro "$ROS2_DISTRO" || continue
  else
    bloom-generate rosdebian --ros-distro "$ROS2_DISTRO" -i $(date +%s) || continue
  fi

  # Build package using fakeroot
  fakeroot debian/rules binary || continue

  # Install all build result
  sudo dpkg --install ../*.deb || continue

  # Move build result to the output directory
  mkdir -p $ROOT_DIR/$OUTPUT_DIR &&
    mv ../*.deb $ROOT_DIR/$OUTPUT_DIR &&
    mv ../*.ddeb $ROOT_DIR/$OUTPUT_DIR || true
done
