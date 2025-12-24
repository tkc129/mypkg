import launch
import launch_ros.actions

def generate_launch_description():
    # detectorノードの設定
    detector = launch_ros.actions.Node(
        package='mypkg',      # setup.pyのpackage_nameと一致させる
        executable='detector', # setup.pyのentry_pointsの左側と一致させる
        output='screen'
    )
    
    # alerterノードの設定
    alerter = launch_ros.actions.Node(
        package='mypkg',
        executable='alerter',
        output='screen'
    )

    return launch.LaunchDescription([detector, alerter])
