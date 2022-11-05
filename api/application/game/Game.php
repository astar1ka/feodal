<?php
    class Game {
        function __construct($db) {
            $this->db = $db;
        }

        public function buyUnit($user, $unitType) {
            $castle = $this->db->getCastle($user);
            if ($castle) {
                $gold = $this->db->getGold($user);
                $cost = $this->db->getUnitCost($unitType);
                if ($gold>=$cost) {
                    $this->db->addUnit($user, $unitType);
                    $this->db->updateGold($user, -$cost);
                    $hash = md5(rand());
                    $this->db->setUnitsHash($hash);
                    return array ('gold'=>$this->db->getGold($user));
                }
            }
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