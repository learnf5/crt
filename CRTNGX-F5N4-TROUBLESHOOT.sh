# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# update Student Workstation host for the specific lab
# only if need a simpler /etc/hosts file do the following 2 steps
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Management/hosts
sudo scp /tmp/hosts    nginx:/etc/hosts

# For Troubleshooting Lab (Exam 4)
sudo ssh nginx mkdir --parents /etc/nginx/ssl
curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Troubleshooting/juice.conf
sudo scp /tmp/juice.conf    nginx:/etc/nginx/conf.d/juice.conf

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Troubleshooting/ssl_params.conf
sudo ssh nginx mkdir --parents /etc/nginx/ssl-configs
sudo scp /tmp/ssl_params.conf    nginx:/etc/nginx/ssl-configs/ssl-params.conf

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/Troubleshooting/juice.tls
sudo scp /tmp/juice.tls    nginx:/etc/nginx/conf.d/juice.tls

curl --silent --remote-name-all --output-dir /tmp https://raw.githubusercontent.com/learnf5/crt/main/ConfigDemonstrate/{curl,create_certs}.sh
sudo ssh nginx mkdir --parents /home/student/ssl
sudo scp /tmp/{curl,create_certs}.sh    nginx:/home/student/ssl/
sudo ssh nginx chmod +x /home/student/ssl/{create_certs,curl}.sh
sudo ssh nginx chown -R student.student /home/student/ssl

#Remove default.conf file since this lab requires only default.bak
sudo ssh nginx mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.bak
