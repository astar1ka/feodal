<?php
    class Gamer {
        function __construct($db,$map) {
            $this->db = $db;
            $this->map=$map;
        }

        public function getCastleLevelCost($level) {
            return 300*$level + $level*$level*200;
        }

        public function addCastle($userId) {
            $castleX = rand(10000,80000) / 1000;
            $castleY = rand(10000,80000) / 1000;

            $nextRentTime = microtime(true) + 7200000;

            $castleColor = '#' . substr(md5(mt_rand()), 0, 6);

            $this->db->addCastle($userId, $castleColor, $castleX, $castleY, $nextRentTime);

            $gamer = $this->db->getGamer($userId);
            $unitTypeData = $this->db->getUnitTypeData(1);
            $this->db->addUnit($gamer->id, 1, $unitTypeData->hp, $gamer->posX, $gamer->posY, microtime(true));

            $hash = md5(rand());
            $this->db->setMapHash($hash);
            $this->db->setUnitsHash($hash);
            return true;
        }

        public function upgradeCastle($gamer) {
            if ($gamer->level < 5) {
                $cost = $this->getCastleLevelCost($gamer->level);
                if ($gamer->money >= $cost) {
                    $this->db->castleLevelUp($gamer->id);
                    $this->db->updateMoney($gamer->id, -$cost);
                    $hash = md5(rand());
                    $this->db->setMapHash($hash);
                    return array (
                        'money'=>$this->db->getMoney($gamer->id),
                        'castleUpgradeCost'=> $this->getCastleLevelCost($gamer->level+1)
                    );
                }
            }
        }

        public function buyUnit($gamer, $unitType) {
            $unitTypeData = $this->db->getUnitTypeData($unitType);
            if ($gamer->money >= $unitTypeData->cost) {
                $this->db->addUnit($gamer->id, $unitType, $unitTypeData->hp, $gamer->posX, $gamer->posY);
                $this->db->updateMoney($gamer->id, -$unitTypeData->cost);
                $hash = md5(rand());
                $this->db->setUnitsHash($hash);
                return array (
                    'money'=>$this->db->getMoney($gamer->id)
                );
            }
        }

        public function getUnitsInCastle($gamerId) {
            if ($gamerId) {
                return $this->db->getUnitsInCastle($gamerId);
            }
        }

        public function getGamer($userId) {
            return $this->db->getGamer($userId);
        }

        public function updateUnits($gamer,$myUnits,$otherUnits,$villages) {
            if ($myUnits) {
                $this->updateGamerUnits($gamer,$myUnits);
            }
            if ($otherUnits) {
                $this->updateOtherUnits($otherUnits);
            }
            if ($villages) {
                $this->damageVillages($villages);
            }
            $statuses = $this->db->getStatuses();
            $time = microtime(true);
            $this->db->deadUnits();
            if ($time - $statuses->mapTimeStamp >= 0.3) {
                $this->db->setMapTimeStamp($time);
                return $time;
            }
        }

        private function updateGamerUnits($gamer,$myUnits){
            $isUpdate = false;
            foreach($myUnits as $myUnit){
                $dbUnit = $this->db->getUnit($myUnit->id);
                if($myUnit && $myUnit->hp<$dbUnit->hp){
                        $this->db->updateUnit($gamer->id,$myUnit->id,$myUnit->hp,$myUnit->posX,$myUnit->posY,$myUnit->status,$myUnit->direction);
                        $isUpdate = true;
                }
            }
            if ($isUpdate) {
                $this->db->setUnitsHash(md5(rand()));
            }
        }

        private function updateOtherUnits($otherUnits){
            $isUpdate = false;
            foreach ($otherUnits as $otherUnit){
                    $dbUnit = $this->db->getUnit($otherUnit->id);
                    if ($dbUnit && $otherUnit->hp<$dbUnit->hp){
                        $this->db->updateUnitHP($otherUnit->id ,$otherUnit->hp);
                        $isUpdate = true;
                    }
            }
            if ($isUpdate) {
                $this->db->setUnitsHash(md5(rand()));
            }
        }

        private function damageVillages($villages){
            $isUpdate = false;
            foreach($villages as $village){
                if($village){
                    $dbVillage=$this->db->getVillage($village->id);
                    if($village->population<$dbVillage->population){
                        $this->db->updateVillage($village->population);
                        $isUpdate = true;
                    }
                }
            }
            if ($isUpdate){
                $this->db->setMapHash(md5(rand()));
            }
        }
    }
