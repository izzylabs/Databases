DROP TABLE IF EXISTS Dates CASCADE;
CREATE TABLE Dates (
	id serial primary key,
	beginning date NOT NULL CHECK (beginning > '2000-01-01') DEFAULT '2000-01-02',
	finale date NOT NULL CHECK (finale > '2000-01-01') DEFAULT '2000-01-03',
	duration_interval int NOT NULL GENERATED ALWAYS AS (finale - beginning) STORED
);

DROP TABLE IF EXISTS Climbs CASCADE;
CREATE TABLE Climbs (
	id serial primary key,
	date_id int NOT NULL,
	CONSTRAINT fk_climbs
      FOREIGN KEY(date_id) 
	  REFERENCES Dates(id)
);

DROP TABLE IF EXISTS Regions CASCADE;
CREATE TABLE Regions (
	id serial primary key,
	name text NOT NULL DEFAULT 'text' UNIQUE
);

DROP TABLE IF EXISTS Countries CASCADE;
CREATE TABLE Countries (
	id serial primary key,
	name text NOT NULL DEFAULT 'text' UNIQUE,
	region_id int NOT NULL,
	CONSTRAINT fk_countries
      FOREIGN KEY(region_id) 
	  REFERENCES Regions(id)
);

-- Renamed Area into Cities(from logical schema)
DROP TABLE IF EXISTS Cities CASCADE;
CREATE TABLE Cities (
	id serial primary key,
	name text NOT NULL DEFAULT 'text' UNIQUE,
	country_id int NOT NULL,
	CONSTRAINT fk_cities
      FOREIGN KEY(country_id) 
	  REFERENCES Countries(id)
);

DROP TABLE IF EXISTS Mountains CASCADE;
CREATE TABLE Mountains (
	id serial primary key,
	name text NOT NULL DEFAULT 'text' UNIQUE,
	height_cm int NOT NULL UNIQUE CHECK (height_cm > 0) DEFAULT 1,
    height_metres int NOT NULL UNIQUE GENERATED ALWAYS AS (height_cm / 100) STORED CHECK (height_metres > 0),
	country_id int NOT NULL,
	CONSTRAINT fk_mountains
      FOREIGN KEY(country_id) 
	  REFERENCES Countries(id)
);

DROP TABLE IF EXISTS Routes CASCADE;
CREATE TABLE Routes (
	climb_id int NOT NULL,
	mountain_id int NOT NULL,
	CONSTRAINT fk_routes_climbs
      FOREIGN KEY(climb_id) 
	  REFERENCES Climbs(id),
	CONSTRAINT fk_routes_mountains
      FOREIGN KEY(mountain_id) 
	  REFERENCES Mountains(id)
);

DROP TABLE IF EXISTS Climbers CASCADE;
CREATE TABLE Climbers (
	id serial primary key,
	first_name text NOT NULL DEFAULT 'text',
	last_name text NOT NULL DEFAULT 'text',
	gender text CHECK (gender IN ('Male', 'Female')),
	city_id int NOT NULL,
	street text NOT NULL DEFAULT 'text' UNIQUE,
	CONSTRAINT fk_climbers
      FOREIGN KEY(city_id) 
	  REFERENCES Cities(id)
);

-- ClimberClimb renamed into participations(from logical schema)
DROP TABLE IF EXISTS Participations CASCADE;
CREATE TABLE Participations (
	climb_id int NOT NULL,
	climber_id int NOT NULL,
	CONSTRAINT fk_participations_climbs
      FOREIGN KEY(climb_id) 
	  REFERENCES Climbs(id),
	CONSTRAINT fk_participations_climbers
      FOREIGN KEY(climber_id) 
	  REFERENCES Climbers(id)
);

-- Insert data into Dates table
INSERT INTO Dates (beginning, finale) VALUES
('2022-01-10', '2022-01-15'),
('2022-02-05', '2022-02-10'),
('2022-03-20', '2022-03-25');

-- Insert data into Climbs table
INSERT INTO Climbs (date_id) VALUES
(1),
(2),
(3);

-- Insert data into Regions table
INSERT INTO Regions (name) VALUES
('Asia'),
('Europe'),
('North America');

-- Insert data into Countries table
INSERT INTO Countries (name, region_id) VALUES
('Japan', 1),
('France', 2),
('United States', 3);

-- Insert data into Cities table
INSERT INTO Cities (name, country_id) VALUES
('Tokyo', 1),
('Paris', 2),
('New York', 3);

-- Insert data into Mountains table
INSERT INTO Mountains (name, height_cm, country_id) VALUES
('Mount Fuji', 377668, 1),
('Mont Blanc', 481004, 2),
('Denali', 619001, 3);

-- Insert data into Routes table
INSERT INTO Routes (climb_id, mountain_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insert data into Climbers table
INSERT INTO Climbers (first_name, last_name, gender, city_id, street) VALUES
('John', 'Doe', 'Male', 1, '123 Main St'),
('Jane', 'Doe', 'Female', 2, '456 Oak St'),
('Alice', 'Johnson', 'Female', 3, '789 Pine St');

-- Insert data into Participations table
INSERT INTO Participations (climb_id, climber_id) VALUES
(1, 1),
(2, 2),
(3, 3);


ALTER TABLE Dates
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Dates
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climbs
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Climbs
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Regions
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Regions
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Countries
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Countries
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Cities
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Cities
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Mountains
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Mountains
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Routes
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Routes
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climbers
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Climbers
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Participations
ADD COLUMN record_ts date NOT NULL DEFAULT current_date;

UPDATE Participations
SET record_ts = current_date
WHERE record_ts IS NULL;

select * from Dates;
select * from Climbs;
select * from Regions;
select * from Countries;
select * from Cities;
select * from Mountains;
select * from Routes;
select * from Climbers;
select * from Participations;
