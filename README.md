# mypkg
ロボットシステム学課題2

![test](https://github.com/tkc129/mypkg/actions/workflows/test.yml/badge.svg)

## 概要
Linux上のファイル、USBデバイスの存在を定期的に監視し、接続状態を判定してROS 2トピックとしてpublishします。

## 実行環境
以下の環境、ソフトウェアにおいてプログラムの実行及びテストを確認しています。
- OS: Ubuntu 22.04.5 LTS
- ROS 2: Humble
- Python: 3.10

## ノード
- detectorノード: 指定したパスの存在を監視し、結果を配信します。
- alerterノード: detectorの結果を受け取り、状態に応じたメッセージを表示します。

## トピック
device_status

指定したファイルまたはデバイスファイルの存在状態を通知するトピックです。
ノードは一定周期で対象パスを確認し，結果をpublishします。

- true : 指定したパスが存在する
- false: 指定したパスが存在しない

## 事前準備
本パッケージはROS 2環境において、colconによるビルドおよび`install/setup.bash`のsourceが行われていることを前提とします。

## 実行方法
Launchファイルを使用して、監視ノードとアラートノードを同時に起動します。
```
$ ros2 launch mypkg monitor.launch.py
```
別ターミナルでトピックの内容を確認できます。
```
$ ros2 topic echo /device_status
```

## 実行例
接続されている場合
```
$ ros2 topic echo /device_status
data: true
---
data: true
---
data: true
---
...
```
接続されていない場合
```
$ ros2 topic echo /device_status
data: false
---
data: false
---
data: false
---
...
```

## テスト環境
-  Ubuntu 22.04.5 LTS

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます。
- © 2025 Takashi Iwasaki
