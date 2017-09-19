<?php

class PrivateLabelSession
{
    public function init()
    {
        if( !session_id() )
        {
            session_start();
        }

        $this->setSessionParam('partner_id', strpos(array_key_exists('REDIRECT_URL',$_SERVER) ? $_SERVER['REDIRECT_URL'] : '','/becs') === 0 ? 58 : 0, strpos(array_key_exists('REDIRECT_URL',$_SERVER) ? $_SERVER['REDIRECT_URL'] : '','/becs') === 0);
        $this->setSessionParam('subset_id',100,false);
    }

    public function setSessionParam($param,$default,$isDefaultImportant) {
        if (array_key_exists($param,$_REQUEST)) {
            $paramValue = $_REQUEST[$param];
        } elseif ($isDefaultImportant) {
            $paramValue = $default;
        } elseif (array_key_exists($param,$_SESSION))  {
            $paramValue = $_SESSION[$param];
        } else {
            $paramValue = $default;
        }

        $_SESSION[$param] = $paramValue;
    }
}