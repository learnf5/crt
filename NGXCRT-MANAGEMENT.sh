# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Management/hosts
sudo scp /tmp/hosts    nginx:/etc/hosts
sudo cp /tmp/hosts /etc/hosts

sudo ssh nginx rmdir /etc/nginx/ssl
