#!/bin/bash
#add fix to exercise3 here

sudo nano /etc/apache2/sites-enabled/000-default.conf

<Location "/">
    Require all granted
</Location>
