# !/bin/bash
set -x # for debug purpose
echo "Enable your usage reporting in Google Cloud"

gcloud config set disable_usage_reporting false

# export IMAGE_FAMILY="tf2-ent-latest-gpu-ubuntu-1804"
# export IMAGE_PROJECT="deeplearning-platform-release"
export IMAGE_PROJECT="ubuntu-os-cloud"
export IMAGE_FAMILY="ubuntu-2004-lts"
export ZONE="asia-southeast1-b"
export INSTANCE_NAME="deep-learning-instance"
export MACHINE_TYPE="n1-standard-2" # with GPU must use n1 series
export GPU_TYPE="type=nvidia-tesla-p4,count=1"

echo "Print output for machine type on the specific region"
gcloud compute machine-types list --zones=$ZONE 

#Check whether they are equal
if [ $1 == "preemptible" ]
then
    echo "Creating preemptible Deep Learning VM instance"
    gcloud compute instances create $INSTANCE_NAME \
    --zone=$ZONE \
    --image-family=$IMAGE_FAMILY \
    --image-project=$IMAGE_PROJECT \
    --maintenance-policy=TERMINATE --restart-on-failure \
    --accelerator=$GPU_TYPE \
    --metadata="install-nvidia-driver=True" \
    --metadata-from-file=startup-script=./meta-start-up-script.sh  \
     --machine-type=$MACHINE_TYPE   \
    --preemptible
fi
  
#Check whether they are not equal
if [ $1 != "preemptible" ]
then
    echo "Creating normal Deep Learning VM instance"
    gcloud compute instances create $INSTANCE_NAME \
    --zone=$ZONE \
    --image-family=$IMAGE_FAMILY \
    --image-project=$IMAGE_PROJECT  \
    --maintenance-policy=TERMINATE --restart-on-failure \
    --accelerator=$GPU_TYPE \
    --metadata="install-nvidia-driver=True" \
    --machine-type=$MACHINE_TYPE     \
    --metadata-from-file=startup-script=./installubuntugui.sh 

fi

echo "Gcloud instance created"




