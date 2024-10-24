# Lab setup for NGINX Certification Prep Course - Management
# enable debugging
set -x
PS4='+$(date +"%T.%3N"): '

# get lab-info.md for student guide bravais id
curl --silent https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/lab-info.md --output /tmp/lab-info.md
brav_id=$(awk -F '|' "/$LAB_ID/"' {print $2}' /tmp/lab-info.md)

# install student guide
cat <<'EOF' >/home/student/Desktop/Lab_Guide.desktop
[Desktop Entry]
Version=1.0
Name=Lab Guide
Icon=document
Terminal=false
Type=Application
Categories=Application;
EOF
echo Exec=google-chrome --app=https://f5.bravais.com/s/$brav_id >>/home/student/Desktop/Lab_Guide.desktop
gio set /home/student/Desktop/Lab_Guide.desktop metadata::trusted true
chmod +x /home/student/Desktop/Lab_Guide.desktop

# install nginx license
set +x
curl --silent --remote-name-all --output-dir /tmp --header "Authorization: token $LIC_TOKEN" https://raw.githubusercontent.com/learnf5/eval-reg-keys/main/nginx/nginx-repo.{crt,key}
echo curl --silent --remote-name-all --output-dir /tmp --header "Authorization: token xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" https://raw.githubusercontent.com/learnf5/eval-reg-keys/main/nginx/nginx-repo.{crt,key}
set -x
until sudo scp /tmp/nginx-repo.* nginx:/etc/ssl/nginx/ || (( count++ > 5 )); do sleep 5; done

# run this lab's specific tasks saved on GitHub
curl --silent --output /tmp/$LAB_ID.sh https://raw.githubusercontent.com/learnf5/$COURSE_ID/main/$LAB_ID.sh
bash -x /tmp/$LAB_ID.sh

# Create caching lab directories 
sudo ssh nginx mkdir --parents /data/nginx/cache

# restart NGINX
sudo ssh nginx systemctl stop nginx
sudo ssh nginx systemctl start nginx
