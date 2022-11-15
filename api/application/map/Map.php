<?php

class Map{

    function __construct($db){
        $this->db = $db;
    }
    public function getMap($mapId) {
        $map = $this->db->getMap();
        $ground = array_chunk(json_decode($map->layer1),160);
        $plants = array_chunk(json_decode($map->layer2),160);
        $trees = array_chunk(json_decode($map->layer3),160);
        return array(
            'map' => array(
                'ground' => $ground,
                'plants' => $plants,
                'trees' => $trees,
            ) 
        );
    }

    public function validPosObject($mapId, $posX, $poxY, $type){
        $map = $this->getMap($mapId);
        $posX = (int)$posX;
        $posY = (int)$posY;
        return true;
    }

}
