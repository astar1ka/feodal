<?php

class Map{

    function __construct($db){
        $this->db = $db;
        $this->test = "test";
    }

    public function getMap($mapId) {
        $map = $this->db->getMap();
        
    }

    public function validPosObject($mapId, $posX, $poxY, $type){
        $map = $this->getMap($mapId);
        return true;
    }

}
