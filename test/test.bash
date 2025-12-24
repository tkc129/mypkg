#!/bin/bash
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source install/setup.bash

# 1. 最初はデバイスがない状態で起動（標準エラーをログに含めるため 2>&1 を使用）
timeout 15 ros2 launch mypkg monitor.launch.py > /tmp/mypkg.log 2>&1 &
LAUNCH_PID=$!

sleep 5

# 2. デバイスファイルを作成（復旧をシミュレート）
touch /tmp/dummy_device
sleep 3

# 3. デバイスファイルを削除（紛失をシミュレート）
rm /tmp/dummy_device
sleep 3

# 4. ログを確認して期待する文字列があるかチェック
cat /tmp/mypkg.log

# 復旧時のメッセージがあるか
grep "INFO: Device reconnected." /tmp/mypkg.log
if [ $? -ne 0 ]; then
    echo "Test failed: 'reconnected' message not found"
    exit 1
fi

# 紛失時のメッセージがあるか
grep "ALERT: Device lost!" /tmp/mypkg.log
if [ $? -ne 0 ]; then
    echo "Test failed: 'lost' message not found"
    exit 1
fi

echo "Test passed!"
exit 0
