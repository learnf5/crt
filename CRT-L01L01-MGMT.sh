# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Management/hosts
sudo scp /tmp/hosts    nginx:/etc/hosts

# update nginx host for the specific lab

#Remove default.conf file since this lab requires only default.bak
#sudo ssh nginx rm /etc/nginx/conf.d/default.conf
