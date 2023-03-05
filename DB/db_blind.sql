# HeidiSQL Dump 
#
# --------------------------------------------------------
# Host:                         127.0.0.1
# Database:                     db_blind
# Server version:               5.0.51b-community-nt
# Server OS:                    Win32
# Target compatibility:         ANSI SQL
# HeidiSQL version:             4.0
# Date/time:                    2021-06-13 01:48:06
# --------------------------------------------------------

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI,NO_BACKSLASH_ESCAPES';*/
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;*/


#
# Database structure for database 'db_blind'
#

CREATE DATABASE /*!32312 IF NOT EXISTS*/ "db_blind" /*!40100 DEFAULT CHARACTER SET latin1 */;

USE "db_blind";


#
# Table structure for table 'tbl_admin'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_admin" (
  "admin_id" int(10) unsigned NOT NULL auto_increment,
  "admin_name" varchar(50) NOT NULL,
  "admin_email" varchar(50) NOT NULL,
  "admin_password" varchar(50) NOT NULL,
  PRIMARY KEY  ("admin_id")
) AUTO_INCREMENT=2;



#
# Dumping data for table 'tbl_admin'
#

LOCK TABLES "tbl_admin" WRITE;
/*!40000 ALTER TABLE "tbl_admin" DISABLE KEYS;*/
REPLACE INTO "tbl_admin" ("admin_id", "admin_name", "admin_email", "admin_password") VALUES
	('1','Suraj K S','surajks@gmail.com','SurajKS@123');
/*!40000 ALTER TABLE "tbl_admin" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_district'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_district" (
  "district_id" int(10) unsigned NOT NULL auto_increment,
  "district_name" varchar(50) NOT NULL,
  PRIMARY KEY  ("district_id")
) AUTO_INCREMENT=3;



#
# Dumping data for table 'tbl_district'
#

LOCK TABLES "tbl_district" WRITE;
/*!40000 ALTER TABLE "tbl_district" DISABLE KEYS;*/
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('1','Idukki');
REPLACE INTO "tbl_district" ("district_id", "district_name") VALUES
	('2','Ernakulam');
/*!40000 ALTER TABLE "tbl_district" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_location'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_location" (
  "location_id" int(10) unsigned NOT NULL auto_increment,
  "location_name" varchar(50) NOT NULL,
  "location_longitude" varchar(50) NOT NULL,
  "location_latitude" varchar(50) NOT NULL,
  "district_id" int(10) unsigned NOT NULL,
  PRIMARY KEY  ("location_id")
) AUTO_INCREMENT=5;



#
# Dumping data for table 'tbl_location'
#

LOCK TABLES "tbl_location" WRITE;
/*!40000 ALTER TABLE "tbl_location" DISABLE KEYS;*/
REPLACE INTO "tbl_location" ("location_id", "location_name", "location_longitude", "location_latitude", "district_id") VALUES
	('1','Thodupuzha','76.7077113','9.8942117','1');
REPLACE INTO "tbl_location" ("location_id", "location_name", "location_longitude", "location_latitude", "district_id") VALUES
	('2','Vengalloor','-122.0840236','37.4219795','1');
REPLACE INTO "tbl_location" ("location_id", "location_name", "location_longitude", "location_latitude", "district_id") VALUES
	('3','Vazhakulam','76.6403389','9.9438775','2');
REPLACE INTO "tbl_location" ("location_id", "location_name", "location_longitude", "location_latitude", "district_id") VALUES
	('4','Muvattupuzha','76.5858876','9.9795037','2');
/*!40000 ALTER TABLE "tbl_location" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_route'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_route" (
  "route_id" int(10) unsigned NOT NULL auto_increment,
  "route_name" varchar(50) NOT NULL,
  "location_from" int(10) unsigned NOT NULL,
  "location_to" int(10) unsigned NOT NULL,
  "route_time" varchar(50) NOT NULL,
  PRIMARY KEY  ("route_id")
) AUTO_INCREMENT=2;



#
# Dumping data for table 'tbl_route'
#

LOCK TABLES "tbl_route" WRITE;
/*!40000 ALTER TABLE "tbl_route" DISABLE KEYS;*/
REPLACE INTO "tbl_route" ("route_id", "route_name", "location_from", "location_to", "route_time") VALUES
	('1','Thodupuzha-Muvattupuzha','1','4','30');
/*!40000 ALTER TABLE "tbl_route" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_schedule'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_schedule" (
  "schedule_id" int(10) unsigned NOT NULL auto_increment,
  "route_id" int(10) unsigned NOT NULL,
  "schedule_time" varchar(50) NOT NULL,
  "bus_name" varchar(50) NOT NULL,
  PRIMARY KEY  ("schedule_id")
) AUTO_INCREMENT=5;



#
# Dumping data for table 'tbl_schedule'
#

LOCK TABLES "tbl_schedule" WRITE;
/*!40000 ALTER TABLE "tbl_schedule" DISABLE KEYS;*/
REPLACE INTO "tbl_schedule" ("schedule_id", "route_id", "schedule_time", "bus_name") VALUES
	('1','1','10:00','Thusharam');
REPLACE INTO "tbl_schedule" ("schedule_id", "route_id", "schedule_time", "bus_name") VALUES
	('2','1','10:20','Yathra');
REPLACE INTO "tbl_schedule" ("schedule_id", "route_id", "schedule_time", "bus_name") VALUES
	('3','1','10:30','LMS');
REPLACE INTO "tbl_schedule" ("schedule_id", "route_id", "schedule_time", "bus_name") VALUES
	('4','1','12:12','Volvo');
/*!40000 ALTER TABLE "tbl_schedule" ENABLE KEYS;*/
UNLOCK TABLES;


#
# Table structure for table 'tbl_stop'
#

CREATE TABLE /*!32312 IF NOT EXISTS*/ "tbl_stop" (
  "stop_id" int(10) unsigned NOT NULL auto_increment,
  "route_id" int(10) unsigned NOT NULL,
  "stop_number" int(10) unsigned NOT NULL,
  "location_id" int(10) unsigned NOT NULL,
  "stop_time" varchar(50) NOT NULL,
  PRIMARY KEY  ("stop_id")
) AUTO_INCREMENT=5;



#
# Dumping data for table 'tbl_stop'
#

LOCK TABLES "tbl_stop" WRITE;
/*!40000 ALTER TABLE "tbl_stop" DISABLE KEYS;*/
REPLACE INTO "tbl_stop" ("stop_id", "route_id", "stop_number", "location_id", "stop_time") VALUES
	('1','1','1','1','5');
REPLACE INTO "tbl_stop" ("stop_id", "route_id", "stop_number", "location_id", "stop_time") VALUES
	('2','1','2','2','10');
REPLACE INTO "tbl_stop" ("stop_id", "route_id", "stop_number", "location_id", "stop_time") VALUES
	('3','1','3','3','15');
REPLACE INTO "tbl_stop" ("stop_id", "route_id", "stop_number", "location_id", "stop_time") VALUES
	('4','1','4','4','15');
/*!40000 ALTER TABLE "tbl_stop" ENABLE KEYS;*/
UNLOCK TABLES;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE;*/
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;*/
