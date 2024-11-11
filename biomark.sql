-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2024 at 06:12 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `biomark`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_of_birth` date DEFAULT NULL,
  `time_of_birth` time DEFAULT NULL,
  `location_of_birth` varchar(255) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `height` float DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `eye_colour` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`, `date_of_birth`, `time_of_birth`, `location_of_birth`, `blood_group`, `sex`, `height`, `ethnicity`, `eye_colour`) VALUES
(1, 'qqq', 'newemail@example.com', 'newpassword123', '2024-11-10 20:22:54', NULL, NULL, NULL, NULL, NULL, 180, 'Asian', 'Brown'),
(3, 'Ramath', 'ramath.perera08@gmail.com', 'Ramath@123', '2024-11-11 03:31:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '', '', '', '2024-11-11 03:41:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'john_doe', 'john.doe@example.com', 'securepassword123', '2024-11-11 14:51:09', '1990-01-01', '10:30:00', 'New York, USA', 'O+', 'Male', 5.9, 'Caucasian', 'Blue'),
(6, 'Manil', 'maniltenuka2001@gmail.com', '123', '2024-11-11 14:58:19', '0000-00-00', '00:00:00', '', '', '', 0, '', ''),
(7, 'sdf', 'ewrw', 'e4r34', '2024-11-11 15:00:19', '0000-00-00', '00:00:00', '', '', '', 0, '', ''),
(8, 'manil1', 'manil@gmail.con', '123', '2024-11-11 15:04:34', '0000-00-00', '00:00:00', '', '', '', 0, '', ''),
(9, 'manil', 'manil@gmail.com', '123', '2024-11-11 17:07:08', '0000-00-00', '00:00:00', '', '', '', 175, 'Sinhala', 'Black');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
