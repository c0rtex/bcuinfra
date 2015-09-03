#!/bin/bash 

/usr/bin/htmldoc --charset iso-8859-1 -f /app/bcu/pdf/$1.pdf --book --footer c.1 --header .t. --portrait --size letter --right .75in --format pdf --titlefile /app/bcu/pdf/$1.html --toclevels 5 --firstpage toc /app/bcu/pdf/$1.cfm

