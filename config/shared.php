<?php

/*----------------------------------------------------*/
// Database
/*----------------------------------------------------*/
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
$table_prefix = getenv('DB_PREFIX') ? getenv('DB_PREFIX') : 'wp_';

/*----------------------------------------------------*/
// Authentication unique keys and salts
/*----------------------------------------------------*/
/**
 * @link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service 
 */
define('AUTH_KEY',         ')zh0y0?s+j8PAF- 1@i1`4k!~A)Hp|cE:)^7U2Jf+ASo|-!& NV{-*AR(`+x. [~');
define('SECURE_AUTH_KEY',  'Ds{^&mqD+_}-^gUxt:)VXIO%#E2^?F&n4_}r.lkg(:d;c+){,h|p>zplwGY_.<9!');
define('LOGGED_IN_KEY',    'mm-H%!e>!)1  E_WD=v3az!(!X-1eH+H(Z(<K:#qN3sgW|Zfo<MP]A f;;SR+n8M');
define('NONCE_KEY',        'INq0H=<Dm).-dGZ{.axcT6QaX&JE~2P+TmW[0([Y`sC[nRAQ(Cu&{koNCAr1;^x}');
define('AUTH_SALT',        '/yM s<Cv!aX+1^y:(s h)!_>sUzz_QK&B >,#e4oS=Ts8ZST[r)mlzMHdFHj+K[G');
define('SECURE_AUTH_SALT', 'VwO(yj)8]xe-++|yWQ91VIey!XCBIjFwAbaLvPaUmk0Q4.4wN7_9n;(M&ZGdA)7E');
define('LOGGED_IN_SALT',   '-_6nk)+D&n`}P|P|,rPDIt_6TGa4_2D!$u?%gLu3d*XX91cm5RInu{r6*h`K4Y{Z');
define('NONCE_SALT',       'i2;tO`OU]@UsnVt|D|cI,yljZ~i%e-TEg}@2&--++ (:z|xxq+|-++w^J-LUwcb[');

/*----------------------------------------------------*/
// Custom settings
/*----------------------------------------------------*/
define('WP_AUTO_UPDATE_CORE', false);
define('DISALLOW_FILE_EDIT', true);

/* That's all, stop editing! Happy blogging. */
