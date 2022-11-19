<?php
    class Game {
        function __construct($db,$map, $config) {
            $this->db = $db;
            $this->map = $map;
            $this->config=$config;
        }

        public function addVillage(){
            $posX = rand(0,160000) / 1000;
            $posY = rand(0,160000) / 1000;
            switch (rand(1,4)) {
                case 1: $subname="Верхние"; break;
                case 2: $subname="Нижние"; break;
                case 3: $subname="Болотистые"; break;
                case 4: $subname="Далёкие"; break;
            }
            switch (rand(1,4)) {
                case 1: $name="Потёмки"; break;
                case 2: $name="Свистульки"; break;
                case 3: $name="Разгромки"; break;
                case 4: $name="Удалёнки"; break;
            }
            $this->db->createVillage($subname.' '.$name, $posX, $posY);
        }

        public function addCastle($userId, $color, $level) {
            $posX = rand(0,160000) / 1000;
            $posY = rand(0,160000) / 1000;            
            $this->db->addCastle($userId, $color, $level, $posX, $posY);
            
            $unitTypeData = $this->db->getUnitTypeData(1);
            $this->db->addUnit($gamer->id, 1, $unitTypeData->hp, $posX, $posY, microtime(true));

            $hash = md5(rand());
            $this->db->setMapHash($hash);
            $this->db->setUnitsHash($hash);
            return true;
        }

        public function destroyCastle($gamer, $userId) {
            $this->db->destroyCastle($userId);
            $this->db->updateMoney($gamer->id, $gamer->money);
            return true;
        }

        public function getMap() {
            $map = $this->db->getMap(1);
            return array(
                'map'=>array(
                    'ground'=>json_decode($map->ground),
                    'plants'=>json_decode($map->plants),
                    'trees'=>json_decode($map->trees)
                ));
        }

        public function getUnitsTypes() {
            return $this->db->getUnitsTypes();
        }

        public function getVillage($villageId) {
            return $this->db->getVillage($villageId);
        }

        public function getCastle($userId) {
            if ($userId) {
                return $this->db->getCastle($userId);
            }
        }

        public function getScene($unitsHash, $mapHash) {
            $statuses = $this->db->getStatuses();
            if (
                $unitsHash === $statuses->unitsHash && 
                $mapHash === $statuses->mapHash
            ) {
                return false;
            }
            $result = array(
                'unitsHash' => $statuses->unitsHash,
                'mapHash' => $statuses->mapHash,
                'castles' => array(), 
                'villages' => array(),
                'units' => array()
            );
            if ($unitsHash !== $statuses->unitsHash) {
                $result['units'] = $this->db->getUnits();
            }
            if ($mapHash !== $statuses->mapHash) { 
                $result['castles'] = $this->db->getCastles();
                $result['villages'] = $this->db->getVillages();                   
            }
            return $result;
        }

        public function updateMap($time) {
            // обновить все деревни
            $villages = $this->db->getVillages();
            foreach ($villages as $village) {
                if ((float)$time>=(float)$village->nextUpdateTime) {
                    $id= $village->id;
                    // посчитать новую популяцию
                    $population = $village->population + rand(1, 1+round($village->population/10,0,PHP_ROUND_HALF_EVEN));
                    // посчитать новые деньги
                    $money = $village->money + rand(1,$village->level*(1+round($village->population/10,0,PHP_ROUND_HALF_EVEN)));
                    // увеличить уровень если чо
                    $cost = 300*$village->level + $village->level*$village->level*200;
                    if ($village->money >= $cost && $village->level <5 ){
                        $level =$village->level +1;
                        $money = $village->money - $cost;
                    } else{$level= $village->level;};
            // записать в БД
            $this->db->updateVillage($id,$money,$level,$population,$time+rand(60*$this->config->intervalUpdateVillage,60*$this->config->intervalUpdateVillage+100-10*$village->level));
            $this->db->setMapHash(md5(rand()));
            }
            }
            
            // обновить все замки
            //...
            $castles = $this->db->getCastles();
            foreach ($castles as $castle){
                if($time - $castle->lastRent>=60*$this->config->intervalRentMinutes){
                    $rent= $this->db->getUnitsTypes()->rent * $this->db->countUnitsGamer($castle->id);
                    $gamer= $this->db->$castle->id;
                    $this->db->updateMoney($gamer,-$rent);
                    if($castle->money-$rent<=0) {
                        $this->db->destroyCastle($gamer);
                    }
                    $this->db->setMapHash(md5(rand()));
                }
            }

            }
    }