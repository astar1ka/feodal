<?php
    class Gamer {
        function __construct($db) {
            $this->db = $db;
        }

        public function getCastle($gamer) {
            return array('castle'=>$this->db->getCastle($gamer));
        }

        public function addCastle($user) {
            //Сделать рандомные координаты
            $this->db->addCastle($user, 1, 1);
            $hash = md5(rand());
            $this->db->setMapHash($hash);
            return true;
        }

        public function upgradeCastle($gamer) {
            $castle = $this->db->getCastle($gamer);
            if ($castle && $castle->Level<5) {
                $money = $gamer->money;
                $cost = $castle->Level
                if ($money>=$cost) {
                    $this->db->castleLevelUp($castle->id);
                    $this->db->updateMoney($user, -$cost);
                    $hash = md5(rand());
                    $this->db->setMapHash($hash);
                    return array ('gold'=>$this->db->getGold($user));
                }
            }
        }

        public function getGamer($user) {
            return $this->db->getGamer($user);
        }
    }