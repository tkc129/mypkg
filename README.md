# mypkg
ロボットシステム学の課題用ファイルをまとめたリポジトリです。

## 概要
Linux上のファイル,USBデバイスの存在を定期的に監視し、接続状態を判定してROS2トピックとしてpublishします。

## 実行環境
以下の環境、ソフトウェアにおいてプログラムの実行及びテストを確認しています。
- Ubuntu 22.04.5 LTS

## 事前準備
"git"コマンドを使用してリポジトリをクローンし、ros2_wsに移動する事で実行できます。

```
$ git clone https://github.com/tkc129/mypkg.git
$ cd ~/ross
$ colcon build
$ source install/setup.bash
```

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
data: true
```
接続されていない場合
```
data: false
```

## テスト環境
- Ubuntu 24.04.3 LTS

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます。
- © 2025 Takashi Iwasaki
