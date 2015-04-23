/*\
 *
 * Jim Blaney
 * Peter Sigur
 *
 * CS329 Spring 2015

 * Database Project
 * Assignment 3 -- Implement database schema in MySQL (MariaDB)
 *
\*/

-- delete existing database objects
DROP TABLE IF EXISTS trip;
DROP TABLE IF EXISTS rider;
DROP TABLE IF EXISTS line_stop;
DROP TABLE IF EXISTS line;
DROP TABLE IF EXISTS stop;
DROP TABLE IF EXISTS involved_in;
DROP TABLE IF EXISTS safety_incident;
DROP TABLE IF EXISTS operates;
DROP TABLE IF EXISTS vehicle;
DROP TABLE IF EXISTS vehicle_type;
DROP TABLE IF EXISTS driver;

-- create tables with constraints
CREATE TABLE driver (
   id         INTEGER       NOT NULL  AUTO_INCREMENT
  ,name       VARCHAR(255)  NOT NULL
  ,hire_date  DATE          NOT NULL
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE vehicle_type (
   id           INTEGER       NOT NULL  AUTO_INCREMENT
  ,description  VARCHAR(255)  NOT NULL
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE vehicle (
   id        INTEGER  NOT NULL  AUTO_INCREMENT
  ,capacity  INTEGER  NOT NULL
  ,type      INTEGER  NOT NULL
  ,CONSTRAINT PRIMARY KEY (id)
  ,CONSTRAINT FOREIGN KEY (type) REFERENCES vehicle_type (id)
);

CREATE TABLE operates (
   vehicle_id  INTEGER  NOT NULL
  ,driver_id   INTEGER  NOT NULL
  ,date        DATE     NOT NULL
  ,CONSTRAINT PRIMARY KEY (vehicle_id, driver_id, date)
  ,CONSTRAINT FOREIGN KEY (vehicle_id) REFERENCES vehicle (id)
  ,CONSTRAINT FOREIGN KEY (driver_id) REFERENCES driver (id)
  ,CONSTRAINT UNIQUE KEY (vehicle_id, date)
  ,CONSTRAINT UNIQUE KEY (driver_id, date)
);

CREATE TABLE safety_incident (
   id         INTEGER      NOT NULL  AUTO_INCREMENT
  ,datetime   DATETIME     NOT NULL
  ,latitude   DOUBLE(8,6)
  ,longitude  DOUBLE(9,6)
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE involved_in (
   vehicle_id   INTEGER  NOT NULL
  ,incident_id  INTEGER  NOT NULL
  ,at_fault     BOOLEAN  NOT NULL
  ,CONSTRAINT PRIMARY KEY (vehicle_id, incident_id)
  ,CONSTRAINT FOREIGN KEY (vehicle_id) REFERENCES vehicle (id)
  ,CONSTRAINT FOREIGN KEY (incident_id) REFERENCES safety_incident (id)
);

CREATE TABLE stop (
   id            INTEGER       NOT NULL  AUTO_INCREMENT
  ,name          VARCHAR(255)  NOT NULL
  ,vehicle_type  INTEGER       NOT NULL
  ,latitude      DOUBLE(8,6)
  ,longitude     DOUBLE(9,6)
  ,CONSTRAINT PRIMARY KEY (id)
  ,CONSTRAINT FOREIGN KEY (vehicle_type) REFERENCES vehicle_type (id)
);

CREATE TABLE line (
   id    INTEGER       NOT NULL  AUTO_INCREMENT
  ,name  VARCHAR(255)  NOT NULL
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE line_stop (
   line_id     INTEGER  NOT NULL
  ,stop_id     INTEGER  NOT NULL
  ,line_order  INTEGER  NOT NULL
  ,CONSTRAINT PRIMARY KEY (line_id, stop_id)
  ,CONSTRAINT FOREIGN KEY (line_id) REFERENCES line (id)
  ,CONSTRAINT FOREIGN KEY (stop_id) REFERENCES stop (id)
  ,CONSTRAINT UNIQUE KEY (line_id, stop_id, line_order)
);

CREATE TABLE rider (
   id    INTEGER       NOT NULL  AUTO_INCREMENT
  ,name  VARCHAR(255)
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE trip (
   id              INTEGER        NOT NULL  AUTO_INCREMENT
  ,rider_id        INTEGER        NOT NULL
  ,entry_datetime  DATETIME       NOT NULL
  ,exit_datetime   DATETIME
  ,entry_stop      INTEGER        NOT NULL
  ,exit_stop       INTEGER
  ,cost            NUMERIC(15,2)
  ,CONSTRAINT PRIMARY KEY (id)
  ,CONSTRAINT FOREIGN KEY (rider_id) REFERENCES rider (id)
  ,CONSTRAINT FOREIGN KEY (entry_stop) REFERENCES stop (id)
  ,CONSTRAINT FOREIGN KEY (exit_stop) REFERENCES stop (id)
);

-- load data
INSERT INTO driver (name, hire_date) VALUES ('Majed Alshehri', '2011-07-31');
INSERT INTO driver (name, hire_date) VALUES ('Kaitlyn Ball', '2002-02-03');
INSERT INTO driver (name, hire_date) VALUES ('Kevin Barrett', '2010-10-25');
INSERT INTO driver (name, hire_date) VALUES ('James Blaney', '2010-12-26');
INSERT INTO driver (name, hire_date) VALUES ('Aijuan Dong', '2005-08-19');
INSERT INTO driver (name, hire_date) VALUES ('Shane Edmiston', '2011-10-20');
INSERT INTO driver (name, hire_date) VALUES ('Joshua Greer', '2010-07-17');
INSERT INTO driver (name, hire_date) VALUES ('Rachel Hall', '2007-02-28');
INSERT INTO driver (name, hire_date) VALUES ('Joshua Hidayat', '2007-02-25');
INSERT INTO driver (name, hire_date) VALUES ('Davon Hill', '2001-07-14');
INSERT INTO driver (name, hire_date) VALUES ('Devin Hill', '2013-11-26');
INSERT INTO driver (name, hire_date) VALUES ('Robert Hill', '2001-08-11');
INSERT INTO driver (name, hire_date) VALUES ('Geoffrey Huntoon', '2012-09-25');
INSERT INTO driver (name, hire_date) VALUES ('Gary Lopez Munoz', '2003-03-10');
INSERT INTO driver (name, hire_date) VALUES ('James McLemore', '2001-06-11');
INSERT INTO driver (name, hire_date) VALUES ('Erik Phillips', '2001-02-14');
INSERT INTO driver (name, hire_date) VALUES ('John Pigott', '2011-12-24');
INSERT INTO driver (name, hire_date) VALUES ('Antonio Punzo', '2004-12-13');
INSERT INTO driver (name, hire_date) VALUES ('Owen Rosier', '2002-06-04');
INSERT INTO driver (name, hire_date) VALUES ('Tyler Shuck', '2001-06-03');
INSERT INTO driver (name, hire_date) VALUES ('Peter Sigur', '2011-02-19');
INSERT INTO driver (name, hire_date) VALUES ('Rachel Staley', '2007-01-17');
INSERT INTO driver (name, hire_date) VALUES ('Samuel Walters-Nevet', '2005-07-16');
INSERT INTO driver (name, hire_date) VALUES ('Mark White', '2005-02-12');

INSERT INTO vehicle_type (description) VALUES ('Train');
INSERT INTO vehicle_type (description) VALUES ('Bus');

INSERT INTO vehicle (capacity, type) VALUES (49, 2);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (36, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (38, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 2);
INSERT INTO vehicle (capacity, type) VALUES (46, 2);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 2);
INSERT INTO vehicle (capacity, type) VALUES (35, 2);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 2);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 2);
INSERT INTO vehicle (capacity, type) VALUES (44, 2);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 2);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (40, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (38, 2);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (39, 2);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 2);
INSERT INTO vehicle (capacity, type) VALUES (47, 2);
INSERT INTO vehicle (capacity, type) VALUES (43, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (40, 2);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (43, 2);
INSERT INTO vehicle (capacity, type) VALUES (43, 2);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 2);
INSERT INTO vehicle (capacity, type) VALUES (42, 2);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (42, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (46, 2);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 2);
INSERT INTO vehicle (capacity, type) VALUES (49, 2);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (50, 2);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 2);
INSERT INTO vehicle (capacity, type) VALUES (45, 2);
INSERT INTO vehicle (capacity, type) VALUES (37, 2);
INSERT INTO vehicle (capacity, type) VALUES (38, 2);
INSERT INTO vehicle (capacity, type) VALUES (46, 2);
INSERT INTO vehicle (capacity, type) VALUES (40, 2);
INSERT INTO vehicle (capacity, type) VALUES (42, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 2);
INSERT INTO vehicle (capacity, type) VALUES (48, 2);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 2);

INSERT INTO operates (vehicle_id, driver_id, date) VALUES (95, 1, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (3, 2, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (99, 3, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (3, 4, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (37, 5, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (49, 6, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (65, 7, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (56, 8, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (65, 9, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (4, 10, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (56, 11, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (94, 12, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (26, 13, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (6, 14, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (56, 15, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (93, 16, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (52, 17, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (56, 18, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (95, 19, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (69, 20, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (4, 21, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (5, 22, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (95, 23, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (88, 24, '2015-04-01');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (47, 4, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (45, 5, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (88, 6, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (50, 7, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (55, 8, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (99, 9, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (41, 10, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (58, 11, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (97, 12, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (47, 13, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (70, 14, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (37, 15, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (7, 16, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (71, 17, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (2, 18, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (91, 19, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (33, 20, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (45, 21, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (15, 22, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (99, 23, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (36, 24, '2015-04-02');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (65, 4, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (77, 5, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (32, 6, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (51, 7, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (61, 8, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (77, 9, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (3, 10, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (44, 11, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (53, 12, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (97, 13, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (26, 14, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (70, 15, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (12, 16, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (49, 17, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (22, 18, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (94, 19, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (45, 20, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (75, 21, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (33, 22, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (48, 23, '2015-04-03');
INSERT INTO operates (vehicle_id, driver_id, date) VALUES (1, 24, '2015-04-03');

safety_incident;
involved_in;
stop;
line;
line_stop;
rider;
trip;
