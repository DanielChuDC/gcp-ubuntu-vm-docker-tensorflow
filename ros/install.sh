#! /bin/bash
XAUTH=/tmp/.docker.xauth

xauth_list=$(xauth nlist :0 | tail -n 1 | sed -e 's/^..../ffff/')
if [ ! -f $XAUTH ]; then
    if [ ! -z "$xauth_list" ]; then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

file $XAUTH
ls -FAlh $XAUTH

export DISTRO=noetic
docker run -it \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="$XAUTH:$XAUTH" \
    --volume="/home/cleversoft/catkin_ws:/catkin_ws" \
    --net=host \
    --privileged \
    --runtime=nvidia \
    nelsenew/eth-zurich-ros:$DISTRO \
    bash