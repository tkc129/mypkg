#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Takashi Iwasaki
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Bool
import sys

class Alerter(Node):
    def __init__(self):
        super().__init__('alerter')
        self.sub = self.create_subscription(Bool, 'device_status', self.cb, 10)
        self.last_status = True

    def cb(self, msg):
        # 状態が True (あり) から False (なし) に変わった瞬間だけ警告
        if self.last_status and not msg.data:
            sys.stderr.write("ALERT: Device lost!\n")
        elif not self.last_status and msg.data:
            sys.stderr.write("INFO: Device recovered.\n")

        self.last_status = msg.data

def main():
    rclpy.init()
    node = Alerter()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
