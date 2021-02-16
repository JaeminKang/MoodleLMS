# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jaemin <jaemin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/03/20 18:19:07 by jakang            #+#    #+#              #
#    Updated: 2021/02/16 16:37:01 by jaemin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM jakubboucek/lamp-devstack-php:7.4

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y wget

# setup phpmyadmin
ADD . /var/www/html/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpmyadmin
ADD ./srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php

# setup moodle
RUN mkdir /var/www/html/moodle
RUN wget https://download.moodle.org/download.php/direct/stable310/moodle-latest-310.tgz
RUN tar -xvzf moodle-latest-310.tgz --strip-components 1 -C /var/www/html/moodle

# setting config
ADD ./srcs/setup.sh ./setup.sh
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN export APACHE_DOCUMENT_ROOT="/var/www/html"
ADD ./srcs/000-default.conf /etc/apache2/sites-available/000-default.conf
# CMD bash ./setup.sh \
    # sleep infinity & wait

CMD sleep infinity & wait
