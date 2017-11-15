# Linux / Mac Dev Setup

This document describes how I set up my developer environment on Linux. The steps outlined in this document should work on Mac OS X as well.

## Prerequisites

The following files must be provided by Leviathan Technology before proceeding with the installation:

* **db.sql.gz**: Database backup.
* **uploads.tar.gz**: "uploads" folder. Contains all assets uploaded by content editors. 

## Installation

* Clone repository   
```
$ git clone git@git.assembla.com:bcuinfra.2.git
$ cd bcuinfra.2
```

* Switch to the "develop" branch   
```
$ git checkout develop
```

* **TEMPORARY**: Revert /htdocs/cms/ folder   
_Composer overwrites our version of Themosis framework and therefore the cms folder needs to be reverted. This step won't be needed anymore once we upgrade the framework._
```
git checkout -- htdocs/cms/
```

* Unzip database backup and import sql file into MySQL    
```
$ gunzip db.sql.gz
$ mysql -uUSER -pPASS DB_NAME < db.sql
```

* Install dependencies   
```
$ composer install
```

* Update .env file with your local settings (credentials)
```
$ vim .env

DB_NAME=ncoa
DB_USER=root
DB_PASSWORD=root
DB_HOST=127.0.0.1
WP_HOME=http://localhost:8000
WP_SITEURL=http://localhost:8000/cms
```

* Find your hostname   
```
$ hostname
medusa
```

* Register your hostname as a local environment
```
$ vim config/environment.php

<?php

/*----------------------------------------------------*/
// Define your environments
/*----------------------------------------------------*/
return [

    'local'         =>  ['local','Rustams-MacBook-Pro.local','ncoa.dev','medusa'],
    'production'    => 'ncoa.dev'

];
```

* Create storage/views folders   
```
$ mkdir -p storage/views
$ chmod -R 777 storage
```

* Extract the "uploads" folder provided
```
$ tar xvzf uploads.tar.gz -C htdocs/content/
$ chmod -R 777 htdocs/content/uploads
```

* Start PHP server
```
$ php -S localhost:8000 -t htdocs
```

Visit website! http://localhost:8000/ (it might take a few seconds to load the first time)

**Congratulations! You now have your dev environment set up.**