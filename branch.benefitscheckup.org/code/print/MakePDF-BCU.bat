#!/bin/sh 

/usr/bin/htmldoc --charset iso-8859-1 -f /var/www/html/BCU/pdf/$1.pdf --book --footer c.1 --header .t. --portrait --size letter --right .75in --format pdf --titlefile /var/www/html/BCU/print/BCUCover.html --toclevels 5 --firstpage toc /var/www/html/BCU/pdf/$1.cfm
