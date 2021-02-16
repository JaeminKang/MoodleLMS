# mysql

service mysql start
echo "CREATE DATABASE IF NOT EXISTS moodle;
ALTER DATABASE moodle DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'user'@'%' identified by 'password';
GRANT ALL PRIVILEGES ON moodle.* TO 'user'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
" | mysql -u root --skip-password

mysqladmin -u root -p reload