from setuptools import find_packages, setup
import os
from glob import glob

package_name = 'mypkg' # パッケージ名を mypkg のままにする場合はこのままでOK

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        # Launchファイルをインストール対象に含める（ボーナス獲得に必須）
        (os.path.join('share', package_name), glob('launch/*.launch.py')),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='tkcs129',
    maintainer_email='s24c1018lq@s.chibakoudai.jp',
    description='USB device presence monitor with ROS 2', # 具体的な説明に変更
    license='BSD-3-Clause',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            # 実行コマンド名 = パッケージ名.ファイル名:関数名
            'detector = mypkg.detector:main',
            'alerter = mypkg.alerter:main',
        ],
    },
)
