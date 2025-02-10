# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update lab environment
sudo ssh nginx test -e /etc/nginx/conf.d/default.conf && sudo ssh nginx rm /etc/nginx/conf.d/default.conf
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Management/{nginx,nap}.conf
sudo scp /tmp/nginx.conf nginx:/etc/nginx/
sudo scp /tmp/nap.conf   nginx:/etc/nginx/conf.d/

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/nap31/main/lab01/hosts
sudo scp /tmp/hosts nginx:/etc/hosts
