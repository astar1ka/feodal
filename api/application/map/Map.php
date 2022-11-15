<?php

class Map{
    function __constuct($db){
        $this->db = $db;
    }

    public function getMap() {
        $array= $this->db->getMap();
        return $object = array(
            'layer1' => $array[0],
            'layer2' => $array[1],
            'layer3' => $array[2] 
        );
    }
}
