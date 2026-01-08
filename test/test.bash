#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws

# 1
source /opt/ros/humble/setup.bash

# 2
colcon build
source install/setup.bash

# 3
timeout 15 bash -c "source /opt/ros/humble/setup.bash && source install/setup.bash && ros2 launch mypkg monitor.launch.py" > /tmp/mypkg.log 2>&1 &

sleep 10

# 4
touch /tmp/dummy_device
sleep 5

# 5
rm /tmp/dummy_device
sleep 5

# 6
cat /tmp/mypkg.log

# 判定
grep "INFO: Device reconnected." /tmp/mypkg.log || {
  echo "Test failed: reconnected message not found"
  exit 1
}
grep "ALERT: Device lost!" /tmp/mypkg.log || (echo "Test failed: lost message not found"; exit 1)

echo "Test passed!"
exit 0
