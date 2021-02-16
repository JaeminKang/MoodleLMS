FROM jakubboucek/lamp-devstack-php:7.4

RUN rm /etc/apt/preferences.d/no-debian-php
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y wget \
            -y mariadb-server \
            -y php-intl \
            -y php-soap \
            -y php-zip \
            -y php-xmlrpc \ 

# setup phpmyadmin
ADD . /var/www/html/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpmyadmin
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php

# setup moodle
RUN mkdir /var/www/html/moodle
RUN wget https://download.moodle.org/download.php/direct/stable310/moodle-latest-310.tgz
RUN tar -xvzf moodle-latest-310.tgz --strip-components 1 -C /var/www/html/moodle
RUN chmoda-R 0770 /var/www/html/moodle
RUN mkdir /var/moodledata
RUN chmod -R 0770 /var/moodledata
RUN chown -R www-data:www-data /var/moodledata

# setting config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN export APACHE_DOCUMENT_ROOT="/var/www/html"
ADD ./srcs/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./srcs/setting.sh ./setting.sh
RUN bash ./setting.sh
CMD  service apache2 restart \
    && service mysql start \
    && sleep infinity & wait