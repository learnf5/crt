# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Management/hosts
sudo scp /tmp/hosts    nginx:/etc/hosts

# For ConfigKnowledge Lab (Exam 2)
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/ConfigKnowledge/lb.orig
sudo scp /tmp/lb.orig    nginx:/etc/nginx/conf.d/lb.orig

# For ConfigDemonstrate Lab (Exam 3)
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/ConfigDemonstrate/juice.conf
sudo scp /tmp/juice.conf    nginx:/etc/nginx/conf.d/juice.conf

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/ConfigDemonstrate/ssl_params.conf
sudo ssh nginx mkdir --parents /etc/nginx/ssl
#sudo scp /tmp/ssl_params.conf    student:/etc/nginx/ssl/ssl_params.conf

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/ConfigDemonstrate/{curl,create_certs}.sh
sudo ssh nginx mkdir --parents /home/student/ssl
sudo scp /tmp/{curl,create_certs}.sh    student:/home/student/ssl/

#Remove default.conf file since this lab requires only default.bak
#sudo ssh nginx rm /etc/nginx/conf.d/default.conf
