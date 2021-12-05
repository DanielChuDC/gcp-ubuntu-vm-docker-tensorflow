export INSTALL_PATH=/Volumes/second-disk-samsung/catkin_ws/ 
docker run  -it  \
            --volume="$INSTALL_PATH:/catkin_ws" \
            -e DISPLAY=host.docker.internal:0.0 \
            -e LIBGL_ALWAYS_INDIRECT=0  \
            nelsenew/eth-zurich-ros:noetic