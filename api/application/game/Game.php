<?php
    class Game {
        function __construct($db,$map) {
            $this->db = $db;
            $this->map = $map;
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

        public function getMap() { 
            return $this->map->getMap();     
        }

        public function getUnitsTypes() {
            return $this->db->getUnitsTypes();
        }

        public function getVillage($villageId) {
            return $this->db->getVillage($villageId);
        }

        public function getCastle($castleId) {
            if ($castleId) {
                return $this->db->getCastle($castleId);
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
            if ($time - $village->lastUpdate >= 1000 * 60 * 5) {
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
            
            } else{$level= $village->level;}
            // записать в БД
            $this->db->updateVillage($id,$money,$level,$population,$time);
            $this->db->setMapHash(md5(rand()));
            }
            }
            
            // обновить все замки
            //...
            
            }
    }