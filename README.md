# ROS 2 Build Debian Package Action

[![latest version](https://img.shields.io/github/v/release/ichiro-its/ros2-build-debian-action)](https://github.com/ichiro-its/ros2-build-debian-action/releases/)
[![commits since latest version](https://img.shields.io/github/commits-since/ichiro-its/ros2-build-debian-action/latest)](https://github.com/ichiro-its/ros2-build-debian-action/releases/)
[![license](https://img.shields.io/github/license/ichiro-its/ros2-build-debian-action)](./LICENSE)
[![test status](https://img.shields.io/github/workflow/status/ichiro-its/ros2-build-debian-action/Action%20Test?label=test)](https://github.com/ichiro-its/ros2-build-debian-action/actions)

This action could be used to build [Debian packages](https://packages.debian.org/) from a [ROS 2](https://www.ros.org/) project.

## Usage

For more information, see [action.yml](./action.yml) and the [GitHub Actions guide](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions).

### Default Usage

```yaml
name: Build Debian Packages
on:
  push:
    branches: [ main ]
jobs:
  build-debian-packages:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout this repository
        uses: actions/checkout@v2.3.4
      - name: Build Debian packages
        uses: ichiro-its/ros2-build-debian-action@main
```
> This will be defaulted to use [ROS 2 Foxy Fitzroy](https://docs.ros.org/en/foxy/Releases/Release-Foxy-Fitzroy.html).

### Use Different ROS 2 Distribution

```yaml
- name: Build Debian packages
  uses: ichiro-its/ros2-build-debian-action@main
  with:
    ros2-distro: rolling
```

### Use Different Output Directory

```yaml
- name: Building and testing
  uses: ichiro-its/ros2-build-debian-action@main
  with:
    output-dir: output
```

## License

This project is maintained by [ICHIRO ITS](https://github.com/ichiro-its) and licensed under the [MIT License](./LICENSE).
