-- FU Event Management
-- Cleaned SQL script based on the original MySQL Workbench export.
-- Original CREATE TABLE definitions, column types, indexes, and foreign keys are preserved.
-- Includes fictional demo data for local development only.
-- WARNING: This script drops and recreates the tables in eventmanagement.

CREATE DATABASE IF NOT EXISTS `eventmanagement`
  DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `eventmanagement`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `visitor_answer`;
DROP TABLE IF EXISTS `visitor`;
DROP TABLE IF EXISTS `ticket`;
DROP TABLE IF EXISTS `survey_question`;
DROP TABLE IF EXISTS `survey_answer`;
DROP TABLE IF EXISTS `survey`;
DROP TABLE IF EXISTS `state_event`;
DROP TABLE IF EXISTS `state`;
DROP TABLE IF EXISTS `sponsor_program_event`;
DROP TABLE IF EXISTS `sponsor_program`;
DROP TABLE IF EXISTS `sponsor_event`;
DROP TABLE IF EXISTS `sponsor`;
DROP TABLE IF EXISTS `role`;
DROP TABLE IF EXISTS `feedback_question`;
DROP TABLE IF EXISTS `feedback`;
DROP TABLE IF EXISTS `event_schedule`;
DROP TABLE IF EXISTS `event_profit`;
DROP TABLE IF EXISTS `event_operator`;
DROP TABLE IF EXISTS `event_image`;
DROP TABLE IF EXISTS `event`;
DROP TABLE IF EXISTS `checking_staff`;
DROP TABLE IF EXISTS `attendance`;
DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `enabled` bit(1) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd4vb66o896tay3yy52oqxr9w0` (`role_id`),
  CONSTRAINT `FKd4vb66o896tay3yy52oqxr9w0` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `attendance` (
  `event_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  `status` enum('ABSENT','ATTENDANCE') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3g7shn8sm0xp0if4xt3m4u733` (`ticket_id`),
  CONSTRAINT `FK3g7shn8sm0xp0if4xt3m4u733` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `checking_staff` (
  `account_id` int NOT NULL,
  `event_id` int DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `FKsfcno8u71n5e27wglfmu4w0j2` (`account_id`),
  KEY `FK4ma6m4ctem4ukjh2ovagoktbn` (`event_id`),
  CONSTRAINT `FK4ma6m4ctem4ukjh2ovagoktbn` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FKsfcno8u71n5e27wglfmu4w0j2` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `event` (
  `account_id` int DEFAULT NULL,
  `fundraising` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `state_event_id` int DEFAULT NULL,
  `timeclosesale` datetime(6) DEFAULT NULL,
  `timeend` datetime(6) DEFAULT NULL,
  `timeopensale` datetime(6) DEFAULT NULL,
  `timestart` datetime(6) DEFAULT NULL,
  `description` text,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqy7vf2v6cfnvo3nxba11fush5` (`account_id`),
  KEY `FK2taytu4ty4oc973j2dxh9oe5c` (`state_event_id`),
  CONSTRAINT `FK2taytu4ty4oc973j2dxh9oe5c` FOREIGN KEY (`state_event_id`) REFERENCES `state_event` (`id`),
  CONSTRAINT `FKqy7vf2v6cfnvo3nxba11fush5` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `event_image` (
  `event_id` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9oirj7cwmu7k91vr0m13hqh8b` (`event_id`),
  CONSTRAINT `FK9oirj7cwmu7k91vr0m13hqh8b` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `event_operator` (
  `account_id` int NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `information` tinytext,
  PRIMARY KEY (`id`),
  KEY `FK53rt5mmep2jpvl39jvlqpybom` (`account_id`),
  CONSTRAINT `FK53rt5mmep2jpvl39jvlqpybom` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `event_profit` (
  `event_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `total_profit` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKer1dcis73tapywpahhfu5u7js` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `event_schedule` (
  `date` date DEFAULT NULL,
  `duration` time(6) DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `timestart` time(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actor` varchar(255) DEFAULT NULL,
  `description` text,
  `event_type` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrnomdfxthbffuwwkj0oxyqd8h` (`event_id`),
  CONSTRAINT `FKrnomdfxthbffuwwkj0oxyqd8h` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedback` (
  `event_id` int DEFAULT NULL,
  `feedbackid` int NOT NULL AUTO_INCREMENT,
  `state_id` int DEFAULT NULL,
  `delete_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feedbackid`),
  KEY `FKjwhm48sj8827gyscux00ftf2n` (`event_id`),
  KEY `FKfoboks2nxbuqpe3t6slc691kj` (`state_id`),
  CONSTRAINT `FKfoboks2nxbuqpe3t6slc691kj` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`),
  CONSTRAINT `FKjwhm48sj8827gyscux00ftf2n` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `feedback_question` (
  `feedback_questionid` int NOT NULL AUTO_INCREMENT,
  `feedbackid` int NOT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `text_question` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`feedback_questionid`),
  KEY `FKnx1pol4aeholkd1dmre2l3kk0` (`feedbackid`),
  CONSTRAINT `FKnx1pol4aeholkd1dmre2l3kk0` FOREIGN KEY (`feedbackid`) REFERENCES `feedback` (`feedbackid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sponsor` (
  `account_id` int NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `companyid` varchar(255) DEFAULT NULL,
  `fpt_staff_email` varchar(255) DEFAULT NULL,
  `information` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2kgbogs36n9hetcq71s6n922x` (`account_id`),
  CONSTRAINT `FK2kgbogs36n9hetcq71s6n922x` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sponsor_event` (
  `contributed_capital` int DEFAULT NULL,
  `event_id` int NOT NULL,
  `profit_percent` double DEFAULT NULL,
  `sponsor_id` bigint NOT NULL,
  PRIMARY KEY (`event_id`,`sponsor_id`),
  KEY `FKfwcki964idg6vil713yu7vhaj` (`sponsor_id`),
  CONSTRAINT `FKcvjr8dx4ukkmttkf34ta0u9j5` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FKfwcki964idg6vil713yu7vhaj` FOREIGN KEY (`sponsor_id`) REFERENCES `sponsor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sponsor_program` (
  `account_id` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `link` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `state` enum('PUBLISH','UNPUBLISH') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7o9c1s7cnxkpq0dq795973qlu` (`account_id`),
  CONSTRAINT `FK7o9c1s7cnxkpq0dq795973qlu` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sponsor_program_event` (
  `event_id` int NOT NULL,
  `sponsor_program_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`sponsor_program_id`),
  KEY `FK5cnjc06o00wlr9cuevyvcde39` (`sponsor_program_id`),
  CONSTRAINT `FK4u86n3gtlrf1qq23klahqq9an` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FK5cnjc06o00wlr9cuevyvcde39` FOREIGN KEY (`sponsor_program_id`) REFERENCES `sponsor_program` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `state` (
  `state_id` int NOT NULL AUTO_INCREMENT,
  `state_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `state_event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey` (
  `event_id` int DEFAULT NULL,
  `delete_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `survey_id` bigint NOT NULL AUTO_INCREMENT,
  `target` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`survey_id`),
  KEY `FKgnoo3kyt0tonj3ykxdt3yb4ge` (`event_id`),
  CONSTRAINT `FKgnoo3kyt0tonj3ykxdt3yb4ge` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey_answer` (
  `answer_id` bigint NOT NULL AUTO_INCREMENT,
  `delete_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `question_id` bigint DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FKsmngcm3g1yf412nsre7h8j32e` (`question_id`),
  CONSTRAINT `FKsmngcm3g1yf412nsre7h8j32e` FOREIGN KEY (`question_id`) REFERENCES `survey_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey_question` (
  `delete_at` datetime(6) DEFAULT NULL,
  `modified_at` datetime(6) DEFAULT NULL,
  `question_id` bigint NOT NULL AUTO_INCREMENT,
  `survey_id` bigint DEFAULT NULL,
  `type_question` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FK573vicrl6b0e4d2jdg3wpvuhy` (`survey_id`),
  CONSTRAINT `FK573vicrl6b0e4d2jdg3wpvuhy` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ticket` (
  `event_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `status_cart` bit(1) NOT NULL,
  `visitor_id` int NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `expired_date` datetime(6) DEFAULT NULL,
  `status` enum('CANCELLED','PAID','PENDING') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfytuhjopeamxbt1cpudy92x5n` (`event_id`),
  KEY `FK37ftit4hrpnv9hb1mvl6pir6l` (`visitor_id`),
  CONSTRAINT `FK37ftit4hrpnv9hb1mvl6pir6l` FOREIGN KEY (`visitor_id`) REFERENCES `visitor` (`id`),
  CONSTRAINT `FKfytuhjopeamxbt1cpudy92x5n` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visitor` (
  `account_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `information` tinytext,
  PRIMARY KEY (`id`),
  KEY `FKm0stpn1mjj3knpcfvv1odnjv5` (`account_id`),
  CONSTRAINT `FKm0stpn1mjj3knpcfvv1odnjv5` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `visitor_answer` (
  `feedback_question_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `visitor_id` int NOT NULL,
  `visitor_answer_feedback` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcaxdb1pwj0fo3kq0xw8n8a0e` (`feedback_question_id`),
  KEY `FKiujnnom2rmesxvsl1tcc278o3` (`visitor_id`),
  CONSTRAINT `FKcaxdb1pwj0fo3kq0xw8n8a0e` FOREIGN KEY (`feedback_question_id`) REFERENCES `feedback_question` (`feedback_questionid`),
  CONSTRAINT `FKiujnnom2rmesxvsl1tcc278o3` FOREIGN KEY (`visitor_id`) REFERENCES `visitor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- Synthetic demo data: all records are fictional.
-- Password values are placeholders and are not usable credentials.
INSERT INTO role (id, role_name) VALUES
  (1, 'ADMIN'), (2, 'EVENT_OPERATOR'), (3, 'VISITOR'), (4, 'CHECKING_STAFF'), (5, 'SPONSOR');

INSERT INTO state (state_id, state_name) VALUES
  (1, 'ACTIVE'), (2, 'INACTIVE');

INSERT INTO state_event (id, name) VALUES
  (1, 'UPCOMING'), (2, 'ONGOING'), (3, 'COMPLETED');

INSERT INTO account (id, enabled, role_id, email, password, reset_token) VALUES
  (1, b'1', 1, 'admin.demo@example.com', '{demo-password-hash}', NULL),
  (2, b'1', 2, 'organizer.demo@example.com', '{demo-password-hash}', NULL),
  (3, b'1', 3, 'visitor.one@example.com', '{demo-password-hash}', NULL),
  (4, b'1', 3, 'visitor.two@example.com', '{demo-password-hash}', NULL),
  (5, b'1', 4, 'staff.demo@example.com', '{demo-password-hash}', NULL),
  (6, b'1', 5, 'sponsor.demo@example.com', '{demo-password-hash}', NULL);

INSERT INTO event (id, account_id, fundraising, price, state_event_id, timeclosesale, timeend, timeopensale, timestart, description, name) VALUES
  (1, 2, 1, 50000, 1, '2027-03-20 23:59:00', '2027-03-25 17:00:00', '2027-02-01 08:00:00', '2027-03-25 08:00:00', 'A fictional technology sharing event.', 'Tech Sharing Day'),
  (2, 2, 0, 0, 2, '2027-04-10 23:59:00', '2027-04-12 16:00:00', '2027-03-01 08:00:00', '2027-04-12 08:30:00', 'A fictional student community event.', 'Student Community Meetup');

INSERT INTO visitor (id, account_id, information) VALUES
  (1, 3, 'Demo visitor profile 1'), (2, 4, 'Demo visitor profile 2');

INSERT INTO event_operator (id, account_id, information) VALUES
  (1, 2, 'Demo event organizer');

INSERT INTO checking_staff (id, account_id, event_id) VALUES
  (1, 5, 1);

INSERT INTO sponsor (id, account_id, company_name, companyid, fpt_staff_email, information) VALUES
  (1, 6, 'Example Tech Co.', 'DEMO-SP-001', 'contact@example.com', 'Fictional sponsor profile');

INSERT INTO event_image (id, event_id, url) VALUES
  (1, 1, 'https://example.com/images/tech-sharing-day.jpg'),
  (2, 2, 'https://example.com/images/community-meetup.jpg');

INSERT INTO event_profit (id, event_id, total_profit) VALUES
  (1, 1, 1250000), (2, 2, 0);

INSERT INTO event_schedule (id, `date`, duration, event_id, timestart, actor, description, event_type, location, name) VALUES
  (1, '2027-03-25', '01:00:00', 1, '08:30:00', 'Guest speaker', 'Opening talk', 'TALK', 'Hall A', 'Welcome and keynote'),
  (2, '2027-03-25', '02:00:00', 1, '10:00:00', 'Student teams', 'Project showcase', 'WORKSHOP', 'Hall B', 'Project showcase');

INSERT INTO feedback (feedbackid, event_id, state_id, delete_at, modified_at, title) VALUES
  (1, 1, 1, NULL, NULL, 'Tech Sharing Day feedback');

INSERT INTO feedback_question (feedback_questionid, feedbackid, deleted_at, modified_at, text_question) VALUES
  (1, 1, NULL, NULL, 'How would you rate the event?'),
  (2, 1, NULL, NULL, 'What could be improved?');

INSERT INTO ticket (id, event_id, status_cart, visitor_id, created_date, expired_date, status) VALUES
  (1, 1, b'0', 1, '2027-03-01 09:00:00', '2027-03-24 23:59:00', 'PAID'),
  (2, 1, b'1', 2, '2027-03-02 10:00:00', '2027-03-24 23:59:00', 'PENDING'),
  (3, 2, b'0', 1, '2027-03-10 11:00:00', '2027-04-11 23:59:00', 'PAID');

INSERT INTO attendance (id, event_id, ticket_id, status) VALUES
  (1, 1, 1, 'ATTENDANCE'), (2, 1, 2, 'ABSENT'), (3, 2, 3, 'ABSENT');

INSERT INTO sponsor_event (event_id, sponsor_id, contributed_capital, profit_percent) VALUES
  (1, 1, 5000000, 10.0);

INSERT INTO sponsor_program (id, account_id, description, link, location, thumbnail, title, state) VALUES
  (1, 6, 'Fictional product showcase program.', 'https://example.com/sponsor-program', 'Hall A', 'https://example.com/images/sponsor.jpg', 'Demo Product Showcase', 'PUBLISH');

INSERT INTO sponsor_program_event (event_id, sponsor_program_id) VALUES
  (1, 1);

INSERT INTO survey (survey_id, event_id, delete_at, modified_at, target, title) VALUES
  (1, 1, NULL, NULL, 'ATTENDEE', 'Post-event survey');

INSERT INTO survey_question (question_id, delete_at, modified_at, survey_id, type_question) VALUES
  (1, NULL, NULL, 1, 'TEXT'), (2, NULL, NULL, 1, 'RATING');

INSERT INTO survey_answer (answer_id, delete_at, modified_at, question_id, answer) VALUES
  (1, NULL, NULL, 1, 'The sessions were useful.'),
  (2, NULL, NULL, 2, '5');

INSERT INTO visitor_answer (id, feedback_question_id, visitor_id, visitor_answer_feedback) VALUES
  (1, 1, 1, '5 out of 5'),
  (2, 2, 1, 'More time for networking would be helpful.');

-- End of script.
