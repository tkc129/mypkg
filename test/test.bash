#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws

# 1. ROS 2 本体の環境を読み込む（これが重要！）
source /opt/ros/humble/setup.bash

# 2. ビルド
colcon build
source install/setup.bash

# 3. 実行（timeout内でbash -cを使うことで、確実にパスを通す）
timeout 15 bash -c "source /opt/ros/humble/setup.bash && source install/setup.bash && ros2 launch mypkg monitor.launch.py" > /tmp/mypkg.log 2>&1 &

sleep 10  # 起動まで少し長めに待つ

# 4. ファイルを作成して復旧をシミュレート
touch /tmp/dummy_device
sleep 5

# 5. ファイルを削除して紛失をシミュレート
rm /tmp/dummy_device
sleep 5

# 6. ログを確認
cat /tmp/mypkg.log

# 判定
grep "INFO: Device reconnected." /tmp/mypkg.log || (echo "Test failed: reconnected message not found"; exit 1)
grep "ALERT: Device lost!" /tmp/mypkg.log || (echo "Test failed: lost message not found"; exit 1)

echo "Test passed!"
exit 0
