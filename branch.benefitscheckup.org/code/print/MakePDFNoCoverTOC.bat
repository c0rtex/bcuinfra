#!/bin/bash 
/usr/bin/htmldoc --charset iso-8859-1 -f /app/bcu/pdf/$1.pdf --webpage --no-title --no-toc --footer c.1 --header .t. --portrait --size letter --right .75in --format pdf /app/bcu/pdf/$1.cfm
