SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


CREATE TABLE `acl_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `perm_key` varchar(255) DEFAULT NULL COMMENT 'Permission Key',
  `perm_name` varchar(255) DEFAULT NULL COMMENT 'Permission Name',
  `perm_cat` varchar(255) DEFAULT NULL COMMENT 'Permission Category',
  `seq` int(11) DEFAULT NULL COMMENT 'Sequence Order',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permKey` (`perm_key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=93 ;

CREATE TABLE `acl_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL COMMENT 'Role Name',
  `role_key` varchar(255) DEFAULT NULL COMMENT 'Role Key',
  `seq` int(11) DEFAULT NULL COMMENT 'Sequence Order',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

CREATE TABLE `acl_role_perms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_key` varchar(255) DEFAULT NULL COMMENT 'Role Key',
  `perm_key` varchar(255) DEFAULT NULL COMMENT 'Permission Key',
  `value` tinyint(1) DEFAULT NULL COMMENT 'Value',
  `add_date` datetime DEFAULT NULL COMMENT 'Date Added',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=334 ;

CREATE TABLE `acl_user_perms` (
  `id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `perm_key` varchar(255) DEFAULT NULL COMMENT 'Permission Key',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  `add_date` datetime DEFAULT NULL COMMENT 'Date Added',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE `acl_user_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE `applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `pvt_key` varchar(255) NOT NULL,
  `active` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

CREATE TABLE `audit_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL COMMENT 'Encounter ID',
  `event` varchar(255) DEFAULT NULL COMMENT 'Event description',
  `facility` varchar(255) DEFAULT NULL COMMENT 'Witch facility',
  `patient_id` int(11) DEFAULT NULL COMMENT 'Patient ID',
  `user_id` int(11) DEFAULT NULL COMMENT 'User ID',
  `user` varchar(255) DEFAULT NULL COMMENT 'Username',
  `date` datetime DEFAULT NULL COMMENT 'Date of the event',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Audit Logs' AUTO_INCREMENT=1179 ;

CREATE TABLE `calendar_categories` (
  `catid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `catname` varchar(255) DEFAULT NULL COMMENT 'Category Name',
  `catcolor` varchar(255) DEFAULT NULL COMMENT 'Category Color',
  `catdesc` text COMMENT 'Category Description',
  `duration` bigint(20) NOT NULL DEFAULT '0',
  `cattype` int(11) DEFAULT NULL COMMENT 'Category Type',
  PRIMARY KEY (`catid`),
  KEY `basic_cat` (`catname`,`catcolor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

CREATE TABLE `calendar_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT 'User Id ',
  `category` int(11) DEFAULT NULL COMMENT 'Ty of calendar category',
  `facility` int(11) DEFAULT NULL COMMENT 'faccility id',
  `billing_facillity` int(11) DEFAULT NULL COMMENT 'billing facility id',
  `patient_id` int(11) DEFAULT NULL COMMENT 'patient id (pid)',
  `title` varchar(255) DEFAULT NULL COMMENT 'We are using the patient fullname as the evnet title',
  `status` varchar(255) DEFAULT NULL COMMENT 'event status',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `rrule` varchar(255) DEFAULT NULL COMMENT 'repeatable eventevnet',
  `loc` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

CREATE TABLE `geo_country_reference` (
  `countries_id` int(5) NOT NULL AUTO_INCREMENT,
  `countries_name` varchar(64) DEFAULT NULL,
  `countries_iso_code_2` char(2) NOT NULL DEFAULT '',
  `countries_iso_code_3` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=240 ;

CREATE TABLE `geo_zone_reference` (
  `zone_id` int(5) NOT NULL AUTO_INCREMENT,
  `zone_country_id` int(5) NOT NULL DEFAULT '0',
  `zone_code` varchar(5) DEFAULT NULL,
  `zone_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

CREATE TABLE `globals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gl_name` varchar(255) DEFAULT NULL COMMENT 'Global Setting Unique Name or Key',
  `gl_index` int(11) DEFAULT NULL COMMENT 'Global Setting Index',
  `gl_value` varchar(255) DEFAULT NULL COMMENT 'Global Setting Value',
  `gl_category` varchar(255) DEFAULT NULL COMMENT 'Category',
  PRIMARY KEY (`id`),
  KEY `gl_name` (`gl_name`,`gl_index`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=120 ;

CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` longtext,
  `user` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `facility` varchar(255) NOT NULL,
  `comments` longtext,
  `user_notes` longtext,
  `patient_id` bigint(20) DEFAULT NULL,
  `success` tinyint(1) DEFAULT '1',
  `checksum` longtext,
  `crt_user` varchar(255) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1910 ;

CREATE TABLE `messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` varchar(255) DEFAULT NULL COMMENT 'Date of message',
  `body` text COMMENT 'Message',
  `pid` int(11) DEFAULT NULL COMMENT 'Patient ID',
  `patient_name` varchar(255) DEFAULT NULL,
  `from_user` varchar(255) DEFAULT NULL COMMENT 'Message is from user',
  `to_user` varchar(255) DEFAULT NULL COMMENT 'Message to user',
  `subject` varchar(255) DEFAULT NULL COMMENT 'Subject of the message',
  `facility_id` varchar(255) DEFAULT NULL COMMENT 'Facility',
  `authorized` varchar(255) DEFAULT NULL COMMENT 'Authorized?',
  `to_id` int(11) DEFAULT NULL COMMENT 'To',
  `from_id` int(11) DEFAULT NULL COMMENT 'From',
  `message_status` varchar(255) DEFAULT NULL COMMENT 'Message Status',
  `note_type` varchar(255) DEFAULT NULL COMMENT 'Message Type',
  `to_deleted` tinyint(1) DEFAULT NULL COMMENT 'Deleted to the user',
  `from_deleted` tinyint(1) DEFAULT NULL COMMENT 'Deleted from the source',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Messages' AUTO_INCREMENT=1 ;

CREATE TABLE `modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `enable` tinyint(1) DEFAULT '0',
  `installed_version` varchar(25) DEFAULT NULL,
  `licensekey` varchar(255) DEFAULT NULL,
  `localkey` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=206 ;

CREATE TABLE `modules_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `data` longtext,
  PRIMARY KEY (`id`),
  KEY `data` (`data`(767))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this table if a convivnient table to store module related data' AUTO_INCREMENT=1 ;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL DEFAULT '0',
  `foreign_id` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `revision` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`owner`),
  KEY `foreign_id_2` (`foreign_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `notification_log` (
  `iLogId` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(7) NOT NULL,
  `pc_eid` int(11) unsigned DEFAULT NULL,
  `sms_gateway_type` varchar(50) NOT NULL,
  `smsgateway_info` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `email_sender` varchar(255) NOT NULL,
  `email_subject` varchar(255) NOT NULL,
  `type` enum('SMS','Email') NOT NULL,
  `patient_info` text NOT NULL,
  `pc_eventDate` date NOT NULL,
  `pc_endDate` date NOT NULL,
  `pc_startTime` time NOT NULL,
  `pc_endTime` time NOT NULL,
  `dSentDateTime` datetime NOT NULL,
  PRIMARY KEY (`iLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE `notification_settings` (
  `SettingsId` int(3) NOT NULL AUTO_INCREMENT,
  `Send_SMS_Before_Hours` int(3) NOT NULL,
  `Send_Email_Before_Hours` int(3) NOT NULL,
  `SMS_gateway_username` varchar(100) NOT NULL,
  `SMS_gateway_password` varchar(100) NOT NULL,
  `SMS_gateway_apikey` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`SettingsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

CREATE TABLE `office_notes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `facility_id` varchar(255) DEFAULT NULL,
  `activity` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Office Notes' AUTO_INCREMENT=2 ;

CREATE TABLE `phones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_uid` int(11) DEFAULT NULL COMMENT 'create user ID',
  `write_uid` int(11) DEFAULT NULL COMMENT 'update user ID',
  `create_date` datetime DEFAULT NULL COMMENT 'create date',
  `update_date` datetime DEFAULT NULL COMMENT 'last update date',
  `country_code` varchar(255) DEFAULT NULL,
  `area_code` varchar(5) DEFAULT NULL,
  `prefix` varchar(5) DEFAULT NULL,
  `number` varchar(10) DEFAULT NULL,
  `number_type` varchar(255) DEFAULT NULL,
  `foreign_type` varchar(255) DEFAULT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User/Contacts phones' AUTO_INCREMENT=1 ;

CREATE TABLE `phone_numbers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_code` varchar(5) DEFAULT NULL,
  `area_code` char(3) DEFAULT NULL,
  `prefix` char(3) DEFAULT NULL,
  `number` varchar(4) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `foreign_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

CREATE TABLE `pnotes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `to_id` bigint(20) NOT NULL COMMENT 'user ID receiving the message',
  `from_id` bigint(20) NOT NULL COMMENT 'user ID sending the message',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `body` longtext,
  `pid` bigint(20) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `authorized` tinyint(4) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0' COMMENT 'flag indicates note is deleted',
  `to_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `from_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `message_status` varchar(20) NOT NULL DEFAULT 'New',
  `subject` varchar(254) DEFAULT NULL,
  `note_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE `senchamodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) DEFAULT NULL,
  `modelData` varchar(60000) DEFAULT NULL,
  `modelLastChange` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MEMORY  DEFAULT CHARSET=latin1 AUTO_INCREMENT=48 ;

CREATE TABLE `soap_snippets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parentId` varchar(20) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `text` text,
  `category` varchar(50) DEFAULT NULL,
  `leaf` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  KEY `category` (`category`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_uid` int(11) DEFAULT NULL COMMENT 'create user ID',
  `update_uid` int(11) DEFAULT NULL COMMENT 'update user ID',
  `create_date` datetime DEFAULT NULL COMMENT 'create date',
  `update_date` datetime DEFAULT NULL COMMENT 'last update date',
  `username` varchar(255) DEFAULT NULL COMMENT 'username',
  `password` blob COMMENT 'password',
  `pwd_history1` blob COMMENT 'first password history backwards',
  `pwd_history2` blob COMMENT 'second password history backwards',
  `title` varchar(255) DEFAULT NULL COMMENT 'title (Mr. Mrs.)',
  `fname` varchar(255) DEFAULT NULL COMMENT 'first name',
  `mname` varchar(255) DEFAULT NULL COMMENT 'middle name',
  `lname` varchar(255) DEFAULT NULL COMMENT 'last name',
  `pin` varchar(255) DEFAULT NULL COMMENT 'pin number',
  `npi` varchar(255) DEFAULT NULL COMMENT 'National Provider Identifier',
  `fedtaxid` varchar(255) DEFAULT NULL COMMENT 'federal tax id',
  `feddrugid` varchar(255) DEFAULT NULL COMMENT 'federal drug id',
  `notes` varchar(255) DEFAULT NULL COMMENT 'notes',
  `email` varchar(255) DEFAULT NULL COMMENT 'email',
  `specialty` varchar(255) DEFAULT NULL COMMENT 'specialty',
  `taxonomy` varchar(255) DEFAULT NULL COMMENT 'taxonomy',
  `warehouse_id` int(11) DEFAULT NULL COMMENT 'default warehouse',
  `facility_id` int(11) DEFAULT NULL COMMENT 'default facility',
  `role_id` int(11) DEFAULT NULL COMMENT 'acl_user_roles relation',
  `calendar` tinyint(1) DEFAULT NULL COMMENT 'has calendar? 0=no 1=yes',
  `authorized` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='User accounts' AUTO_INCREMENT=6 ;

CREATE TABLE `users_facility` (
  `tablename` varchar(64) NOT NULL,
  `table_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  PRIMARY KEY (`tablename`,`table_id`,`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='joins users or patient_data to facility table';

CREATE TABLE `users_sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL,
  `uid` bigint(20) NOT NULL,
  `login` int(11) DEFAULT NULL,
  `logout` int(11) DEFAULT NULL,
  `last_request` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

CREATE TABLE `user_settings` (
  `setting_user` bigint(20) NOT NULL DEFAULT '0',
  `setting_label` varchar(63) NOT NULL,
  `setting_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`setting_user`,`setting_label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `v_major` int(11) NOT NULL DEFAULT '0',
  `v_minor` int(11) NOT NULL DEFAULT '0',
  `v_patch` int(11) NOT NULL DEFAULT '0',
  `v_tag` varchar(31) NOT NULL DEFAULT '',
  `v_database` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

