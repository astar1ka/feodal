<?php
    class Gamer {
        function __construct($db) {
            $this->db = $db;
        }

        private function getCastleLevelCost($level) {
            return 300*$level + $level*$level*200;
        }

        public function getCastle($gamer) {
            return array(
                'castle'=>$this->db->getCastle($gamer)
            );
        }

        public function addCastle($user) {
            //Сделать рандомные координаты
            $this->db->addCastle($user, 1, 1);
            $hash = md5(rand());
            $this->db->setMapHash($hash);
            return true;
        }

        public function upgradeCastle($gamer) {
            $castle = $this->db->getCastle($gamer->id);
            if ($castle->Level<5) {
                $cost = $this->getCastleLevelCost($castle->level);
                if ($gamer->money>=$cost) {
                    $this->db->castleLevelUp($castle->id);
                    $this->db->updateMoney($user, -$cost);
                    $hash = md5(rand());
                    $this->db->setMapHash($hash);
                    return array (
                        'gold'=>$this->db->getGold($user)
                    );
                }
            }
        }

        public function buyUnit($gamer, $unitType) {
            $castle = $this->db->getCastle($gamer->id);
            $money = $gamer->money;
            $cost = $this->db->getUnitCost($unitType);
            if ($money>=$cost) {
                $this->db->addUnit($gamer->id, $unitType);
                $this->db->updateGold($user, -$cost);
                $hash = md5(rand());
                $this->db->setUnitsHash($hash);
                return array ('money'=>$this->db->getGold($user));
            }
        }

        public function getGamer($user) {
            return $this->db->getGamer($user);
        }
    }