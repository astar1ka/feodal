<?php
    class Game {
        function __construct($db) {
            $this->db = $db;
        }

        public function getMap() {
            return array (
                'map' => $this->db->getMap(1)
            );
        }

        public function getUnitsTypes() {
            return $this->db->getUnitsTypes();
        }

        public function getScene($updates, $unitsHash, $mapHash) {
            $unitsHashDB = $this->db->getUnitsHash();
            if ($unitsHash != $unitsHashDB) {
                $units = $this->db->getUnits();
                
            }
            $mapHashDB = $this->db->getMapHash();
            if ($unitsHash != $unitsHashDB) {
                $castles = $this->db->getCastles();
                $villages = $this->db->getVillages();
            }
            return array (
                'unitsHash' => $unitsHashDB,
                'mapHash' => $castlesHashDB,
                'castles' => $castles,
                'villages' => $villages,
                'unit' => $units
            );
        } 
    }