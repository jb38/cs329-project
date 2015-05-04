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

-- delete existing tables
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

-- create tables and constraints
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
  ,latitude      DOUBLE(8,6)
  ,longitude     DOUBLE(9,6)
  ,CONSTRAINT PRIMARY KEY (id)
);

CREATE TABLE line (
   id            INTEGER       NOT NULL  AUTO_INCREMENT
  ,name          VARCHAR(255)  NOT NULL
  ,vehicle_type  INTEGER       NOT NULL
  ,CONSTRAINT PRIMARY KEY (id)
  ,CONSTRAINT FOREIGN KEY (vehicle_type) REFERENCES vehicle_type (id)
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

INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (38, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 1);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (36, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (38, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (42, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (42, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (43, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (47, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);
INSERT INTO vehicle (capacity, type) VALUES (37, 1);
INSERT INTO vehicle (capacity, type) VALUES (38, 1);
INSERT INTO vehicle (capacity, type) VALUES (46, 1);
INSERT INTO vehicle (capacity, type) VALUES (40, 1);
INSERT INTO vehicle (capacity, type) VALUES (42, 1);
INSERT INTO vehicle (capacity, type) VALUES (49, 1);
INSERT INTO vehicle (capacity, type) VALUES (35, 1);
INSERT INTO vehicle (capacity, type) VALUES (41, 1);
INSERT INTO vehicle (capacity, type) VALUES (50, 1);
INSERT INTO vehicle (capacity, type) VALUES (39, 1);
INSERT INTO vehicle (capacity, type) VALUES (48, 1);
INSERT INTO vehicle (capacity, type) VALUES (44, 1);
INSERT INTO vehicle (capacity, type) VALUES (45, 1);

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

INSERT INTO safety_incident (datetime, latitude, longitude) VALUES ('2015-04-01', 38.9843936603, -77.0941291922);
INSERT INTO safety_incident (datetime, latitude, longitude) VALUES ('2015-04-02', 38.9843936603, -77.0941291922);
INSERT INTO safety_incident (datetime, latitude, longitude) VALUES ('2015-04-03', 38.9843936603, -77.0941291922);

insert into involved_in (vehicle_id, incident_id, at_fault) values (37, 1, TRUE);
insert into involved_in (vehicle_id, incident_id, at_fault) values (45, 2, TRUE);
insert into involved_in (vehicle_id, incident_id, at_fault) values (77, 3, TRUE);

insert into stop (name, latitude, longitude) values ('Addison Road', 38.8867478168, -76.89410791);
insert into stop (name, latitude, longitude) values ('Anacostia', 38.8629631168, -76.9953707387);
insert into stop (name, latitude, longitude) values ('Archives', 38.8936652235, -77.0219143879);
insert into stop (name, latitude, longitude) values ('Arlington Cemetery', 38.8846868585, -77.0628101291);
insert into stop (name, latitude, longitude) values ('Ballston', 38.8821828738, -77.113168835);
insert into stop (name, latitude, longitude) values ('Benning Road', 38.890975676, -76.9383648681);
insert into stop (name, latitude, longitude) values ('Bethesda', 38.9843936603, -77.0941291922);
insert into stop (name, latitude, longitude) values ('Braddock Road', 38.8141436672, -77.053667574);
insert into stop (name, latitude, longitude) values ('Branch Avenue', 38.8264463483, -76.9114642177);
insert into stop (name, latitude, longitude) values ('Brookland', 38.9332109913, -76.9945342851);
insert into stop (name, latitude, longitude) values ('Capitol Heights', 38.8894658568, -76.9118081145);
insert into stop (name, latitude, longitude) values ('Capitol South', 38.8850625009, -77.0051394199);
insert into stop (name, latitude, longitude) values ('Cheverly', 38.9166318546, -76.916628044);
insert into stop (name, latitude, longitude) values ('Clarendon', 38.886704839, -77.0953940983);
insert into stop (name, latitude, longitude) values ('Cleveland Park', 38.9347628908, -77.0580425191);
insert into stop (name, latitude, longitude) values ('College Park', 38.9786336339, -76.9281249818);
insert into stop (name, latitude, longitude) values ('Columbia Heights', 38.9278379675, -77.0325521177);
insert into stop (name, latitude, longitude) values ('Congress Height', 38.8456577028, -76.9885119326);
insert into stop (name, latitude, longitude) values ('Court House', 38.8901755312, -77.087131231);
insert into stop (name, latitude, longitude) values ('Crystal City', 38.8579043204, -77.0502898097);
insert into stop (name, latitude, longitude) values ('Deanwood', 38.9081784965, -76.935256783);
insert into stop (name, latitude, longitude) values ('Dunn Loring', 38.8836251359, -77.2271606721);
insert into stop (name, latitude, longitude) values ('Dupont Circle', 38.9095980575, -77.0434143597);
insert into stop (name, latitude, longitude) values ('E Falls Church', 38.8859531663, -77.1568830199);
insert into stop (name, latitude, longitude) values ('Eastern Market', 38.8846222608, -76.9960011267);
insert into stop (name, latitude, longitude) values ('Eisenhower Avenue', 38.8004254497, -77.0708743893);
insert into stop (name, latitude, longitude) values ('Farragut North', 38.9032019462, -77.0397008272);
insert into stop (name, latitude, longitude) values ('Farragut West', 38.9013128941, -77.0406954151);
insert into stop (name, latitude, longitude) values ('Federal Center SW', 38.8850723551, -77.0158682169);
insert into stop (name, latitude, longitude) values ('Federal Triangle', 38.8931808718, -77.0281319984);
insert into stop (name, latitude, longitude) values ('Foggy Bottom', 38.9006980092, -77.050277739);
insert into stop (name, latitude, longitude) values ('Forest Glen', 39.0149542752, -77.0429165548);
insert into stop (name, latitude, longitude) values ('Fort Totten', 38.9518467675, -77.0022030768);
insert into stop (name, latitude, longitude) values ('Franconia-Springfield', 38.7665218926, -77.1679701804);
insert into stop (name, latitude, longitude) values ('Friendship Heights', 38.9594838736, -77.084995805);
insert into stop (name, latitude, longitude) values ('Gallery Place', 38.8983168097, -77.0219153904);
insert into stop (name, latitude, longitude) values ('Georgia Avenue', 38.9374346301, -77.023460904);
insert into stop (name, latitude, longitude) values ('Glenmont', 39.0617837655, -77.0535573593);
insert into stop (name, latitude, longitude) values ('Greenbelt', 39.0111458605, -76.9110575731);
insert into stop (name, latitude, longitude) values ('Greensboro', 38.921732, -77.234607);
insert into stop (name, latitude, longitude) values ('Grosvenor', 39.02926895, -77.10384972);
insert into stop (name, latitude, longitude) values ('Huntington', 38.7939158529, -77.0752057891);
insert into stop (name, latitude, longitude) values ('Judiciary Square', 38.8960903176, -77.0166389566);
insert into stop (name, latitude, longitude) values ('King Street', 38.8065861172, -77.0608112085);
insert into stop (name, latitude, longitude) values ('L''Enfant Plaza', 38.8848377279, -77.021908484);
insert into stop (name, latitude, longitude) values ('Landover', 38.9335062344, -76.8911979676);
insert into stop (name, latitude, longitude) values ('Largo Town Center', 38.9050688072, -76.8420375202);
insert into stop (name, latitude, longitude) values ('McLean', 38.924432, -77.210295);
insert into stop (name, latitude, longitude) values ('McPherson Square', 38.9013327968, -77.0336341721);
insert into stop (name, latitude, longitude) values ('Medical Center', 39.0000564843, -77.0969522905);
insert into stop (name, latitude, longitude) values ('Metro Center', 38.8983144732, -77.0280779971);
insert into stop (name, latitude, longitude) values ('Minnesota Avenue', 38.899191223, -76.9467477336);
insert into stop (name, latitude, longitude) values ('Morgan Blvd', 38.8938349282, -76.8680747681);
insert into stop (name, latitude, longitude) values ('Mt Vernon Sq', 38.9064368149, -77.0219143803);
insert into stop (name, latitude, longitude) values ('National Arpt', 38.8534163859, -77.0440422943);
insert into stop (name, latitude, longitude) values ('Navy Yard', 38.8764810849, -77.0050856513);
insert into stop (name, latitude, longitude) values ('Naylor Road', 38.8513013835, -76.9562627094);
insert into stop (name, latitude, longitude) values ('New Carrollton', 38.9477848558, -76.8718412865);
insert into stop (name, latitude, longitude) values ('New York Avenue', 38.9070162121, -77.0030204472);
insert into stop (name, latitude, longitude) values ('Pentagon City', 38.8618823867, -77.0595389215);
insert into stop (name, latitude, longitude) values ('Pentagon', 38.8694627012, -77.0537156734);
insert into stop (name, latitude, longitude) values ('Potomac Avenue', 38.8812632736, -76.9854953196);
insert into stop (name, latitude, longitude) values ('Prince Georges Plaza', 38.9653854458, -76.9558815078);
insert into stop (name, latitude, longitude) values ('Rhode Island Avenue', 38.9210596891, -76.9959369166);
insert into stop (name, latitude, longitude) values ('Rockville', 39.0843216075, -77.1461253392);
insert into stop (name, latitude, longitude) values ('Rosslyn', 38.8959790962, -77.0709086853);
insert into stop (name, latitude, longitude) values ('Shady Grove', 39.1199273249, -77.1646273343);
insert into stop (name, latitude, longitude) values ('Shaw', 38.9134768711, -77.0219117007);
insert into stop (name, latitude, longitude) values ('Silver Spring', 38.9939493747, -77.0310178268);
insert into stop (name, latitude, longitude) values ('Smithsonian', 38.888018702, -77.0280662342);
insert into stop (name, latitude, longitude) values ('Southern Ave', 38.8410857803, -76.9750541388);
insert into stop (name, latitude, longitude) values ('Spring Hill', 38.928872, -77.241472);
insert into stop (name, latitude, longitude) values ('Stadium Armory', 38.8867090898, -76.9770889014);
insert into stop (name, latitude, longitude) values ('Suitland', 38.8439645544, -76.9318701589);
insert into stop (name, latitude, longitude) values ('Takoma', 38.976078531, -77.0181766987);
insert into stop (name, latitude, longitude) values ('Tenleytown', 38.9488514351, -77.0795873255);
insert into stop (name, latitude, longitude) values ('Twinbrook', 39.0624676517, -77.1208179517);
insert into stop (name, latitude, longitude) values ('Tysons Corner', 38.920496, -77.222262);
insert into stop (name, latitude, longitude) values ('U Street', 38.9170023992, -77.0274958929);
insert into stop (name, latitude, longitude) values ('Union Station', 38.8977660392, -77.0074142921);
insert into stop (name, latitude, longitude) values ('Van Dorn St', 38.799307672, -77.1291115237);
insert into stop (name, latitude, longitude) values ('Van Ness UDC', 38.9432652883, -77.0629861805);
insert into stop (name, latitude, longitude) values ('Vienna', 38.8776011238, -77.2726222569);
insert into stop (name, latitude, longitude) values ('Virginia Square', 38.8833661518, -77.1029772942);
insert into stop (name, latitude, longitude) values ('W Falls Church', 38.900780551, -77.1890948225);
insert into stop (name, latitude, longitude) values ('Waterfront', 38.8764618668, -77.0175052088);
insert into stop (name, latitude, longitude) values ('West Hyattsville', 38.9550401707, -76.9695766751);
insert into stop (name, latitude, longitude) values ('Wheaton', 39.0375271436, -77.0501070535);
insert into stop (name, latitude, longitude) values ('White Flint', 39.0481513573, -77.112829859);
insert into stop (name, latitude, longitude) values ('Wiehle-Reston East', 38.94778, -77.34027);
insert into stop (name, latitude, longitude) values ('Woodley Park Zoo', 38.9250851371, -77.0524180207);

-- TODO bus stops in stop

insert into line (name, vehicle_type) values ('RED', 1);
insert into line (name, vehicle_type) values ('ORANGE', 1);
insert into line (name, vehicle_type) values ('YELLOW', 1);
insert into line (name, vehicle_type) values ('GREEN', 1);
insert into line (name, vehicle_type) values ('BLUE', 1);

insert into line (name) values ('10A HUNTING POINT-PENT');
insert into line (name) values ('10B HUNT POINT-BALL');
insert into line (name) values ('10E HUNTING POINT-PENT');
insert into line (name) values ('10R HUNTING POINT-PENT');
insert into line (name) values ('10S HUNTING POINT-PENT');
insert into line (name) values ('11Y MT VERNON EXPRESS');
insert into line (name) values ('13Y ARLINGTON-UNION STA');
insert into line (name) values ('15K CHAIN BRIDGE RD');
insert into line (name) values ('15L CHAIN BRIDGE RD');
insert into line (name) values ('15M GEO. MASON UNIV-TYSONS CR');
insert into line (name) values ('16A COLUMBIA PIKE');
insert into line (name) values ('16B COLUMBIA PIKE');
insert into line (name) values ('16E COLUMBIA PIKE');
insert into line (name) values ('16G COL HTS W-PENT CITY');
insert into line (name) values ('16H COL HTS W-PENT CITY');
insert into line (name) values ('16J COLUMBIA PIKE');
insert into line (name) values ('16K COL HTS W-PENT CITY');
insert into line (name) values ('16L ANN-SKY CITY-PENT');
insert into line (name) values ('16P COLUMBIA PIKE');
insert into line (name) values ('16X COL PK - FED. TRIANGLE');
insert into line (name) values ('16Y COL PK-FARR SQ');
insert into line (name) values ('17A KINGS PARK');
insert into line (name) values ('17B KINGS PARK');
insert into line (name) values ('17F KINGS PARK');
insert into line (name) values ('17G KINGS PK EXPRESS');
insert into line (name) values ('17H KINGS PK EXPRESS');
insert into line (name) values ('17K KINGS PK EXPRESS');
insert into line (name) values ('17L KINGS PK EXPRESS');
insert into line (name) values ('17M KINGS PARK');
insert into line (name) values ('18E SPRINGFIELD');
insert into line (name) values ('18F SPRINGFIELD');
insert into line (name) values ('18G ORANGE HUNT');
insert into line (name) values ('18H ORANGE HUNT');
insert into line (name) values ('18J ORANGE HUNT');
insert into line (name) values ('18P BURKE CENTRE');
insert into line (name) values ('18R BURKE CENTRE');
insert into line (name) values ('18S BURKE CENTRE');
insert into line (name) values ('1A WILSON BLVD - VIENNA');
insert into line (name) values ('1B WILSON BLVD - VIENNA');
insert into line (name) values ('1C FAIR OAKS-FAIRFAX BLVD');
insert into line (name) values ('1E WILSON BLVD - VIENNA');
insert into line (name) values ('1Z WILSON BLVD - VIENNA');
insert into line (name) values ('21A LANDMARK-PENTAGON');
insert into line (name) values ('21D LANDMARK-PENTAGON');
insert into line (name) values ('22A BARCROFT-S.FAIRLINGTON');
insert into line (name) values ('22B BARCROFT-S.FAIRLINGTON');
insert into line (name) values ('23A MCLEAN-CRYS CITY');
insert into line (name) values ('23B MCLEAN-CRYS CITY');
insert into line (name) values ('23T MCLEAN-CRYS CITY');
insert into line (name) values ('25A BALL-BRADLEE-PENT');
insert into line (name) values ('25B LANDMARK-BALLSTON');
insert into line (name) values ('25C BALL-BRADLEE-PENT');
insert into line (name) values ('25D BALL-BRADLEE-PENT');
insert into line (name) values ('25E BALL-BRADLEE-PENT');
insert into line (name) values ('26A ANNANDALE - EAST FALLS CH');
insert into line (name) values ('28A LEESBURG PIKE');
insert into line (name) values ('28F SKYLINE CITY');
insert into line (name) values ('28G SKYLINE CITY');
insert into line (name) values ('28X LEESBURG PIKE LTD');
insert into line (name) values ('29C ANNANDALE');
insert into line (name) values ('29G ANNANDALE');
insert into line (name) values ('29K ALEX-FAIRFAX');
insert into line (name) values ('29N ALEX-FAIRFAX');
insert into line (name) values ('29W BRAEBURN DR.- PENT. EXP');
insert into line (name) values ('2A WASHINGTON BLVD - DUNN LORI');
insert into line (name) values ('2B FAIR OAKS-JERMANTOWN RD');
insert into line (name) values ('2T TYSONS-DUNN LORI');
insert into line (name) values ('30N FRIENDSHIP HTS - SOUTHEAS');
insert into line (name) values ('30S FRIENDSHIP HTS - SOUTHEAS');
insert into line (name) values ('31 WISCONSIN AVE');
insert into line (name) values ('32 PENNSYLVANIA AVE');
insert into line (name) values ('33 WISCONSIN AVE');
insert into line (name) values ('34 PENNSYLVANIA AVE');
insert into line (name) values ('36 PENNSYLVANIA AVE');
insert into line (name) values ('37 WISCONSIN AVE LTD');
insert into line (name) values ('38B BALLSTON-FARR SQ');
insert into line (name) values ('39 PA AVE LIMITED');
insert into line (name) values ('3A LEE HIGHWAY-FALLS CHURCH');
insert into line (name) values ('3T PIMMIT HILLS-FALLS CHURCH');
insert into line (name) values ('3Y LEE HWY-FARR.SQ');
insert into line (name) values ('42 MOUNT PLEASANT');
insert into line (name) values ('43 MOUNT PLEASANT');
insert into line (name) values ('4A PERSH DR-ARL BLVD');
insert into line (name) values ('4B PERSH DR-ARL BLVD');
insert into line (name) values ('52 14TH STREET');
insert into line (name) values ('53 14TH STREET');
insert into line (name) values ('54 14TH STREET');
insert into line (name) values ('5A DC-DULLES');
insert into line (name) values ('60 FT TOTT-PETWORTH');
insert into line (name) values ('62 TAKOMA-PETWORTH');
insert into line (name) values ('63 TAKOMA-PETWORTH');
insert into line (name) values ('64 FT TOTT-PETWORTH');
insert into line (name) values ('70 GA AVE-7TH STREET');
insert into line (name) values ('74 CONVENTION CTR - S W WATERF');
insert into line (name) values ('79 GEORGIA AVE LIMITED');
insert into line (name) values ('7A LINC-N FAIRLNGTON');
insert into line (name) values ('7C LINCOLNIA - PARK CENTER PEN');
insert into line (name) values ('7F LINC-N FAIRLNGTON');
insert into line (name) values ('7H LINCOLNIA - PARK CENTER PEN');
insert into line (name) values ('7M MARK CENTER-PENT');
insert into line (name) values ('7P LINCOLNIA - PARK CENTER PEN');
insert into line (name) values ('7W LINCOLNIA - PARK CENTER PEN');
insert into line (name) values ('7X LINCOLNIA - PARK CENTER PEN');
insert into line (name) values ('7Y LINC-N FAIRLNGTON');
insert into line (name) values ('80 NORTH CAPITOL ST');
insert into line (name) values ('81 COLLEGE PARK');
insert into line (name) values ('82 COLLEGE PARK');
insert into line (name) values ('83 COLLEGE PARK');
insert into line (name) values ('86 COLLEGE PARK');
insert into line (name) values ('87 LAUREL EXPRESS');
insert into line (name) values ('89 LAUREL');
insert into line (name) values ('89M LAUREL');
insert into line (name) values ('8S FOXCHASE-SEM VALL');
insert into line (name) values ('8W FOXCHASE-SEM VALL');
insert into line (name) values ('8Z FOXCHASE-SEM VALL');
insert into line (name) values ('90 U ST-GARFIELD');
insert into line (name) values ('92 U ST-GARFIELD');
insert into line (name) values ('93 U ST-GARFIELD');
insert into line (name) values ('94 STANTON ROAD');
insert into line (name) values ('96 EAST CAP-CARDOZO');
insert into line (name) values ('97 EAST CAP-CARDOZO');
insert into line (name) values ('9A HUNT-PENT');
insert into line (name) values ('A12 M L KING HIGHWAY');
insert into line (name) values ('A2 ANAC-CONG HGTS');
insert into line (name) values ('A31 ANAC HS');
insert into line (name) values ('A32 ANAC HS');
insert into line (name) values ('A33 ANAC HS');
insert into line (name) values ('A4 ANAC-FORT DRUM');
insert into line (name) values ('A42 ANAC-CONG HGTS');
insert into line (name) values ('A46 ANAC-CONG HGTS');
insert into line (name) values ('A48 ANAC-CONG HGTS');
insert into line (name) values ('A6 ANAC-CONG HGTS');
insert into line (name) values ('A7 ANAC-CONG HGTS');
insert into line (name) values ('A8 ANAC-CONG HGTS');
insert into line (name) values ('A9 MLK AVE LIMITED');
insert into line (name) values ('B2 BLAD RD-ANACOSTIA');
insert into line (name) values ('B21 BOWIE STATE UNIV');
insert into line (name) values ('B22 BOWIE STATE UNIV');
insert into line (name) values ('B24 BOWIE-BELAIR');
insert into line (name) values ('B25 BOWIE-BELAIR');
insert into line (name) values ('B27 BOWIE-NEW CARROLL');
insert into line (name) values ('B29 CROFTON - NEW  CARR');
insert into line (name) values ('B30 GREENBELT-BWI');
insert into line (name) values ('B31 CROFTON - NEW  CARR');
insert into line (name) values ('B51 BROOKLAND EDU CAMPUS');
insert into line (name) values ('B8 FT LINCOLN SHUT');
insert into line (name) values ('B9 FT LINCOLN SHUT');
insert into line (name) values ('C11 CLINTON');
insert into line (name) values ('C12 HILLCREST HEIGHTS');
insert into line (name) values ('C13 CLINTON');
insert into line (name) values ('C14 HILLCREST HEIGHTS');
insert into line (name) values ('C2 GBLT-TWINBROOK');
insert into line (name) values ('C21 CENTRAL AVENUE');
insert into line (name) values ('C22 CENTRAL AVENUE');
insert into line (name) values ('C26 CENTRAL AVENUE');
insert into line (name) values ('C27 CENTRAL AVE EXTRA SERVICE');
insert into line (name) values ('C28 POINTER RIDGE');
insert into line (name) values ('C4 GBLT-TWINBROOK');
insert into line (name) values ('C40 CAP HILL CLUSTER');
insert into line (name) values ('C8 COL PK-WHITE FLNT');
insert into line (name) values ('D1 GLOVER PK-FED TRIANGLE');
insert into line (name) values ('D12 OXON HILL-SUIT');
insert into line (name) values ('D13 OXON HILL-SUIT');
insert into line (name) values ('D14 OXON HILL-SUIT');
insert into line (name) values ('D2 GLOV PK-DUP CIRC');
insert into line (name) values ('D3 IVY CITY-DUPONT CIRCLE');
insert into line (name) values ('D31 DEAL JR HI SCH');
insert into line (name) values ('D32 DEAL JR HI SCH');
insert into line (name) values ('D33 DEAL JR HI SCH');
insert into line (name) values ('D34 DEAL JR HI SCH');
insert into line (name) values ('D4 IVY CITY-FRANKLIN SQUARE');
insert into line (name) values ('D5 MAC BLVD-GEOTOWN');
insert into line (name) values ('D51 D ELLINGTON H S');
insert into line (name) values ('D6 SIBLEY-STAD ARM');
insert into line (name) values ('D8 HOSPITAL CENTER');
insert into line (name) values ('E2 MIL RD-CROSSTOWN');
insert into line (name) values ('E3 MIL RD-CROSSTOWN');
insert into line (name) values ('E32 EASTERN HI SCH');
insert into line (name) values ('E4 MIL RD-CROSSTOWN');
insert into line (name) values ('E6 CHEVY CHASE');
insert into line (name) values ('F1 CHILLUM ROAD');
insert into line (name) values ('F12 ARD IND PK SHUT');
insert into line (name) values ('F13 CHEV-WASH BUS PK');
insert into line (name) values ('F14 SHER RD-CAP HGTS');
insert into line (name) values ('F2 CHILLUM ROAD');
insert into line (name) values ('F4 NEW CARR - SILVER SPRING');
insert into line (name) values ('F6 NEW CARR - FORT TOTTEN');
insert into line (name) values ('F8 LANGLEY PARK - CHEVERLY');
insert into line (name) values ('G12 GREENBELT-NEW CARR');
insert into line (name) values ('G13 GREENBELT-NEW CARR');
insert into line (name) values ('G14 GREENBELT-NEW CARR');
insert into line (name) values ('G16 GREENBELT-NEW CARR');
insert into line (name) values ('G2 P ST-LEDROIT PARK');
insert into line (name) values ('G8 RHODE ISLAND AVE');
insert into line (name) values ('H1 BROOKLAND-POT PK');
insert into line (name) values ('H11 MAR HTS-TEMP HILL');
insert into line (name) values ('H12 MAR HTS-TEMP HILL');
insert into line (name) values ('H13 MAR HTS-TEMP HILL');
insert into line (name) values ('H2 CROSSTOWN');
insert into line (name) values ('H3 CROSSTOWN');
insert into line (name) values ('H4 CROSSTOWN');
insert into line (name) values ('H6 BROOKLAND-FT LINCOLN');
insert into line (name) values ('H8 PARK RD-BROOKLAND');
insert into line (name) values ('H9 PARK RD-BROOKLAND');
insert into line (name) values ('J1 BETHESDA-SIL SPR');
insert into line (name) values ('J11 MARLBORO PIKE');
insert into line (name) values ('J12 MARLBORO PIKE');
insert into line (name) values ('J13 MARLBORO PIKE');
insert into line (name) values ('J2 BETHESDA-SIL SPR');
insert into line (name) values ('J3 BETHESDA-SIL SPR');
insert into line (name) values ('J4 COLLEGE PK-BETH LIMITED');
insert into line (name) values ('J5 TWINBROOK-SIL SPG');
insert into line (name) values ('J7 I-270 EXPRESS');
insert into line (name) values ('J9 I-270 EXPRESS');
insert into line (name) values ('K11 FORESTVILLE');
insert into line (name) values ('K12 FORESTVILLE');
insert into line (name) values ('K13 FORESTVILLE');
insert into line (name) values ('K2 TAKOMA-FT TOTTEN');
insert into line (name) values ('K6 NEW HAMP AVE-MD');
insert into line (name) values ('K9 NEW HAMPSHRE AVE-MD LTD');
insert into line (name) values ('L1 CONNECTICUT AVE');
insert into line (name) values ('L2 CONNECTICUT AVE');
insert into line (name) values ('L8 CONN AVE-MD');
insert into line (name) values ('M31 MCKINLEY HI SCH');
insert into line (name) values ('M4 NEBRASKA AVENUE');
insert into line (name) values ('M6 FAIRFAX VILLAGE');
insert into line (name) values ('N2 MASS AVENUE');
insert into line (name) values ('N3 MASS AVENUE');
insert into line (name) values ('N4 MASS AVENUE');
insert into line (name) values ('N6 MASS AVENUE');
insert into line (name) values ('P12 EASTOVER-ADDISON');
insert into line (name) values ('P17 OXON HILL-FT WASH');
insert into line (name) values ('P18 OXON HILL-FT WASH');
insert into line (name) values ('P19 OXON HILL-FT WASH');
insert into line (name) values ('P6 ANAC-ECKINGTON');
insert into line (name) values ('Q1 VEIRS MILL RD');
insert into line (name) values ('Q2 VEIRS MILL RD');
insert into line (name) values ('Q4 VEIRS MILL RD');
insert into line (name) values ('Q5 VEIRS MILL RD');
insert into line (name) values ('Q6 VEIRS MILL RD');
insert into line (name) values ('R1 RIGGS ROAD');
insert into line (name) values ('R11 KENILWORTH AVENUE');
insert into line (name) values ('R12 KENILWORTH AVENUE');
insert into line (name) values ('R2 RIGGS ROAD');
insert into line (name) values ('R3 GBLT- P G PLAZA');
insert into line (name) values ('R4 QUEENS CHAPEL RD');
insert into line (name) values ('S1 16TH ST-POT PARK');
insert into line (name) values ('S2 SIXTEENTH STREET');
insert into line (name) values ('S35 SOUSA MIDDLE SCH');
insert into line (name) values ('S4 SIXTEENTH STREET');
insert into line (name) values ('S41 PHELPS HIGH SCH');
insert into line (name) values ('S80 SPRINGFIELD CIRC');
insert into line (name) values ('S9 16TH ST LIMITED');
insert into line (name) values ('S91 SPRINGFIELD CIRC');
insert into line (name) values ('T14 RI AVE-NEW CARR');
insert into line (name) values ('T18 ANNAPOLIS ROAD');
insert into line (name) values ('T2 RIVER ROAD');
insert into line (name) values ('U2 MINN AVE-ANAC');
insert into line (name) values ('U4 SHER RD-RIV TERR');
insert into line (name) values ('U5 MAYFAIR-MARS HGTS');
insert into line (name) values ('U6 MAYFAIR-MARS HGTS');
insert into line (name) values ('U8 CAP HTS-BENN HTS');
insert into line (name) values ('V12 DIST HTS-SUITLAND');
insert into line (name) values ('V14 DIS HTS-SEAT PLEA');
insert into line (name) values ('V15 DIS HTS-SEAT PLEA');
insert into line (name) values ('V5 FX VILL-LENF PLAZ');
insert into line (name) values ('V7 MINN AVE-M STREET');
insert into line (name) values ('V8 MINN AVE-M STREET');
insert into line (name) values ('V9 MINN AVE-M STREET');
insert into line (name) values ('W1 SHIPLEY TERR - FT DRUM');
insert into line (name) values ('W13 BOCK ROAD');
insert into line (name) values ('W14 BOCK ROAD');
insert into line (name) values ('W15 CAMP SPRINGS-INDIAN HEAD');
insert into line (name) values ('W19 INDIAN HEAD EXP');
insert into line (name) values ('W2 UNITED MED CTR-ANAC');
insert into line (name) values ('W3 UNITED MED CTR-ANAC');
insert into line (name) values ('W4 DEANWOOD-ALAB AVE');
insert into line (name) values ('W45 WILSON HI SCH');
insert into line (name) values ('W47 WILSON HI SCH');
insert into line (name) values ('W5 ANAC-FORT DRUM');
insert into line (name) values ('W6 GARFELD-ANAC LOOP');
insert into line (name) values ('W8 GARFELD-ANAC LOOP');
insert into line (name) values ('W9 SOUTH CAP ST LIMITED');
insert into line (name) values ('X1 BENNING ROAD');
insert into line (name) values ('X2 BENNING RD-H ST');
insert into line (name) values ('X3 BENNING ROAD');
insert into line (name) values ('X8 MARYLAND AVENUE');
insert into line (name) values ('X9 BENNING RD-H ST LTD');
insert into line (name) values ('Y2 GEORGIA AVE-MD');
insert into line (name) values ('Y8 GEORGIA AVE-MD');
insert into line (name) values ('Z13 GRNCASTLE-BRG CHANEY EXP');
insert into line (name) values ('Z6 CALVERTON-WESTFARM');
insert into line (name) values ('Z8 FAIRLAND');
insert into line (name) values ('Z9 LAUREL-BURTONSVILL EXP');

-- TODO line_stop
insert into line_stop (line_id, stop_id, line_order) values (1, 67, 1);
insert into line_stop (line_id, stop_id, line_order) values (1, 65, 2);
insert into line_stop (line_id, stop_id, line_order) values (1, 77, 3);
insert into line_stop (line_id, stop_id, line_order) values (1, 89, 4);
insert into line_stop (line_id, stop_id, line_order) values (1, 41, 5);
insert into line_stop (line_id, stop_id, line_order) values (1, 50, 6);
insert into line_stop (line_id, stop_id, line_order) values (1, 7, 7);
insert into line_stop (line_id, stop_id, line_order) values (1, 35, 8);
insert into line_stop (line_id, stop_id, line_order) values (1, 76, 9);
insert into line_stop (line_id, stop_id, line_order) values (1, 82, 10);
insert into line_stop (line_id, stop_id, line_order) values (1, 15, 11);
insert into line_stop (line_id, stop_id, line_order) values (1, 91, 12);
insert into line_stop (line_id, stop_id, line_order) values (1, 23, 13);
insert into line_stop (line_id, stop_id, line_order) values (1, 27, 14);
insert into line_stop (line_id, stop_id, line_order) values (1, 51, 15);
insert into line_stop (line_id, stop_id, line_order) values (1, 36, 16);
insert into line_stop (line_id, stop_id, line_order) values (1, 43, 17);
insert into line_stop (line_id, stop_id, line_order) values (1, 80, 18);
insert into line_stop (line_id, stop_id, line_order) values (1, 59, 19);
insert into line_stop (line_id, stop_id, line_order) values (1, 64, 20);
insert into line_stop (line_id, stop_id, line_order) values (1, 10, 21);
insert into line_stop (line_id, stop_id, line_order) values (1, 33, 22);
insert into line_stop (line_id, stop_id, line_order) values (1, 75, 23);
insert into line_stop (line_id, stop_id, line_order) values (1, 69, 24);
insert into line_stop (line_id, stop_id, line_order) values (1, 32, 25);
insert into line_stop (line_id, stop_id, line_order) values (1, 88, 26);
insert into line_stop (line_id, stop_id, line_order) values (1, 38, 27);
insert into line_stop (line_id, stop_id, line_order) values (2, 83, 1);
insert into line_stop (line_id, stop_id, line_order) values (2, 22, 2);
insert into line_stop (line_id, stop_id, line_order) values (2, 85, 3);
insert into line_stop (line_id, stop_id, line_order) values (2, 24, 4);
insert into line_stop (line_id, stop_id, line_order) values (2, 5, 5);
insert into line_stop (line_id, stop_id, line_order) values (2, 84, 6);
insert into line_stop (line_id, stop_id, line_order) values (2, 14, 7);
insert into line_stop (line_id, stop_id, line_order) values (2, 19, 8);
insert into line_stop (line_id, stop_id, line_order) values (2, 66, 9);
insert into line_stop (line_id, stop_id, line_order) values (2, 31, 10);
insert into line_stop (line_id, stop_id, line_order) values (2, 28, 11);
insert into line_stop (line_id, stop_id, line_order) values (2, 49, 12);
insert into line_stop (line_id, stop_id, line_order) values (2, 51, 13);
insert into line_stop (line_id, stop_id, line_order) values (2, 30, 14);
insert into line_stop (line_id, stop_id, line_order) values (2, 70, 15);
insert into line_stop (line_id, stop_id, line_order) values (2, 45, 16);
insert into line_stop (line_id, stop_id, line_order) values (2, 29, 17);
insert into line_stop (line_id, stop_id, line_order) values (2, 12, 18);
insert into line_stop (line_id, stop_id, line_order) values (2, 25, 19);
insert into line_stop (line_id, stop_id, line_order) values (2, 62, 20);
insert into line_stop (line_id, stop_id, line_order) values (2, 73, 21);
insert into line_stop (line_id, stop_id, line_order) values (2, 52, 22);
insert into line_stop (line_id, stop_id, line_order) values (2, 21, 23);
insert into line_stop (line_id, stop_id, line_order) values (2, 13, 24);
insert into line_stop (line_id, stop_id, line_order) values (2, 46, 25);
insert into line_stop (line_id, stop_id, line_order) values (2, 58, 26);
insert into line_stop (line_id, stop_id, line_order) values (3, 42, 1);
insert into line_stop (line_id, stop_id, line_order) values (3, 26, 2);
insert into line_stop (line_id, stop_id, line_order) values (3, 44, 3);
insert into line_stop (line_id, stop_id, line_order) values (3, 8, 4);
insert into line_stop (line_id, stop_id, line_order) values (3, 55, 5);
insert into line_stop (line_id, stop_id, line_order) values (3, 20, 6);
insert into line_stop (line_id, stop_id, line_order) values (3, 60, 7);
insert into line_stop (line_id, stop_id, line_order) values (3, 61, 8);
insert into line_stop (line_id, stop_id, line_order) values (3, 45, 9);
insert into line_stop (line_id, stop_id, line_order) values (3, 3, 10);
insert into line_stop (line_id, stop_id, line_order) values (3, 36, 11);
insert into line_stop (line_id, stop_id, line_order) values (3, 54, 12);
insert into line_stop (line_id, stop_id, line_order) values (3, 68, 13);
insert into line_stop (line_id, stop_id, line_order) values (3, 79, 14);
insert into line_stop (line_id, stop_id, line_order) values (3, 17, 15);
insert into line_stop (line_id, stop_id, line_order) values (3, 37, 16);
insert into line_stop (line_id, stop_id, line_order) values (3, 33, 17);
insert into line_stop (line_id, stop_id, line_order) values (4, 9, 1);
insert into line_stop (line_id, stop_id, line_order) values (4, 74, 2);
insert into line_stop (line_id, stop_id, line_order) values (4, 57, 3);
insert into line_stop (line_id, stop_id, line_order) values (4, 71, 4);
insert into line_stop (line_id, stop_id, line_order) values (4, 18, 5);
insert into line_stop (line_id, stop_id, line_order) values (4, 2, 6);
insert into line_stop (line_id, stop_id, line_order) values (4, 56, 7);
insert into line_stop (line_id, stop_id, line_order) values (4, 86, 8);
insert into line_stop (line_id, stop_id, line_order) values (4, 45, 9);
insert into line_stop (line_id, stop_id, line_order) values (4, 3, 10);
insert into line_stop (line_id, stop_id, line_order) values (4, 36, 11);
insert into line_stop (line_id, stop_id, line_order) values (4, 54, 12);
insert into line_stop (line_id, stop_id, line_order) values (4, 68, 13);
insert into line_stop (line_id, stop_id, line_order) values (4, 79, 14);
insert into line_stop (line_id, stop_id, line_order) values (4, 17, 15);
insert into line_stop (line_id, stop_id, line_order) values (4, 37, 16);
insert into line_stop (line_id, stop_id, line_order) values (4, 33, 17);
insert into line_stop (line_id, stop_id, line_order) values (4, 87, 18);
insert into line_stop (line_id, stop_id, line_order) values (4, 63, 19);
insert into line_stop (line_id, stop_id, line_order) values (4, 16, 20);
insert into line_stop (line_id, stop_id, line_order) values (4, 39, 21);
insert into line_stop (line_id, stop_id, line_order) values (5, 34, 1);
insert into line_stop (line_id, stop_id, line_order) values (5, 81, 2);
insert into line_stop (line_id, stop_id, line_order) values (5, 44, 3);
insert into line_stop (line_id, stop_id, line_order) values (5, 8, 4);
insert into line_stop (line_id, stop_id, line_order) values (5, 55, 5);
insert into line_stop (line_id, stop_id, line_order) values (5, 20, 6);
insert into line_stop (line_id, stop_id, line_order) values (5, 20, 7);
insert into line_stop (line_id, stop_id, line_order) values (5, 61, 8);
insert into line_stop (line_id, stop_id, line_order) values (5, 4, 9);
insert into line_stop (line_id, stop_id, line_order) values (5, 66, 10);
insert into line_stop (line_id, stop_id, line_order) values (5, 31, 11);
insert into line_stop (line_id, stop_id, line_order) values (5, 28, 12);
insert into line_stop (line_id, stop_id, line_order) values (5, 49, 13);
insert into line_stop (line_id, stop_id, line_order) values (5, 51, 14);
insert into line_stop (line_id, stop_id, line_order) values (5, 30, 15);
insert into line_stop (line_id, stop_id, line_order) values (5, 70, 16);
insert into line_stop (line_id, stop_id, line_order) values (5, 45, 17);
insert into line_stop (line_id, stop_id, line_order) values (5, 29, 18);
insert into line_stop (line_id, stop_id, line_order) values (5, 12, 19);
insert into line_stop (line_id, stop_id, line_order) values (5, 25, 20);
insert into line_stop (line_id, stop_id, line_order) values (5, 62, 21);
insert into line_stop (line_id, stop_id, line_order) values (5, 73, 22);
insert into line_stop (line_id, stop_id, line_order) values (5, 6, 23);
insert into line_stop (line_id, stop_id, line_order) values (5, 11, 24);
insert into line_stop (line_id, stop_id, line_order) values (5, 1, 25);
insert into line_stop (line_id, stop_id, line_order) values (5, 53, 26);
insert into line_stop (line_id, stop_id, line_order) values (5, 47, 27);


-- TODO rider
INSERT INTO rider (name) VALUES ('Breanna Watson');
INSERT INTO rider (name) VALUES ('Dexter Rivas');
INSERT INTO rider (name) VALUES ('Pascale Gibson');
INSERT INTO rider (name) VALUES ('Tate Spencer');
INSERT INTO rider (name) VALUES ('Rowan Hensley');
INSERT INTO rider (name) VALUES ('Adena Holmes');
INSERT INTO rider (name) VALUES ('Cara Pittman');
INSERT INTO rider (name) VALUES ('Valentine Hatfield');
INSERT INTO rider (name) VALUES ('Gareth Wall');
INSERT INTO rider (name) VALUES ('Caldwell Pate');
INSERT INTO rider (name) VALUES ('Aiko Fleming');
INSERT INTO rider (name) VALUES ('Britanney Wise');
INSERT INTO rider (name) VALUES ('Kathleen Merritt');
INSERT INTO rider (name) VALUES ('Rae Green');
INSERT INTO rider (name) VALUES ('Halla Lowe');
INSERT INTO rider (name) VALUES ('Graham Odom');
INSERT INTO rider (name) VALUES ('Michelle Hutchinson');
INSERT INTO rider (name) VALUES ('Kaye Vincent');
INSERT INTO rider (name) VALUES ('Juliet Hunter');
INSERT INTO rider (name) VALUES ('Rafael Garza');
INSERT INTO rider (name) VALUES ('Branden Rutledge');
INSERT INTO rider (name) VALUES ('Illana Goff');
INSERT INTO rider (name) VALUES ('Kendall Livingston');
INSERT INTO rider (name) VALUES ('Maisie Fernandez');
INSERT INTO rider (name) VALUES ('Urielle Burns');
INSERT INTO rider (name) VALUES ('Dane Battle');
INSERT INTO rider (name) VALUES ('Blaine Black');
INSERT INTO rider (name) VALUES ('Wylie Hoover');
INSERT INTO rider (name) VALUES ('Ramona Ball');
INSERT INTO rider (name) VALUES ('Gage Cabrera');
INSERT INTO rider (name) VALUES ('Tatiana Sweeney');
INSERT INTO rider (name) VALUES ('Sheila Hardin');
INSERT INTO rider (name) VALUES ('Aladdin Jacobson');
INSERT INTO rider (name) VALUES ('Yolanda Talley');
INSERT INTO rider (name) VALUES ('Sybil Sweeney');
INSERT INTO rider (name) VALUES ('Aiko Lee');
INSERT INTO rider (name) VALUES ('Martina Simon');
INSERT INTO rider (name) VALUES ('Gisela Whitfield');
INSERT INTO rider (name) VALUES ('Castor Stephenson');
INSERT INTO rider (name) VALUES ('Emma Stevens');
INSERT INTO rider (name) VALUES ('Hall Anderson');
INSERT INTO rider (name) VALUES ('Gail Cummings');
INSERT INTO rider (name) VALUES ('Thaddeus Fields');
INSERT INTO rider (name) VALUES ('Sean Mays');
INSERT INTO rider (name) VALUES ('Anastasia Ford');
INSERT INTO rider (name) VALUES ('Karleigh Horton');
INSERT INTO rider (name) VALUES ('Odysseus Taylor');
INSERT INTO rider (name) VALUES ('Victor Stanley');
INSERT INTO rider (name) VALUES ('Steel Huffman');
INSERT INTO rider (name) VALUES ('Russell Ellis');
INSERT INTO rider (name) VALUES ('Isaac Salinas');
INSERT INTO rider (name) VALUES ('Eagan Horn');
INSERT INTO rider (name) VALUES ('Ronan Larson');
INSERT INTO rider (name) VALUES ('Nigel Ball');
INSERT INTO rider (name) VALUES ('Hedy Brady');
INSERT INTO rider (name) VALUES ('Ahmed Perez');
INSERT INTO rider (name) VALUES ('Hyacinth Merrill');
INSERT INTO rider (name) VALUES ('Igor Holcomb');
INSERT INTO rider (name) VALUES ('Iola Forbes');
INSERT INTO rider (name) VALUES ('Rosalyn Mitchell');
INSERT INTO rider (name) VALUES ('Dana Stephens');
INSERT INTO rider (name) VALUES ('Calista Kidd');
INSERT INTO rider (name) VALUES ('Zeph Deleon');
INSERT INTO rider (name) VALUES ('Barclay Winters');
INSERT INTO rider (name) VALUES ('Penelope Hatfield');
INSERT INTO rider (name) VALUES ('Vladimir Cline');
INSERT INTO rider (name) VALUES ('Winifred Stark');
INSERT INTO rider (name) VALUES ('Rylee Atkins');
INSERT INTO rider (name) VALUES ('Priscilla Meyer');
INSERT INTO rider (name) VALUES ('Isaac Maldonado');
INSERT INTO rider (name) VALUES ('Hilary Merrill');
INSERT INTO rider (name) VALUES ('Nelle Hurst');
INSERT INTO rider (name) VALUES ('Wilma Hart');
INSERT INTO rider (name) VALUES ('Sylvester Hinton');
INSERT INTO rider (name) VALUES ('Marshall Mcintyre');
INSERT INTO rider (name) VALUES ('Karleigh Long');
INSERT INTO rider (name) VALUES ('Zorita Ferrell');
INSERT INTO rider (name) VALUES ('Hashim Drake');
INSERT INTO rider (name) VALUES ('Elvis Hernandez');
INSERT INTO rider (name) VALUES ('Walker Baldwin');
INSERT INTO rider (name) VALUES ('Brenden Justice');
INSERT INTO rider (name) VALUES ('Mia Reynolds');
INSERT INTO rider (name) VALUES ('Pamela Rogers');
INSERT INTO rider (name) VALUES ('Aubrey Osborn');
INSERT INTO rider (name) VALUES ('Kareem Hunt');
INSERT INTO rider (name) VALUES ('Nigel Travis');
INSERT INTO rider (name) VALUES ('Raymond Howard');
INSERT INTO rider (name) VALUES ('Ezra Kirkland');
INSERT INTO rider (name) VALUES ('Noah Velasquez');
INSERT INTO rider (name) VALUES ('Imani Ryan');
INSERT INTO rider (name) VALUES ('Cameran Fry');
INSERT INTO rider (name) VALUES ('Brendan Mclaughlin');
INSERT INTO rider (name) VALUES ('Hilary Patton');
INSERT INTO rider (name) VALUES ('Cherokee Kidd');
INSERT INTO rider (name) VALUES ('Alvin Foreman');
INSERT INTO rider (name) VALUES ('Shea Ball');
INSERT INTO rider (name) VALUES ('Rowan Sanders');
INSERT INTO rider (name) VALUES ('Mira Sampson');
INSERT INTO rider (name) VALUES ('Wyoming Austin');
INSERT INTO rider (name) VALUES ('Clark Vazquez');

-- TODO trip (depends on bus stops in stop)
