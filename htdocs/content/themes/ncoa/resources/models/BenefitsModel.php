<?php

class BenefitsModel {

    public $name;
    public $image;

    public function __construct($name, $image){
        $this->$name = $name;
        $this->$image = $image;
    }

} 