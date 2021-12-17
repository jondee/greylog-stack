#!/bin/bash -x

# Update repos
apt update

# install apache
apt install apache2 -y 

# install psql
apt install postgresql-client -y

# install php and helpers
apt install php libapache2-mod-php -y

# install postgres module
apt install php-pgsql -y

# remove default index.html
rm /var/www/html/index.html

# restart apache2
systemctl restart apache2

# create index.php
tee /var/www/html/index.php <<EOF
<html>
 <head>
  <title>Greylog challenge</title>
 </head>
 <body>
<?php
    \$connection = pg_connect("host='${db_host}' port='${db_port}' user='${db_user}' password='${db_password}' dbname='${db_name}'");
    \$result = pg_query(\$connection, "select note from notes where id=1" );
    echo pg_fetch_row(\$result)[0];
?>
 </body>
</html>
EOF
