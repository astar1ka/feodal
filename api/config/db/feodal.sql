-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3308
-- Время создания: Ноя 02 2022 г., 10:08
-- Версия сервера: 8.0.15
-- Версия PHP: 7.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `feodal`
--

-- --------------------------------------------------------

--
-- Структура таблицы `castles`
--

CREATE TABLE `castles` (
  `id` int(11) NOT NULL,
  `gamerId` int(11) NOT NULL,
  `lvl` int(11) NOT NULL DEFAULT '1',
  `money` int(11) NOT NULL DEFAULT '1000',
  `posX` double NOT NULL,
  `posY` double NOT NULL,
  `hp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `castles`
--

INSERT INTO `castles` (`id`, `gamerId`, `lvl`, `money`, `posX`, `posY`, `hp`) VALUES
(2, 2, 1, 1000, 1, 2, 300);

-- --------------------------------------------------------

--
-- Структура таблицы `castleslevels`
--

CREATE TABLE `castleslevels` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `maxHp` int(11) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `castleslevels`
--

INSERT INTO `castleslevels` (`id`, `name`, `maxHp`, `cost`) VALUES
(1, 'Гортус', 300, 0),
(2, 'Виртус', 650, 1000),
(3, 'Принципал', 1200, 2500),
(4, 'Торнорум', 2000, 10000),
(5, 'Доминион', 5000, 45000);

-- --------------------------------------------------------

--
-- Структура таблицы `gamers`
--

CREATE TABLE `gamers` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT '1000',
  `castleLevel` int(11) NOT NULL DEFAULT '1',
  `castleX` varchar(256) NOT NULL,
  `castleY` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `gamers`
--

INSERT INTO `gamers` (`id`, `userId`, `money`, `castleLevel`, `castleX`, `castleY`) VALUES
(3, 2, 1000, 1, '1', '1');

-- --------------------------------------------------------

--
-- Структура таблицы `maps`
--

CREATE TABLE `maps` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `tiles` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `message` varchar(256) NOT NULL,
  `messageTo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `messages`
--

INSERT INTO `messages` (`id`, `userId`, `message`, `messageTo`) VALUES
(7, 2, 'ghbdtn', NULL),
(8, 2, 'ghbdtn', NULL),
(9, 2, 'ghbdtn', 2),
(10, 2, 'ghbdtn', NULL),
(11, 2, 'ghbdtn', NULL),
(12, 2, 'ghbdtn', NULL),
(13, 2, '765233765234', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `chatHash` varchar(256) NOT NULL,
  `mapHash` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `unitsHash` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mapTimeStamp` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `chatHash`, `mapHash`, `unitsHash`, `mapTimeStamp`) VALUES
(1, '1c59238c623f34cfe3a0d4fdbcffb595', '77a7837e9e5f790d170b79b55e64dc2d', 'c3bd042044ed6cd0ea3767e23435ff29', '');

-- --------------------------------------------------------

--
-- Структура таблицы `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `gamerId` int(11) NOT NULL,
  `hp` int(11) NOT NULL,
  `posX` double NOT NULL DEFAULT '0',
  `posY` double DEFAULT '0',
  `status` varchar(256) NOT NULL DEFAULT 'inCastle',
  `direction` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `units`
--

INSERT INTO `units` (`id`, `type`, `gamerId`, `hp`, `posX`, `posY`, `status`, `direction`) VALUES
(33, 1, 2, 10, 0, 0, 'inCastle', ''),
(34, 1, 2, 10, 0, 0, 'inCastle', ''),
(35, 1, 2, 10, 0, 0, 'inCastle', '');

-- --------------------------------------------------------

--
-- Структура таблицы `unittypes`
--

CREATE TABLE `unittypes` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `hp` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  `damage` int(11) NOT NULL,
  `speed` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `unittypes`
--

INSERT INTO `unittypes` (`id`, `name`, `hp`, `cost`, `damage`, `speed`) VALUES
(1, 'soldier', 10, 100, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(256) NOT NULL,
  `token` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `name`, `token`) VALUES
(1, 'vasya', '12345', 'Vasya Pupkin', NULL),
(2, 'admin', 'admin', 'Administrator', '');

-- --------------------------------------------------------

--
-- Структура таблицы `villages`
--

CREATE TABLE `villages` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `level` int(11) NOT NULL,
  `population` int(11) NOT NULL,
  `posX` double NOT NULL,
  `posY` double NOT NULL,
  `money` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `castles`
--
ALTER TABLE `castles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `castleslevels`
--
ALTER TABLE `castleslevels`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gamers`
--
ALTER TABLE `gamers`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `maps`
--
ALTER TABLE `maps`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `unittypes`
--
ALTER TABLE `unittypes`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Индексы таблицы `villages`
--
ALTER TABLE `villages`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `castles`
--
ALTER TABLE `castles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `castleslevels`
--
ALTER TABLE `castleslevels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `gamers`
--
ALTER TABLE `gamers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `maps`
--
ALTER TABLE `maps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT для таблицы `unittypes`
--
ALTER TABLE `unittypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `villages`
--
ALTER TABLE `villages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
