=== Display - Queries ===
Contributors: mpegarts
Donate link: http://www.dreams.de/donation/
Tags: admin, optimize, performance, plugin, loading time, debug, german, french
Requires at least: 3.0
Tested up to: 3.0.1
Stable tag: 1.0.1

Display Plugin for number of queries and page loading time

== Description ==

This plugin shows the admin at the bottom of the template the number of queries and the page loading time of the displayed page.

The display will be shown at the lower border of the current template and is only visible for admins (userlevel >=8)

With it you can check after the installation of a new template or plugin the load speed of your blog and the number of queries it makes to the database (check the database load)

Therefore you can see and disable templates and / or plugins that make a huge load on your database and thus disable them and optimize this way the speed of your wordpress installation.

For the display there are no changes necessary on your current template, it will just be displayed in the footer of the blog page.

Additionally there will be 2 buttons displayed of the validators from the w3c sites, so when you click those  you can check your template if the HTML and CSS parts are valid and compliant with the W3C rules.

= License =

Copyright 2010 by Mpegarts

Released under the terms of the GNU GPL, version 2.
http://www.fsf.org/licensing/licenses/gpl.html

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

== Installation ==

1. Uncompress the download package
2. Upload folder including all files and sub directories to the `/wp-content/plugins/` directory.
3. Activate the plugin through the 'Plugins' menu in WordPress

You're done!

== Frequently Asked Questions ==

= Will I have to configure the plugin ? =

No, for the display of the queries and load time there will be no changes necessary.

= There is no display although the plugin is activated ? =

Probably the hook "wp_footer" was not included in your template file.
Please write to the template author and request it to be included and maybe there is already a new version of your template out ?
Always install the newest template version first and check again.

== Screenshots ==

1. Display

== Changelog ==

= 1.0.1 =
* Plugin is now avalible in english, german and french

= 1.0 =
* First stable version

== Upgrade Notice ==

None
