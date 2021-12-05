#! /bin/bash

# then enable the 3389 port
# gcloud compute firewall-rules list  
# gcloud compute firewall-rules create allow-rdp --allow tcp:3389
# gcloud compute firewall-rules create allow-https --allow tcp:443
# gcloud compute firewall-rules create allow-http --allow tcp:80 
# gcloud compute firewall-rules create allow-vnc --allow tcp:5901


# sudo apt install unzip
# wget https://www.c-nergy.be/downloads/xrdp-installer-1.2.2.zip
# unzip xrdp-installer-1.2.2.zip 
# bash xrdp-installer-1.2.2.sh

# wget https://www.c-nergy.be/downloads/xrdp-1.2.3.zip
# unzip xrdp-1.2.3.zip 
# bash xrdp-installer-1.2.3.sh

export HOME_PATH=/home/cleversoft


# For ros-noetic-desktop

echo "Reference from https://varhowto.com/install-ros-noetic-ubuntu-20-04/"
echo "deb http://packages.ros.org/ros/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/ros-focal.list

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

sudo apt install ros-noetic-desktop

echo "remember to run this everytime before login >> source /opt/ros/noetic/setup.bash"
echo "source /opt/ros/noetic/setup.bash" >> $HOME_PATH/.bashrc

echo "For catkin tools"
# Automatically source setup.bash for convenience.
sudo apt-get install python3-catkin-tools -y
sudo mkdir -p catkin_ws/src
cd $HOME_PATH/catkin_ws
sudo catkin build
echo "source ~/catkin_ws/devel/setup.bash" >> $HOME_PATH/.bashrc
source $HOME_PATH/.bashrc


# plugin
sudo apt install -y ros-noetic-hector-gazebo-plugins \
                    ros-noetic-velodyne \
                    ros-noetic-velodyne-description \
                    ros-noetic-velodyne-gazebo-plugins \
                    ros-noetic-pointcloud-to-laserscan \
                    ros-noetic-twist-mux

sudo apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control

sudo apt install ros-noetic-gazebo-plugins -y

sudo apt install python3-roslaunch -y
sudo apt install python3-rostopic -y
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential -y
sudo apt install python3-rosdep -y


echo "End of start up script"