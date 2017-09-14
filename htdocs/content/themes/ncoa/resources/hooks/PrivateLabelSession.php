<?php

class PrivateLabelSession
{
    public function init()
    {
        if( !session_id() )
        {
            session_start();
        }

        if (array_key_exists('partner_id',$_REQUEST)) {
            $partnerId = $_REQUEST['partner_id'];
        } elseif (strpos(array_key_exists('REDIRECT_URL',$_SERVER) ? $_SERVER['REDIRECT_URL'] : '','/becs') === 0) {
            $partnerId = '58';
        } elseif (array_key_exists('partner_id',$_SESSION))  {
            $partnerId = $_SESSION['partner_id'];
        } else {
            $partnerId = '0';
        }

        setcookie('partner_id',$partnerId,time()+7200,'/');
        $_SESSION['partner_id'] = $partnerId;

    }
}