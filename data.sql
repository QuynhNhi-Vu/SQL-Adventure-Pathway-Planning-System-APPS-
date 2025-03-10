DROP TABLE IF EXISTS `PlannedLocationSelection` ;
DROP TABLE IF EXISTS `Waypoint` ;
DROP TABLE IF EXISTS `ViewingInstructions` ;
DROP TABLE IF EXISTS `PlannedRouteSelection` ;
DROP TABLE IF EXISTS `RouteStartTime` ;
DROP TABLE IF EXISTS `Route` ;
DROP TABLE IF EXISTS `Location` ;
DROP TABLE IF EXISTS `Plan` ;
DROP TABLE IF EXISTS `PointOfInterest` ;
DROP TABLE IF EXISTS `Person` ;

-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------

CREATE TABLE `Location` (
  `locationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `description` TEXT NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PointOfInterest`
-- -----------------------------------------------------

CREATE TABLE `PointOfInterest` (
  `pointOfInterestID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `mapReference` VARCHAR(2048) NOT NULL,
  `samplePhoto` BLOB NOT NULL,
  `description` TEXT NOT NULL,
  `typeOfPOI` VARCHAR(20) NOT NULL,
  `animalDescription` TEXT NULL DEFAULT NULL,
  `animalClassification` VARCHAR(20) NULL DEFAULT NULL,
  `animalEndangeredStatus` VARCHAR(20) NULL DEFAULT NULL,
  `plantDescription` TEXT NULL DEFAULT NULL,
  `plantIsPoisonous` TINYINT NULL DEFAULT NULL,
  `plantIsEdible` TINYINT NULL DEFAULT NULL,
  `plantAllergyNote` TEXT NULL DEFAULT NULL,
  `shopName` VARCHAR(500) NULL DEFAULT NULL,
  `shopSecondMapReference` VARCHAR(2048) NULL DEFAULT NULL,
  `shopBargainBarcode` BLOB NULL DEFAULT NULL,
  `placeSamplePhoto` BLOB NULL DEFAULT NULL,
  `placeDescription` TEXT NULL DEFAULT NULL,
  `placeEstimatedExistanceInYears` BIGINT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ViewingInstructions`
-- -----------------------------------------------------

CREATE TABLE `ViewingInstructions` (
  `locationID` INT UNSIGNED NOT NULL,
  `pointOfInterestID` INT UNSIGNED NOT NULL,
  `instructionDetails` TEXT NOT NULL,
  PRIMARY KEY (`locationID`, `pointOfInterestID`),
  CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`pointOfInterestID`) REFERENCES `PointOfInterest` (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Route`
-- -----------------------------------------------------

CREATE TABLE `Route` (
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estimatedWalkingTime` SMALLINT UNSIGNED NOT NULL COMMENT 'in minutes',
  `routeName` VARCHAR(200) NOT NULL,
  `routeDescription` TEXT NOT NULL,
  `startsAt` INT UNSIGNED NOT NULL,
  `endsAt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`routeID`),
  CONSTRAINT FOREIGN KEY (`startsAt`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`endsAt`) REFERENCES `Location` (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------

CREATE TABLE `Person` (
    -- TODO: complete the Person definition
	`personID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(200) NOT NULL,
    `password` VARCHAR(64) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`personID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Plan`
-- -----------------------------------------------------

CREATE TABLE `Plan` (
    -- TODO: complete the Plan definition
	`planID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `planName` VARCHAR(100) NOT NULL,
    `whenCreated` DATETIME NOT NULL,
    `whenLastUpdated` DATETIME NOT NULL,
    `isCreatedBy` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`planID`),
    CONSTRAINT FOREIGN KEY (`isCreatedBy`) REFERENCES `Person` (`personID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedLocationSelection`
-- -----------------------------------------------------

CREATE TABLE `PlannedLocationSelection` (
  -- TODO: complete the PlannedLocationSelection definition
	`planID` INT UNSIGNED NOT NULL,
    `locationID` INT UNSIGNED NOT NULL,
    `dateSelected` DATE NOT NULL,
    `timeSelected` TIME NOT NULL,
    PRIMARY KEY (`planID`, `locationID`),
    CONSTRAINT FOREIGN KEY (`planID`) REFERENCES `Plan`(`planID`),
    CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location`(`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedRouteSelection`
-- -----------------------------------------------------

CREATE TABLE `PlannedRouteSelection` (
    -- TODO: complete the PlannedRouteSelection definition
	`planID` INT UNSIGNED NOT NULL,
    `routeID` INT UNSIGNED NOT NULL,
    `dateSelected` DATE NOT NULL,
    `timeSelected` TIME NOT NULL,
    PRIMARY KEY (`planID`, `routeID`),
    CONSTRAINT FOREIGN KEY (`planID`) REFERENCES `Plan`(`planID`),
    CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route`(`routeID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `RouteStartTime`
-- -----------------------------------------------------

CREATE TABLE `RouteStartTime` (
    -- TODO: complete the RouteStartTime definition
	`routeID` INT UNSIGNED NOT NULL,
    `dayAndTimeStart` CHAR(8) NOT NULL,
    PRIMARY KEY (`routeID`, `dayAndTimeStart`),
    CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route`(`routeID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Waypoint`
-- -----------------------------------------------------

CREATE TABLE `Waypoint` (
    -- TODO: complete the Waypoint definition
    `routeID` INT UNSIGNED NOT NULL,
    `locationID` INT UNSIGNED NOT NULL,
    `relativeArrivalTime` SMALLINT UNSIGNED NOT NULL COMMENT 'in minutes',
    `relativeDepartureTime` SMALLINT UNSIGNED NOT NULL COMMENT 'in minutes',
    PRIMARY KEY (`routeID`, `locationID`),
    CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route`(`routeID`),
    CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location`(`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

-- Location data insert statements
INSERT INTO `Location` (`name`, `description`, `image`) VALUES
('Sydney Opera House', 'Iconic Sydney landmark.', 0x00),
('Bondi Beach', 'Famous beach in Sydney.', 0x00),
('Harbour Bridge', 'Famous bridge in Sydney.', 0x00),
('Botanic Garden', 'Australia Natural Masterpiece.', 0x00),
('Central Station', 'Heritage-listed Railway Station.', 0x00);

-- PointOfInterest data insert statements
INSERT INTO `PointOfInterest` (`name`, `mapReference`, `samplePhoto`, `description`, `typeOfPOI`, 
                               `animalDescription`, `animalClassification`, `animalEndangeredStatus`,
                               `plantDescription`, `plantIsPoisonous`, `plantIsEdible`, `plantAllergyNote`,
                               `shopName`, `shopSecondMapReference`, `shopBargainBarcode`,
                               `placeSamplePhoto`, `placeDescription`, `placeEstimatedExistanceInYears`) VALUES
('Koala Habitat', 'https://maps.google.com/?q=Koala+Habitat', 0x00, 
 'A natural habitat of Koalas.', 'Animal', 'Grey furry mammal native to Australia', 
 'Non-Venomous', 'Endangered', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

('Eucalyptus Tree', 'https://maps.google.com/?q=Eucalyptus+Tree', 0x00, 
 'Common tree known for its fragrant leaves.', 'Plant', NULL, NULL, NULL, 
 'Eucalyptus leaves may cause mild allergic reactions in some people.', 
 0, 1, 'May cause allergies.', NULL, NULL, NULL, NULL, NULL, NULL),

('Sydney Souvenir Shop', 'https://maps.google.com/?q=Sydney+Souvenir+Shop', 0x00, 
 'A shop selling Sydney memorabilia and souvenirs.', 'Store', NULL, NULL, NULL, 
 NULL, NULL, NULL, NULL, 'Souvenir Shop', 'https://maps.google.com/?q=Alternate+Shop+Location', 
 0x00, NULL, NULL, NULL),

('Sydney Opera House', 'https://maps.google.com/?q=Sydney+Opera+House', 0x00, 
 'A UNESCO World Heritage Site and iconic landmark.', 'Place', NULL, NULL, NULL, 
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
 0x00, 'Built in 1973, this is one of the 20th century\'s most famous and distinctive buildings.', 
 51),
 
('Rare Bird Sanctuary', 'https://maps.google.com/?q=Bird+Sanctuary', 0x00, 'Sanctuary for rare birds.', 'Animal', NULL, NULL, NULL, 
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ViewingInstructions data insert statements
INSERT INTO `ViewingInstructions` (`locationID`, `pointOfInterestID`, `instructionDetails`) VALUES
(1, 1, 'Observe the Koalas from the designated viewing area. Please maintain a safe distance.'),
(2, 2, 'The Eucalyptus trees are located along the main trail. Be cautious of allergies.'),
(3, 3, 'Visit the Sydney Souvenir Shop to collect unique gifts and memorabilia.'),
(1, 4, 'The Sydney Opera House is best viewed from the north side for a full frontal view.');

-- Route data insert statements
INSERT INTO `Route` (`estimatedWalkingTime`, `routeName`, `routeDescription`, `startsAt`, `endsAt`) VALUES
(120, 'Opera House to Bondi', 'Scenic route from Sydney Opera House to Bondi Beach.', 1, 2),
(15, 'Bridge to Opera House', 'Route from Sydney Harbour Bridge to Opera House.', 3, 1),
(60, 'Bondi to Bridge', 'Route from Bondi Beach to Bridge.', 2, 3),
(25, 'Central Station to Bridge', 'Route from Central Station to Sydney Harbour Bridge.', 5, 2),
(30, 'Central Station to Opera House', 'Route from Central Station to Opera House.', 5, 1);

-- Person data insert statements
INSERT INTO `Person` (`name`, `password`, `email`) VALUES
('Callanth Vu', 'securepassword1', 'callanth@gmail.com'),
('James Vuong', 'securepassword2', 'james@gmail.com'),
('Edward Pham', 'securepassword3', 'edward@gmail.com'),
('Lynne Doan', 'securepassword4', 'lynne@gmail.com'),
('Jess Speed', 'securepassword5', 'gjess@gmail.com'),
('Sophie Allen', 'securepassword6', 'sophie@gmail.com');

-- Plan data insert statements
INSERT INTO `Plan` (`planName`, `whenCreated`, `whenLastUpdated`, `isCreatedBy`) VALUES
('Morning Hike', '2024-09-20 07:00:00', '2024-09-20 07:10:00', 1),
('City Tour', '2024-09-21 10:00:00', '2024-09-21 10:30:00', 2),
('Evening Walk', '2024-09-22 18:00:00', '2024-09-22 18:05:00', 3),
('Beach Dawn', '2024-09-23 16:00:00', '2024-09-22 16:05:00', 4),
('Cave Exploration', '2024-09-22 09:00:00', '2024-09-22 09:05:00', 5);

-- PlannedLocationSelection data insert statements
INSERT INTO `PlannedLocationSelection` (`planID`, `locationID`, `dateSelected`, `timeSelected`) VALUES
(1, 1, '2024-09-20', '07:30:00'),
(1, 2, '2024-09-20', '08:30:00'),
(4, 3, '2024-09-21', '11:00:00'),
(2, 5, '2024-09-21', '16:00:00'),
(5, 3, '2024-09-22', '09:00:00');

-- PlannedRouteSelection data insert statements
INSERT INTO `PlannedRouteSelection` (`planID`, `routeID`, `dateSelected`, `timeSelected`) VALUES
(1, 1, '2024-09-20', '07:00:00'),
(2, 2, '2024-09-21', '10:00:00');

-- RouteStartTime data insert statements
INSERT INTO `RouteStartTime` (`routeID`, `dayAndTimeStart`) VALUES
(1, 'mon09:00'),
(1, 'wed14:00'),
(2, 'fri08:30');

-- Waypoint data insert statements
INSERT INTO `Waypoint` (`routeID`, `locationID`, `relativeArrivalTime`, `relativeDepartureTime`) VALUES
(1, 3, 30, 45), -- Sydney Harbour Bridge as a waypoint in the first route
(2, 1, 15, 30), -- Sydney Opera House as a waypoint in the second route
(3, 3, 15, 30),
(4, 2, 15, 30),
(5, 3, 15, 30);
