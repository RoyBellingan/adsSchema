-- MySQL dump 10.17  Distrib 10.3.16-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: adwords
-- ------------------------------------------------------
-- Server version	10.3.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CampaignCriterion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CampaignCriterion` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `campaign` varchar(255) GENERATED ALWAYS AS (json_value(`value`,'$.campaign.value')) VIRTUAL,
  `remote_id` bigint(20) unsigned GENERATED ALWAYS AS (json_value(`value`,'$.criterion_id.value')) VIRTUAL,
  `resource_name` varchar(255) GENERATED ALWAYS AS (json_value(`value`,'$.resource_name')) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `campaign` (`campaign`),
  KEY `remote_id` (`remote_id`),
  CONSTRAINT `CampaignCriterion_ibfk_1` FOREIGN KEY (`campaign`) REFERENCES `Campaign` (`resource_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-11 15:04:19
