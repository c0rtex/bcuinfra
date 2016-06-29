<<<<<<< HEAD
<a href="http://drone.springbox.com/springbox/ncoa"><img src="http://drone.springbox.com/api/badges/springbox/ncoa/status.svg" /></a>

[![Build Status](http://drone.springbox.com/api/badges/springbox/ncoa/status.svg)](http://drone.springbox.com/springbox/ncoa)
=======
>>>>>>> a58e8d4c1efc09d56ce7fd55ca0b5fd5e30304c9
Themosis framework for Springbox
=================================

The Themosis framework is a tool aimed to WordPress developers of any levels. But the better WordPress and PHP knowledge you have the easier it is to work with.

Themosis framework is a tool to help you develop websites and web applications faster using [WordPress](https://wordpress.org). Using an elegant and simple code syntax, Themosis framework helps you structure and organize your code and allows you to better manage and scale your WordPress websites and applications.

Development team
----------------


docker login
git clone git@gitlab.springbox.com:springbox/themosis-base.git
docker-compose up

Hi, welcome to Themosis-base. This is literally a git clone git@github.com:themosis/themosis.git



The only changes that exist to this repo is the apach2.conf, themosis.dev.conf, and the .env.local.php. If you wish to use this repo, remember to set these variables accordingly when you migrate to a new project.


Important

You must edit the docker-compose.yml and the Dockerfile.local when you change this repo into a new project.

Edit docker-compose.yml

hostname: local
VIRTUALHOST: newproject.dev
VIRTUAL_HOST: newproject.dev
links
  -db:mysql.newproject.dev




On the database,

db:
  ...
  ...
  environment:
  - VIRTUAL_HOST=mysql.newproject.dev




What does this do?

Docker sometimes has probably when you're trading between virtual machines. The reason is that virtual machines run at different authorities on different OSs. This image was made on Ubuntu but can still translate over to any OS.
The import point is that the jwilder/proxy will reverse all these changes to the containers, in real time, to a port that is more easy to locate with your browser. Also, Themosis requires that there be a hostname as well.

Lastly

If you have a problem with a stream or folder not allowed permissions, you have two options based on this docker-compose.yml 

You could chown -R 644 . && chmod -R 644 . on your own bash 

Or

You run docker-compose run themosis bash. When you're bashed into the container, run cd .. && chown -R 644 . && chmod -R 644 .

Then you may refresh the website.


Login is springbox
Password is springbox

