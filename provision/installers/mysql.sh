#!/bin/bash

# Install MySQL
sudo apt-get install -y mysql-server

# Set the root password
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$db_root_password';"

# Automate the mysql_secure_installation process
SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter password for user root:\"
send \"$mysql_root_password\r\"

expect \"VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component\"
send \"n\r\"

expect \"Change the password for root\"
send \"n\r\"

expect \"Remove anonymous users\"
send \"y\r\"

expect \"Disallow root login remotely\"
send \"n\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")
echo "$SECURE_MYSQL"
