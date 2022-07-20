# module: terraform-digitalocean-fedora-workstation
Terraform code to deploy a fedora workstation vm in Digital Ocean with:
- RDP enabled
- Internet access
- Virtual Studio Code installed.

## Pre-requirements
- Create a volume in DO to be used as a persistant /home. This will not get deleted by `terraform destroy`, it is only attached/detached by Terraform.

## Roadmap:
- mount persistant /home volume
- configure domain (Cloudflare)

## Provisioning

vim
```
dnf install -y vim vim-default-editor
```

User:
```shell
useradd user
passwd user
usermod -aG wheel user
cp ~/.ssh/authorized_keys /home/richard/.ssh/
```

Git:
```
dnf install -y git
```

Terraform:
```
dnf install -y unzip
cd ~
curl https://releases.hashicorp.com/terraform/0.11.15/terraform_0.11.15_linux_amd64.zip --output terraform_0.11.15_linux_amd64.zip
unzip terraform_0.11.15_linux_amd64.zip
mv terraform /usr/local/bin
```

AWS-CLI:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
ll
unzip awscliv2.zip 
cd aws/
./install 
sudo ./install
aws --version
aws configure
```
OR with ENV vars
AWS crds in ENV:
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="eu-west-1"
terraform plan
```

TFENV ([source]([https://github.com/tfutils/tfenv))
```
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
# add to PATH
```

OPTIONAL:
Upgrade to Fedora server with gui:
```
dnf install "@MATE desktop"
```

RDP ([source](https://www.server-world.info/en/note?os=Fedora_35&p=desktop&f=7)):
```shell
dnf install -y xrdp tigervnc-server
systemctl enable --now xrdp
```# terraform-digitalocean-fedora_dev_server
