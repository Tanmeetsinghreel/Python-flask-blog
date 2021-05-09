-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2021 at 08:34 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codersback`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `message`, `date`) VALUES
(1, '', 'firstpost@gmail.com', '123456789', 'test', '2021-04-21 04:06:24'),
(18, 'this', 'this@gmail.com', '4447889556', 'flashing test', '2021-05-05 16:54:31'),
(19, 'this', 'this@gmail.com', '4447889556', 'flashing test', '2021-05-05 16:56:51'),
(20, 'this', 'this@gmail.com', '4447889556', 'flashing test', '2021-05-05 16:57:14'),
(21, 'this', 'this@gmail.com', '4447889556', 'flahing test', '2021-05-05 16:57:55'),
(22, 'this', 'this@gmail.com', '4447889556', 'flahing test', '2021-05-05 17:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(2, 'This is second post', 'coolest post ever', 'second-post', 'This document describes the syntax and semantics of the template engine and will be most useful as reference to those creating Jinja templates. As the template engine is very flexible, the configuration from the application can be slightly different from the code presented here in terms of delimiters and behavior of undefined values.', 'about-bg.jpg', '2021-04-24 01:42:52'),
(3, 'Covid-19', 'This is third post', 'third-post', 'Most people infected with the COVID-19 virus will experience mild to moderate respiratory illness and recover without requiring special treatment.  Older people, and those with underlying medical problems like cardiovascular disease, diabetes, chronic respiratory disease, and cancer are more likely to develop serious illness.\r\n\r\nThe best way to prevent and slow down transmission is to be well informed about the COVID-19 virus, the disease it causes and how it spreads. Protect yourself and others from infection by washing your hands or using an alcohol based rub frequently and not touching your face. \r\n\r\nThe COVID-19 virus spreads primarily through droplets of saliva or discharge from the nose when an infected person coughs or sneeze.', '', '2021-04-24 02:08:41'),
(4, 'Bitcoin', 'This is our fourth post', 'fourth-post', 'Bitcoin[a] (₿) is a cryptocurrency invented in 2008 by an unknown person or group of people using the name Satoshi Nakamoto.[13] The currency began use in 2009[14] when its implementation was released as open-source software.[6]:ch. 1 Bitcoin is a decentralized digital currency, without a central bank or single administrator, that can be sent from user to user on the peer-to-peer bitcoin network without the need for intermediaries.[7] Transactions are verified by network nodes through cryptography and recorded in a public distributed ledger called a blockchain.\r\n\r\nBitcoins are created as a reward for a process known as mining. They can be exchanged for other currencies, products, and services,[15] but the real-world value of the coins is extremely volatile.[16] Research produced by the University of Cambridge estimated that in 2017, there were 2.9 to 5.8 million unique users using a cryptocurrency wallet, most of them using bitcoin.[17] Users choose to participate in the digital currency for a number of reasons: ideologies such as commitment to anarchism, decentralization and libertarianism, convenience, using the currency as an investment and pseudonymity of transactions. Increased use has led to a desire among governments for regulation in order to tax, facilitate legal use in trade and for other reasons (such as investigations for money laundering and price manipulation).', '', '2021-04-24 02:08:41'),
(5, 'Hardware', 'LOfraii post', 'fifth-post', 'omputer hardware includes the physical parts of a computer, such as the case,[1] central processing unit (CPU), monitor, mouse, keyboard, computer data storage, graphics card, sound card, speakers and motherboard.[2]\r\n\r\nBy contrast, software is the set of instructions that can be stored and run by hardware. Hardware is so-termed because it is \"hard\" or rigid with respect to changes, whereas software is \"soft\" because it is easy to change.\r\n\r\nHardware is typically directed by the software to execute any command or instruction. A combination of hardware and software forms a usable computing system, although other systems exist with only hardware.', '', '2021-04-24 02:09:45'),
(8, 'new', 'try', 'test', 'testing hai', '', '2021-05-05 16:15:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
