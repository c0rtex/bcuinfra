<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, and ABSPATH. You can find more information by visiting
 * {@link http://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php}
 * Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'esiqa');

/** ESI QA SEtting */
define('QA', '1');

/** MySQL database username */
define('DB_USER', 'esiqa');

/** MySQL database password */
define('DB_PASSWORD', 'eaa364a7!4d(s');

/** MySQL hostname */
define('DB_HOST', '172.31.33.46');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
#define('WP_DEBUG', true);

define("DB_USER_BCU", "esiqa");                           // <-- mysql db user
define("DB_PASSWORD_BCU", "eaa364a7!4d(s");              // <-- mysql db password
define("DB_HOST_BCU", "172.31.33.46");          // <-- mysql server host
define("DB_NAME_BCU", "bcumigration");                  // <-- database
define("DATABASE_BCU", "mysql");

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link http://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'oc1>E`^F!2+7{Q5_Q==$)8ruYpYQO|);1lG>9)*0>4c:S.LX++}X:zQ7:h<mR<q)');
define('SECURE_AUTH_KEY',  'y)~~4s@FU.GpKA)/-6O|IhZ:bva@;7=tV9eHVIAI<S|3pATz|eXc/g4IM~yMvKGi');
define('LOGGED_IN_KEY',    'Mf@eJ*2,%A;;6goBdC4Xl~-|E!Iy&IsB4e-x5|-7b.M(fS?p8ju+^+Dazt7:8Sb8');
define('NONCE_KEY',        '89:.,8.* &m!Vl;XFrXA9OFUj>4r+S|R9,.r+]5$~h;[C.[tlFiLH6AJ[CJ_[l2T');
define('AUTH_SALT',        '}+UE(GOVeYtg^~<&[zxB3<t*[CHC(r|]eY9I:z%#&ML@[[|g%-|(^r^ 4>>]jN[<');
define('SECURE_AUTH_SALT', '6W*nDD)x1N6)k{^lVGc#<s<E_4BCG6l480O+=r[ha3$+Y%L2JUWd/e{R,m,U}R*?');
define('LOGGED_IN_SALT',   'Ej(I>39_PH@(O86YT<VC8h|C3Sho,=?mI+<V,(~J>yj](/F.&44!gAVSo/qHe3&+');
define('NONCE_SALT',       'tnRLZ?hKcp=d?+<@~PTe=|@3ANcwhC,u==fI-$4d1O@0(?7PgB#WbCmW4.,#x4qQ');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

define('FORCE_SSL_ADMIN', false);
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
