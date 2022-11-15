<?php

class Map{

    function __construct($db){
        $this->db = $db;
        $this->test = "test";
    }

    public function getMap() {
        return json_decode($this->db->getMap(), true);
        /*
        return $array;
        return $object = array(
            'layer1' => $array[0],
            'layer2' => $array[1],
            'layer3' => $array[2] 
        );*/
    }

    public function validPosObject($mapId, $posX, $poxY, $type){

    }

}
