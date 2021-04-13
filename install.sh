#!/usr/bin/env bash

cd /usr/src/app/ || exit
git clone https://github.com/magento/magento2.git ./magento2

cd /usr/src/app/magento2 || exit

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R :www-data .
chmod u+x bin/magento

composer install

cd /usr/src/app/magento2/bin || exit
./magento setup:install --base-url=http://localhost:8000/ \
--db-host=magento2_db --db-name=magento2_db --db-user=root --db-password=test \
--admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
--admin-user=admin --admin-password=admin123 --language=en_US \
--currency=USD --timezone=America/Chicago --use-rewrites=1 \
--search-engine=elasticsearch7 --elasticsearch-host=magento2-elasticsearch \
--elasticsearch-port=9200

service nginx start
