-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 08 2022 г., 23:35
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Структура таблицы `gamers`
--

CREATE TABLE `gamers` (
  `id` int NOT NULL,
  `userId` int NOT NULL,
  `money` int NOT NULL DEFAULT '1000',
  `castleLevel` int NOT NULL DEFAULT '1',
  `castleX` double NOT NULL,
  `castleY` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `gamers`
--

INSERT INTO `gamers` (`id`, `userId`, `money`, `castleLevel`, `castleX`, `castleY`) VALUES
(4, 3, 1000, 1, 1, 1),
(5, 2, 661, 1, 40.411, 1.687);

-- --------------------------------------------------------

--
-- Структура таблицы `maps`
--

CREATE TABLE `maps` (
  `id` int NOT NULL,
  `name` varchar(256) NOT NULL,
  `tiles` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `userId` int NOT NULL,
  `message` varchar(256) NOT NULL,
  `messageTo` int DEFAULT NULL
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
(13, 2, '765233765234', NULL),
(14, 2, 'Привет', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `id` int NOT NULL,
  `chatHash` varchar(256) NOT NULL,
  `mapHash` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `unitsHash` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mapTimeStamp` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `chatHash`, `mapHash`, `unitsHash`, `mapTimeStamp`) VALUES
(1, '1b775eae1a2e078b504ed597b57a1357', '8264cea6fac62353407447f366f7837e', '36316421dbf4dd08d47f5a96f8ba187f', '1667939687');

-- --------------------------------------------------------

--
-- Структура таблицы `units`
--

CREATE TABLE `units` (
  `id` int NOT NULL,
  `type` int NOT NULL,
  `gamerId` int NOT NULL,
  `hp` int NOT NULL,
  `posX` double NOT NULL DEFAULT '0',
  `posY` double DEFAULT '0',
  `status` varchar(256) NOT NULL DEFAULT 'inCastle',
  `direction` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `units`
--

INSERT INTO `units` (`id`, `type`, `gamerId`, `hp`, `posX`, `posY`, `status`, `direction`) VALUES
(36, 1, 4, 10, 1, 1, 'inCastle', ''),
(37, 1, 4, 10, 1, 1, 'inCastle', ''),
(39, 1, 4, 10, 0, 0, 'inCastle', NULL),
(40, 1, 4, 10, 1, 1, 'inCastle', NULL),
(41, 1, 5, 10, 0, 0, 'inCastle', NULL),
(42, 1, 5, 10, 0, 0, 'inCastle', NULL),
(43, 1, 5, 10, 0, 0, 'inCastle', NULL),
(44, 1, 5, 10, 40.411, 1.687, 'inCastle', NULL),
(45, 1, 5, 10, 40.411, 1.687, 'inCastle', NULL),
(46, 1, 5, 10, 40.411, 1.687, 'inCastle', NULL),
(47, 1, 5, 10, 40.411, 1.687, 'inCastle', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `unitstypes`
--

CREATE TABLE `unitstypes` (
  `id` int NOT NULL,
  `name` varchar(256) NOT NULL,
  `hp` int NOT NULL,
  `cost` int NOT NULL,
  `damage` int NOT NULL,
  `speed` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `unitstypes`
--

INSERT INTO `unitstypes` (`id`, `name`, `hp`, `cost`, `damage`, `speed`) VALUES
(1, 'soldier', 10, 100, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
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
(2, 'admin', 'admin', 'Administrator', 'd5752a359f4c715657f4b68155066342');

-- --------------------------------------------------------

--
-- Структура таблицы `villages`
--

CREATE TABLE `villages` (
  `id` int NOT NULL,
  `name` varchar(256) NOT NULL,
  `level` int NOT NULL DEFAULT '1',
  `population` int NOT NULL DEFAULT '10',
  `posX` double NOT NULL,
  `posY` double NOT NULL,
  `money` int NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `villages`
--

INSERT INTO `villages` (`id`, `name`, `level`, `population`, `posX`, `posY`, `money`) VALUES
(3, 'Верхние Потёмки', 2, 10, 1, 1, -565),
(8, 'Далёкие Удалёнки', 1, 10, 0.429, 29.268, 180),
(10, 'Болотистые Разгромки', 1, 10, 9.95, 72.214, 140),
(11, 'Нижние Свистульки', 1, 10, 116.092, 77.843, 120),
(12, 'Нижние Удалёнки', 1, 10, 43.592, 116.777, 100);

--
-- Индексы сохранённых таблиц
--

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `gamerId` (`gamerId`);

--
-- Индексы таблицы `unitstypes`
--
ALTER TABLE `unitstypes`
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
-- AUTO_INCREMENT для таблицы `gamers`
--
ALTER TABLE `gamers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `maps`
--
ALTER TABLE `maps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `units`
--
ALTER TABLE `units`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT для таблицы `unitstypes`
--
ALTER TABLE `unitstypes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `villages`
--
ALTER TABLE `villages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`gamerId`) REFERENCES `gamers` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
