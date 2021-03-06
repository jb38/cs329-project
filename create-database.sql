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
  ,CONSTRAINT FOREIGN KEY (type) REFERENCES vehicle_type (id) ON DELETE CASCADE
);

CREATE TABLE operates (
   vehicle_id  INTEGER  NOT NULL
  ,driver_id   INTEGER  NOT NULL
  ,date        DATE     NOT NULL
  ,CONSTRAINT PRIMARY KEY (vehicle_id, driver_id, date)
  ,CONSTRAINT FOREIGN KEY (vehicle_id) REFERENCES vehicle (id) ON DELETE CASCADE
  ,CONSTRAINT FOREIGN KEY (driver_id) REFERENCES driver (id) ON DELETE CASCADE
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
  ,CONSTRAINT FOREIGN KEY (vehicle_id) REFERENCES vehicle (id) ON DELETE CASCADE
  ,CONSTRAINT FOREIGN KEY (incident_id) REFERENCES safety_incident (id) ON DELETE CASCADE
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
  ,CONSTRAINT FOREIGN KEY (vehicle_type) REFERENCES vehicle_type (id) ON DELETE CASCADE
);

CREATE TABLE line_stop (
   line_id     INTEGER  NOT NULL
  ,stop_id     INTEGER  NOT NULL
  ,line_order  INTEGER  NOT NULL
  ,CONSTRAINT PRIMARY KEY (line_id, stop_id)
  ,CONSTRAINT FOREIGN KEY (line_id) REFERENCES line (id) ON DELETE CASCADE
  ,CONSTRAINT FOREIGN KEY (stop_id) REFERENCES stop (id) ON DELETE CASCADE
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
  ,CONSTRAINT FOREIGN KEY (rider_id) REFERENCES rider (id) ON DELETE CASCADE
  ,CONSTRAINT FOREIGN KEY (entry_stop) REFERENCES stop (id) ON DELETE CASCADE
  ,CONSTRAINT FOREIGN KEY (exit_stop) REFERENCES stop (id) ON DELETE CASCADE
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

INSERT INTO involved_in (vehicle_id, incident_id, at_fault) VALUES (37, 1, TRUE);
INSERT INTO involved_in (vehicle_id, incident_id, at_fault) VALUES (45, 2, TRUE);
INSERT INTO involved_in (vehicle_id, incident_id, at_fault) VALUES (77, 3, TRUE);

INSERT INTO stop (name, latitude, longitude) VALUES ('Addison Road', 38.8867478168, -76.89410791);
INSERT INTO stop (name, latitude, longitude) VALUES ('Anacostia', 38.8629631168, -76.9953707387);
INSERT INTO stop (name, latitude, longitude) VALUES ('Archives', 38.8936652235, -77.0219143879);
INSERT INTO stop (name, latitude, longitude) VALUES ('Arlington Cemetery', 38.8846868585, -77.0628101291);
INSERT INTO stop (name, latitude, longitude) VALUES ('Ballston', 38.8821828738, -77.113168835);
INSERT INTO stop (name, latitude, longitude) VALUES ('Benning Road', 38.890975676, -76.9383648681);
INSERT INTO stop (name, latitude, longitude) VALUES ('Bethesda', 38.9843936603, -77.0941291922);
INSERT INTO stop (name, latitude, longitude) VALUES ('Braddock Road', 38.8141436672, -77.053667574);
INSERT INTO stop (name, latitude, longitude) VALUES ('Branch Avenue', 38.8264463483, -76.9114642177);
INSERT INTO stop (name, latitude, longitude) VALUES ('Brookland', 38.9332109913, -76.9945342851);
INSERT INTO stop (name, latitude, longitude) VALUES ('Capitol Heights', 38.8894658568, -76.9118081145);
INSERT INTO stop (name, latitude, longitude) VALUES ('Capitol South', 38.8850625009, -77.0051394199);
INSERT INTO stop (name, latitude, longitude) VALUES ('Cheverly', 38.9166318546, -76.916628044);
INSERT INTO stop (name, latitude, longitude) VALUES ('Clarendon', 38.886704839, -77.0953940983);
INSERT INTO stop (name, latitude, longitude) VALUES ('Cleveland Park', 38.9347628908, -77.0580425191);
INSERT INTO stop (name, latitude, longitude) VALUES ('College Park', 38.9786336339, -76.9281249818);
INSERT INTO stop (name, latitude, longitude) VALUES ('Columbia Heights', 38.9278379675, -77.0325521177);
INSERT INTO stop (name, latitude, longitude) VALUES ('Congress Height', 38.8456577028, -76.9885119326);
INSERT INTO stop (name, latitude, longitude) VALUES ('Court House', 38.8901755312, -77.087131231);
INSERT INTO stop (name, latitude, longitude) VALUES ('Crystal City', 38.8579043204, -77.0502898097);
INSERT INTO stop (name, latitude, longitude) VALUES ('Deanwood', 38.9081784965, -76.935256783);
INSERT INTO stop (name, latitude, longitude) VALUES ('Dunn Loring', 38.8836251359, -77.2271606721);
INSERT INTO stop (name, latitude, longitude) VALUES ('Dupont Circle', 38.9095980575, -77.0434143597);
INSERT INTO stop (name, latitude, longitude) VALUES ('E Falls Church', 38.8859531663, -77.1568830199);
INSERT INTO stop (name, latitude, longitude) VALUES ('Eastern Market', 38.8846222608, -76.9960011267);
INSERT INTO stop (name, latitude, longitude) VALUES ('Eisenhower Avenue', 38.8004254497, -77.0708743893);
INSERT INTO stop (name, latitude, longitude) VALUES ('Farragut North', 38.9032019462, -77.0397008272);
INSERT INTO stop (name, latitude, longitude) VALUES ('Farragut West', 38.9013128941, -77.0406954151);
INSERT INTO stop (name, latitude, longitude) VALUES ('Federal Center SW', 38.8850723551, -77.0158682169);
INSERT INTO stop (name, latitude, longitude) VALUES ('Federal Triangle', 38.8931808718, -77.0281319984);
INSERT INTO stop (name, latitude, longitude) VALUES ('Foggy Bottom', 38.9006980092, -77.050277739);
INSERT INTO stop (name, latitude, longitude) VALUES ('Forest Glen', 39.0149542752, -77.0429165548);
INSERT INTO stop (name, latitude, longitude) VALUES ('Fort Totten', 38.9518467675, -77.0022030768);
INSERT INTO stop (name, latitude, longitude) VALUES ('Franconia-Springfield', 38.7665218926, -77.1679701804);
INSERT INTO stop (name, latitude, longitude) VALUES ('Friendship Heights', 38.9594838736, -77.084995805);
INSERT INTO stop (name, latitude, longitude) VALUES ('Gallery Place', 38.8983168097, -77.0219153904);
INSERT INTO stop (name, latitude, longitude) VALUES ('Georgia Avenue', 38.9374346301, -77.023460904);
INSERT INTO stop (name, latitude, longitude) VALUES ('Glenmont', 39.0617837655, -77.0535573593);
INSERT INTO stop (name, latitude, longitude) VALUES ('Greenbelt', 39.0111458605, -76.9110575731);
INSERT INTO stop (name, latitude, longitude) VALUES ('Greensboro', 38.921732, -77.234607);
INSERT INTO stop (name, latitude, longitude) VALUES ('Grosvenor', 39.02926895, -77.10384972);
INSERT INTO stop (name, latitude, longitude) VALUES ('Huntington', 38.7939158529, -77.0752057891);
INSERT INTO stop (name, latitude, longitude) VALUES ('Judiciary Square', 38.8960903176, -77.0166389566);
INSERT INTO stop (name, latitude, longitude) VALUES ('King Street', 38.8065861172, -77.0608112085);
INSERT INTO stop (name, latitude, longitude) VALUES ('L''Enfant Plaza', 38.8848377279, -77.021908484);
INSERT INTO stop (name, latitude, longitude) VALUES ('Landover', 38.9335062344, -76.8911979676);
INSERT INTO stop (name, latitude, longitude) VALUES ('Largo Town Center', 38.9050688072, -76.8420375202);
INSERT INTO stop (name, latitude, longitude) VALUES ('McLean', 38.924432, -77.210295);
INSERT INTO stop (name, latitude, longitude) VALUES ('McPherson Square', 38.9013327968, -77.0336341721);
INSERT INTO stop (name, latitude, longitude) VALUES ('Medical Center', 39.0000564843, -77.0969522905);
INSERT INTO stop (name, latitude, longitude) VALUES ('Metro Center', 38.8983144732, -77.0280779971);
INSERT INTO stop (name, latitude, longitude) VALUES ('Minnesota Avenue', 38.899191223, -76.9467477336);
INSERT INTO stop (name, latitude, longitude) VALUES ('Morgan Blvd', 38.8938349282, -76.8680747681);
INSERT INTO stop (name, latitude, longitude) VALUES ('Mt Vernon Sq', 38.9064368149, -77.0219143803);
INSERT INTO stop (name, latitude, longitude) VALUES ('National Arpt', 38.8534163859, -77.0440422943);
INSERT INTO stop (name, latitude, longitude) VALUES ('Navy Yard', 38.8764810849, -77.0050856513);
INSERT INTO stop (name, latitude, longitude) VALUES ('Naylor Road', 38.8513013835, -76.9562627094);
INSERT INTO stop (name, latitude, longitude) VALUES ('New Carrollton', 38.9477848558, -76.8718412865);
INSERT INTO stop (name, latitude, longitude) VALUES ('New York Avenue', 38.9070162121, -77.0030204472);
INSERT INTO stop (name, latitude, longitude) VALUES ('Pentagon City', 38.8618823867, -77.0595389215);
INSERT INTO stop (name, latitude, longitude) VALUES ('Pentagon', 38.8694627012, -77.0537156734);
INSERT INTO stop (name, latitude, longitude) VALUES ('Potomac Avenue', 38.8812632736, -76.9854953196);
INSERT INTO stop (name, latitude, longitude) VALUES ('Prince Georges Plaza', 38.9653854458, -76.9558815078);
INSERT INTO stop (name, latitude, longitude) VALUES ('Rhode Island Avenue', 38.9210596891, -76.9959369166);
INSERT INTO stop (name, latitude, longitude) VALUES ('Rockville', 39.0843216075, -77.1461253392);
INSERT INTO stop (name, latitude, longitude) VALUES ('Rosslyn', 38.8959790962, -77.0709086853);
INSERT INTO stop (name, latitude, longitude) VALUES ('Shady Grove', 39.1199273249, -77.1646273343);
INSERT INTO stop (name, latitude, longitude) VALUES ('Shaw', 38.9134768711, -77.0219117007);
INSERT INTO stop (name, latitude, longitude) VALUES ('Silver Spring', 38.9939493747, -77.0310178268);
INSERT INTO stop (name, latitude, longitude) VALUES ('Smithsonian', 38.888018702, -77.0280662342);
INSERT INTO stop (name, latitude, longitude) VALUES ('Southern Ave', 38.8410857803, -76.9750541388);
INSERT INTO stop (name, latitude, longitude) VALUES ('Spring Hill', 38.928872, -77.241472);
INSERT INTO stop (name, latitude, longitude) VALUES ('Stadium Armory', 38.8867090898, -76.9770889014);
INSERT INTO stop (name, latitude, longitude) VALUES ('Suitland', 38.8439645544, -76.9318701589);
INSERT INTO stop (name, latitude, longitude) VALUES ('Takoma', 38.976078531, -77.0181766987);
INSERT INTO stop (name, latitude, longitude) VALUES ('Tenleytown', 38.9488514351, -77.0795873255);
INSERT INTO stop (name, latitude, longitude) VALUES ('Twinbrook', 39.0624676517, -77.1208179517);
INSERT INTO stop (name, latitude, longitude) VALUES ('Tysons Corner', 38.920496, -77.222262);
INSERT INTO stop (name, latitude, longitude) VALUES ('U Street', 38.9170023992, -77.0274958929);
INSERT INTO stop (name, latitude, longitude) VALUES ('Union Station', 38.8977660392, -77.0074142921);
INSERT INTO stop (name, latitude, longitude) VALUES ('Van Dorn St', 38.799307672, -77.1291115237);
INSERT INTO stop (name, latitude, longitude) VALUES ('Van Ness UDC', 38.9432652883, -77.0629861805);
INSERT INTO stop (name, latitude, longitude) VALUES ('Vienna', 38.8776011238, -77.2726222569);
INSERT INTO stop (name, latitude, longitude) VALUES ('Virginia Square', 38.8833661518, -77.1029772942);
INSERT INTO stop (name, latitude, longitude) VALUES ('W Falls Church', 38.900780551, -77.1890948225);
INSERT INTO stop (name, latitude, longitude) VALUES ('Waterfront', 38.8764618668, -77.0175052088);
INSERT INTO stop (name, latitude, longitude) VALUES ('West Hyattsville', 38.9550401707, -76.9695766751);
INSERT INTO stop (name, latitude, longitude) VALUES ('Wheaton', 39.0375271436, -77.0501070535);
INSERT INTO stop (name, latitude, longitude) VALUES ('White Flint', 39.0481513573, -77.112829859);
INSERT INTO stop (name, latitude, longitude) VALUES ('Wiehle-Reston East', 38.94778, -77.34027);
INSERT INTO stop (name, latitude, longitude) VALUES ('Woodley Park Zoo', 38.9250851371, -77.0524180207);

INSERT INTO line (name, vehicle_type) VALUES ('RED', 1);
INSERT INTO line (name, vehicle_type) VALUES ('ORANGE', 1);
INSERT INTO line (name, vehicle_type) VALUES ('YELLOW', 1);
INSERT INTO line (name, vehicle_type) VALUES ('GREEN', 1);
INSERT INTO line (name, vehicle_type) VALUES ('BLUE', 1);

INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 67, 1);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 65, 2);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 77, 3);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 89, 4);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 41, 5);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 50, 6);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 7, 7);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 35, 8);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 76, 9);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 82, 10);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 15, 11);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 91, 12);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 23, 13);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 27, 14);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 51, 15);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 36, 16);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 43, 17);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 80, 18);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 59, 19);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 64, 20);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 10, 21);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 33, 22);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 75, 23);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 69, 24);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 32, 25);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 88, 26);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (1, 38, 27);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 83, 1);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 22, 2);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 85, 3);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 24, 4);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 5, 5);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 84, 6);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 14, 7);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 19, 8);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 66, 9);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 31, 10);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 28, 11);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 49, 12);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 51, 13);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 30, 14);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 70, 15);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 45, 16);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 29, 17);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 12, 18);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 25, 19);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 62, 20);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 73, 21);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 52, 22);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 21, 23);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 13, 24);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 46, 25);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (2, 58, 26);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 42, 1);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 26, 2);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 44, 3);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 8, 4);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 55, 5);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 20, 6);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 60, 7);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 61, 8);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 45, 9);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 3, 10);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 36, 11);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 54, 12);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 68, 13);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 79, 14);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 17, 15);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 37, 16);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (3, 33, 17);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 9, 1);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 74, 2);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 57, 3);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 71, 4);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 18, 5);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 2, 6);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 56, 7);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 86, 8);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 45, 9);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 3, 10);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 36, 11);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 54, 12);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 68, 13);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 79, 14);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 17, 15);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 37, 16);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 33, 17);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 87, 18);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 63, 19);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 16, 20);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (4, 39, 21);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 34, 1);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 81, 2);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 44, 3);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 8, 4);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 55, 5);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 20, 6);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 20, 7);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 61, 8);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 4, 9);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 66, 10);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 31, 11);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 28, 12);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 49, 13);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 51, 14);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 30, 15);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 70, 16);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 45, 17);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 29, 18);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 12, 19);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 25, 20);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 62, 21);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 73, 22);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 6, 23);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 11, 24);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 1, 25);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 53, 26);
INSERT INTO line_stop (line_id, stop_id, line_order) VALUES (5, 47, 27);

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

INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('22', '2015-04-02 06:45:00', '2015-04-02 08:56:21', '77', '64', '5.55');
INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('25', '2015-04-03 16:45:00', '2015-04-03 18:56:21', '14', '29', '3.33');
INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('23', '2015-04-03 05:42:12', '2015-04-03 07:22:56', '42', '44', '7.47');
INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('21', '2015-04-12 12:45:01', '2015-04-12 12:56:21', '37', '39', '2.99');
INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('10', '2015-04-22 17:47:47', '2015-04-22 18:22:22', '28', '12', '8.33');
INSERT INTO trip (rider_id, entry_datetime, exit_datetime, entry_stop, exit_stop, cost) VALUES ('22', '2015-04-23 23:45:00', '2015-04-24 00:56:21', '10', '36', '3.88');
