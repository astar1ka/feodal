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

        public function getScene($updates, $unitsHash, $mapHash) {
            $unitsHashDB = $this->db->getUnitsHash();
            if ($unitsHash != $unitsHashDB) {
                $units = $this->db->getUnits();
            }
            $castlesHashDB = $this->db->getMapHash();
            if ($unitsHash != $unitsHashDB) {
                $castles = $this->db->getCastles();
            }
            return array (
                'unitsHash' => $unitsHashDB,
                'castlesHash' => $castlesHashDB,
                'castles' => $castles,
                'unit' => $units
            );
        } 

    }