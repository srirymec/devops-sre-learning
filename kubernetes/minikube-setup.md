# Minikube setup

minikube delete (Previously installed if any)

rm  -rf /root/.kube
rm -rf /usr/bin/minikube
rm -rf /usr/bin/crictl


curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.22.0/minikube-linux-amd64

sudo chmod +x minikube

sudo mv minikube /usr/bin/

systemctl status firewalld

systemctl stop firewalld

systemctl disable firewalld

yum install conntrack -y

curl -L -O https://github.com/kubernetes-incubator/cri-tools/releases/download/v1.0.0-beta.0/crictl-v1.0.0-beta.0-linux-amd64.tar.gz

tar xvf crictl-v1.0.0-beta.0-linux-amd64.tar.gz

mv crictl /usr/bin/crictl

VER=$(curl -s https://api.github.com/repos/Mirantis/cri-dockerd/releases/latest|grep tag_name | cut -d '"' -f 4|sed 's/v//g')

echo $VER

wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VER}/cri-dockerd-${VER}.amd64.tgz

tar xvf cri-dockerd-${VER}.amd64.tgz

sudo mv cri-dockerd/cri-dockerd /usr/local/bin/

cri-dockerd --version

wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service

wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket

sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/

sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service

sudo systemctl daemon-reload

sudo systemctl enable cri-docker.service

sudo systemctl enable --now cri-docker.socket

sudo systemctl status cri-docker.socket

minikube start --vm-driver=none

minikube status

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl
