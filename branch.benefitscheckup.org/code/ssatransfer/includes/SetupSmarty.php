<?php

// load Smarty library


require_once("Smarty.class.php"); //this file is now in the include path

class SetupSmarty extends Smarty {

   function __construct() // Class Constructor. These automatically get set with each new instance.
   {
	parent::__construct(); //call smarty class constructor

        $this->template_dir = ROOT_DIR.'templates/templates/';
        $this->compile_dir = ROOT_DIR.'templates/templates_c/';
        $this->config_dir = ROOT_DIR.'templates/configs/';
        $this->cache_dir = ROOT_DIR.'templates/cache/';

        $this->caching = false;        
	$this->cache_lifetime = 3600; // 1 hour
//	$this->request_use_auto_globals = TRUE;
	$this->assign('app_name','BCU');
   }

}
?>
