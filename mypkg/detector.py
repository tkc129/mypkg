#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Bool
import os

class Detector(Node):
    def __init__(self):
        super().__init__('detector')
        self.pub = self.create_publisher(Bool, 'device_status', 10)
        # 監視対象のパス。テスト用に /tmp をデフォルトにしています。
        self.declare_parameter('device_path', '/tmp/dummy_device')
        self.create_timer(0.5, self.cb)

    def cb(self):
        path = self.get_parameter('device_path').get_parameter_value().string_value
        msg = Bool()
        msg.data = os.path.exists(path)
        self.pub.publish(msg)

def main():
    rclpy.init()
    node = Detector()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
