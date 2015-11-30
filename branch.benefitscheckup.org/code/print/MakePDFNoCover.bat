#!/bin/bash 
/usr/bin/htmldoc -v --charset iso-8859-1 -f /app/bcu/pdf/$1.pdf --no-title --footer c.1 --header .t. --portrait --size letter --right .75in --format pdf14 --toclevels 5 --firstpage toc /app/bcu/pdf/$1.cfm
