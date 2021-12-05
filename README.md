# gcp-ubuntu-vm-docker-tensorflow
Create a ubuntu vm with TensorFlow and docker installed


# Deep learning VM

- This script is using `Ubuntu 18.04` as operating system.
- For more information about the images, you can run 

```bash
### List all the deep learning image

gcloud compute images list \
        --project deeplearning-platform-release \
        --no-standard-images  \
         --filter="ubuntu"
```

- The script will install docker when the VM creating.

- Run the command in terminal `./script.sh non` for non preemptible instances
- Run the command in terminal `./script.sh preemptible` for  preemptible instances


# ROS VM

Ubuntu 18.04/20.04 with GDM.
ROS Melodic/Noetic.
Git.
In addition, GUI applications are supported by Docker GUI and nvidia-docker:

RViz: ROS Visualization tools.
Gazebo: ROS Simulation tools.
Gedit: Ubuntu Text editor.


- Run the line in terminal 
`./ros-docker-container-script.sh`

---

### To delete the ROS VM
- `gcloud compute instances delete deep-learning-instance --zone=us-west1-a`

---

# SSH into the instance
- Change the <your-project-name> and <your-instance-name> to your project name and your instance name in google cloud respectively.
```bash
gcloud beta compute ssh --zone "us-west1-a" "<your-instance-name>" --project "<your-project-name>"

# gcloud beta compute ssh --zone "us-west1-a" "deep-learning-instance" --project "pawfoo"

# gcloud beta compute ssh --zone "us-west1-a" "deep-learning-instance" --project "pawfoo" --ssh-flag "-L 5901:localhost:5901"
```


### 

```bash

gcloud beta compute config-ssh

ssh deep-learning-instance.us-west1-a.pawfoo
```

### Get the provision log

```bash
sudo tail -f /var/log/apt/term.log
```


