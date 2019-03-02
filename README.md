# README

## Basic Seed of Database

```CREATE TABLE feedings (id SERIAL, begin_time TIMESTAMP, end_time TIMESTAMP, side CHAR(1));
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 00:32:00', '2019-03-01 01:01:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 02:22:00', '2019-03-01 03:01:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 04:40:00', '2019-03-01 04:05:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 06:31:00', '2019-03-01 07:00:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 08:21:00', '2019-03-01 08:41:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 10:14:00', '2019-03-01 10:51:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 12:12:00', '2019-03-01 12:41:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 14:15:00', '2019-03-01 14:33:00','L');
INSERT INTO feedings (begin_time, end_time, side) VALUES ('2019-03-01 16:28:00', '2019-03-01 16:50:00','L');
SELECT * FROM feedings;
