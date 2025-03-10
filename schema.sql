-- List each Person (person id, name, and email). Sort the results alphabetically by email.
SELECT personID, name, email
FROM Person
ORDER BY email;

-- List each Person (person id, name, and email). Only show people who have an 'a' or 'A' in their name or have an email starting with 'g'.
SELECT personID, name, email
FROM Person
WHERE name LIKE '%a%' OR name LIKE '%A%' OR email LIKE 'g%';

-- What are the start days and times for each route? List the routeID, routeName, estimatedWalkingTime, and dayAndTimeStart for each start day/time for each route.
SELECT Route.routeID, routeName, estimatedWalkingTime, dayAndTimeStart
FROM Route, RouteStartTime
WHERE Route.routeID = RouteStartTime.routeID;

-- List each Person (person id, name, email) and the number of plans they have stored. Sort the results by number of plans highest to lowest. This query should also include people who have not created any plans yet. Rename the count column to 'numberOfPlans'.
SELECT personID, name, email, COUNT(Plan.planID) AS numberOfPlans
FROM Person
LEFT JOIN Plan ON Person.personID = Plan.isCreatedBy
GROUP BY Person.personID
ORDER BY numberOfPlans DESC;

-- List each PointOfInterest (id, name, typeOfPOI) and the number of locations that are able to view the Point Of Interest. Sort the results from lowest number of locations to highest number of locations. Rename the count column to 'numberOfLocationsViewableFrom'.
SELECT PointOfInterest.pointOfInterestID, name, TypeOfPOI, COUNT(ViewingInstructions.instructionDetails) AS numberOfLocationsViewableFrom
FROM PointOfInterest
LEFT JOIN ViewingInstructions ON PointOfInterest.pointOfInterestID = ViewingInstructions.pointOfInterestID
GROUP BY PointOfInterest.pointOfInterestID
ORDER BY numberOfLocationsViewableFrom ASC;

-- List all the locations (id, name) that do not exist in any routes or waypoints.
SELECT Location.locationID, Location.name
FROM Location
LEFT JOIN Route ON Location.locationID = Route.startsAt OR Location.locationID = Route.endsAt
LEFT JOIN Waypoint ON Location.locationID = Waypoint.locationID
WHERE Route.routeID IS NULL AND Waypoint.routeID IS NULL;

-- List all of the Points of Interest (id, name, typeOfPOI) that are not viewable in any person's plan.
SELECT PointOfInterest.pointOfInterestID, PointOfInterest.name, PointOfInterest.typeOfPOI
FROM PointOfInterest
LEFT JOIN ViewingInstructions ON PointOfInterest.pointOfInterestID = ViewingInstructions.pointOfInterestID
LEFT JOIN PlannedLocationSelection ON ViewingInstructions.locationID = PlannedLocationSelection.locationID
WHERE PlannedLocationSelection.planID IS NULL;

-- Using "union all" to combine all queries into one query, show all the locations (name, id) of a Route of my choice (e.g. where Route.routeID = 5 ... or another routeID of your choice).
SELECT Location.locationID, Location.name, 0 AS arrivalTime
FROM Location
JOIN Route ON Location.locationID = Route.startsAt
WHERE Route.routeID = 5

UNION ALL

SELECT Location.locationID, Location.name, Waypoint.relativeArrivalTime AS arrivalTime
FROM Waypoint
JOIN Location ON Waypoint.locationID = Location.locationID
WHERE Waypoint.routeID = 5

UNION ALL

SELECT Location.locationID, Location.name, Route.estimatedWalkingTime AS arrivalTime
FROM Location
JOIN Route ON Location.locationID = Route.endsAt
WHERE Route.routeID = 5
ORDER BY arrivalTime;



