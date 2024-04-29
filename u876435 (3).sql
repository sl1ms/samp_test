-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Апр 29 2024 г., 17:12
-- Версия сервера: 10.4.24-MariaDB
-- Версия PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `u876435`
--

-- --------------------------------------------------------

--
-- Структура таблицы `accessories`
--

CREATE TABLE `accessories` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `slot1` int(11) DEFAULT NULL,
  `slot2` int(11) DEFAULT NULL,
  `slot3` int(11) DEFAULT NULL,
  `slot4` int(11) DEFAULT NULL,
  `slot5` int(11) DEFAULT NULL,
  `slot6` int(11) DEFAULT NULL,
  `slot7` int(11) DEFAULT NULL,
  `slot8` int(11) DEFAULT NULL,
  `slot9` int(11) DEFAULT NULL,
  `slot10` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

-- --------------------------------------------------------

--
-- Структура таблицы `accessories_data`
--

CREATE TABLE `accessories_data` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL,
  `slot` tinyint(4) NOT NULL,
  `model` int(11) NOT NULL,
  `bone` tinyint(4) NOT NULL,
  `offset_x` float NOT NULL,
  `offset_y` float NOT NULL,
  `offset_z` float NOT NULL,
  `rot_x` float NOT NULL,
  `rot_y` float NOT NULL,
  `rot_z` float NOT NULL,
  `scale_x` float NOT NULL,
  `scale_y` float NOT NULL,
  `scale_z` float NOT NULL,
  `materialcolor1` int(11) NOT NULL,
  `materialcolor2` int(11) NOT NULL,
  `description_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Дамп данных таблицы `accessories_data`
--

INSERT INTO `accessories_data` (`id`, `name`, `slot`, `model`, `bone`, `offset_x`, `offset_y`, `offset_z`, `rot_x`, `rot_y`, `rot_z`, `scale_x`, `scale_y`, `scale_z`, `materialcolor1`, `materialcolor2`, `description_id`) VALUES
(1, 'Красная шапка', 0, 19067, 2, 0.118997, 0.003, -0.004, 0, 90, 96.4, 1.059, 1.16, 1, 0, 0, 1),
(2, 'Бандана', 0, 18910, 2, 0.12, -0.001, 0, -92.5, -7.19999, -98.1, 1.115, 1, 0.901, 0, 0, 2),
(3, 'Очки', 1, 19140, 2, 0.102998, 0.030999, -0.001001, 0, 90, 90.5, 1, 1.058, 1, 0, 0, 3),
(4, 'Наушники', 1, 19421, 2, 0.286, 0.089, -0.006, -90.6, -122, 92.6, 1, 1, 1, 0, 0, 4),
(5, 'Усы', 1, 19350, 2, 0.025999, 0.108, 0.003, 0, 0, -81.4, 1, 1, 1, 0, 0, 5),
(6, 'Повязка на глаз', 1, 19085, 2, 0.102999, 0.02, -0.003999, -2.9, 91.7001, 94, 0.911999, 1.069, 1, 0, 0, 6),
(7, 'Часы', 1, 19039, 6, -0.018999, -0.003998, -0.001999, 51.2, 53.2, 142.8, 0.963999, 0.916999, 1, 0, 0, 7),
(8, 'Рюкзак', 2, 19559, 1, -0.204, -0.064999, -0.002999, -0.6, -1.1, 0, 1.076, 0.918998, 0.905, 0, 0, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `accessories_descriptions`
--

CREATE TABLE `accessories_descriptions` (
  `id` int(11) NOT NULL,
  `description` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `accessories_descriptions`
--

INSERT INTO `accessories_descriptions` (`id`, `description`) VALUES
(1, 'Классическая красная шапка, которая придает носителю задорный вид.'),
(2, 'Многофункциональная бандана, которую можно носить как на голове, так и на шее.'),
(3, 'Стильные очки, которые защищают глаза от солнца и добавляют носителю интеллектуальный вид.'),
(4, 'Мощные наушники, которые обеспечивают превосходное качество звука и погружают носителя в музыку'),
(5, 'Великолепные усы, которые придают носителю мужественный и харизматичный вид'),
(6, 'Таинственная повязка на глаз, которая скрывает один глаз и придает носителю загадочный вид.'),
(7, 'Элегантные часы, которые не только показывают время, но и являются стильным аксессуаром.'),
(8, 'Прочный рюкзак, который позволяет носителю удобно переносить предметы и всегда иметь под рукой все необходимое.');

-- --------------------------------------------------------

--
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accessories`
--
ALTER TABLE `accessories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slot1` (`slot1`),
  ADD KEY `slot2` (`slot2`),
  ADD KEY `slot3` (`slot3`),
  ADD KEY `slot4` (`slot4`),
  ADD KEY `slot5` (`slot5`),
  ADD KEY `slot6` (`slot6`),
  ADD KEY `slot7` (`slot7`),
  ADD KEY `slot8` (`slot8`),
  ADD KEY `slot9` (`slot9`),
  ADD KEY `slot10` (`slot10`),
  ADD KEY `account_id` (`account_id`);

--
-- Индексы таблицы `accessories_data`
--
ALTER TABLE `accessories_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `description_id` (`description_id`);

--
-- Индексы таблицы `accessories_descriptions`
--
ALTER TABLE `accessories_descriptions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accessories`
--
ALTER TABLE `accessories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `accessories_data`
--
ALTER TABLE `accessories_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `accessories_descriptions`
--
ALTER TABLE `accessories_descriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `accessories`
--
ALTER TABLE `accessories`
  ADD CONSTRAINT `accessories_ibfk_1` FOREIGN KEY (`slot1`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_10` FOREIGN KEY (`slot5`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_11` FOREIGN KEY (`slot6`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_12` FOREIGN KEY (`slot7`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_13` FOREIGN KEY (`slot8`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_14` FOREIGN KEY (`slot9`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_15` FOREIGN KEY (`slot10`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_16` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `accessories_ibfk_2` FOREIGN KEY (`slot2`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_3` FOREIGN KEY (`slot3`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_4` FOREIGN KEY (`slot4`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_5` FOREIGN KEY (`slot5`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_6` FOREIGN KEY (`slot6`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_7` FOREIGN KEY (`slot2`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_8` FOREIGN KEY (`slot3`) REFERENCES `accessories_data` (`id`),
  ADD CONSTRAINT `accessories_ibfk_9` FOREIGN KEY (`slot4`) REFERENCES `accessories_data` (`id`);

--
-- Ограничения внешнего ключа таблицы `accessories_data`
--
ALTER TABLE `accessories_data`
  ADD CONSTRAINT `accessories_data_ibfk_1` FOREIGN KEY (`description_id`) REFERENCES `accessories_descriptions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
