#!/bin/sh 

/usr/bin/htmldoc --charset iso-8859-1 -f /data/nes/nes-4.17/https-benefitscheckup.governmentguide.com/pages/pdf/$1.pdf --book --footer c.1 --header .t. --portrait --size letter --right .75in --format pdf --titlefile /data/nes/nes-4.17/https-benefitscheckup.governmentguide.com/pages/print/BCUCover.html --toclevels 5 --firstpage toc /data/nes/nes-4.17/https-benefitscheckup.governmentguide.com/pages/pdf/$1.cfm
