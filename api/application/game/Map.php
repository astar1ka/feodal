<?php

class Map
{
    function __constuct($db)
    {
        $this->db = $db;
    }

    public function getMap() {
        return array (
            'map' => $this->db->getMap()
        );
    }
}
