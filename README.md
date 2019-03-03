# README

## Basic Seed of Database

```
CREATE TABLE feedings (id SERIAL, start_time TIMESTAMPTZ, end_time TIMESTAMPTZ, side CHAR(1));
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 00:32:00', '2019-03-01 01:01:00','L');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 02:22:00', '2019-03-01 03:01:00','R');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 04:40:00', '2019-03-01 05:05:00','L');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 06:31:00', '2019-03-01 07:00:00','R');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 08:21:00', '2019-03-01 08:41:00','L');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 10:14:00', '2019-03-01 10:51:00','R');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 12:12:00', '2019-03-01 12:41:00','L');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 14:15:00', '2019-03-01 14:33:00','R');
INSERT INTO feedings (start_time, end_time, side) VALUES ('2019-03-01 16:28:00', '2019-03-01 16:50:00','L');
SELECT * FROM feedings;

CREATE TABLE foods (id SERIAL, time TIMESTAMPTZ, food VARCHAR(16));
INSERT INTO foods (time, food) VALUES ('2019-02-28 22:00:00', 'banana');
INSERT INTO foods (time, food) VALUES ('2019-02-28 22:00:00', 'chocolate muffin');
INSERT INTO foods (time, food) VALUES ('2019-03-01 04:30:00', 'beef jerky');
INSERT INTO foods (time, food) VALUES ('2019-03-01 05:00:00', 'apple');
INSERT INTO foods (time, food) VALUES ('2019-03-01 06:30:00', 'yogurt');
INSERT INTO foods (time, food) VALUES ('2019-03-01 07:45:00', 'peanut butter sandwich');
INSERT INTO foods (time, food) VALUES ('2019-03-01 09:00:00', 'eggs');
INSERT INTO foods (time, food) VALUES ('2019-03-01 10:35:00', 'carrots');
INSERT INTO foods (time, food) VALUES ('2019-03-01 12:10:00', 'broccoli');
INSERT INTO foods (time, food) VALUES ('2019-03-01 12:10:00', 'rice');
INSERT INTO foods (time, food) VALUES ('2019-03-01 12:10:00', 'chicken');
SELECT * FROM foods;
