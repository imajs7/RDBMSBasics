CREATE DATABASE travelonthego;
USE travelonthego;

CREATE TABLE passenger(
	passenger_id INT AUTO_INCREMENT PRIMARY KEY,
	passenger_name VARCHAR(50),
	category VARCHAR(20),
	gender VARCHAR(1),
	boarding_city VARCHAR(50),
	destination_city VARCHAR(50),
	distance INT,
	bus_type VARCHAR(20)
);

CREATE TABLE price(
	price_id INT AUTO_INCREMENT PRIMARY KEY,
	bus_type varchar(20),
	distance int,
	price int
);

INSERT INTO
	passenger (passenger_name, category, gender, boarding_city, destination_city, distance, bus_type)
VALUES
	("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper"),
    ("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sleeper"),
    ("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper"),
	("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper"),
	("Udit", "Non-AC", "M", "Trivandrum", "Panaji", 1000, "Sleeper"),
	("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting"),
	("Hemant", "Non-AC", "M", "Panaji", "Mumbai", 700, "Sleeper"),
	("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting"),
	("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");

INSERT INTO
	price (bus_type, distance, price)
VALUES
	("Sleeper", 350, 770),
	("Sleeper", 500, 1100),
    ("Sleeper", 600, 1320),
	("Sleeper", 700, 1540),
	("Sleeper", 1000, 2200),
	("Sleeper", 1200, 2640),
	("Sleeper", 1500, 2700),
	("Sitting", 500, 620),
	("Sitting", 600, 744),
	("Sitting", 700, 868),
	("Sitting", 1000, 1240),
	("Sitting", 1200, 1488),
	("Sitting", 1500, 1860);
 
 /* question 3 
 How many females and how many male passengers travelled for a 
 minimum distance of 600 KM s?
 */
SELECT
	gender, count(*) AS	count
FROM 
	passenger
WHERE 
	distance >= 600
GROUP BY
	gender;
    
/* question 4 
Find the minimum ticket price for Sleeper Bus.
*/
SELECT
	CONCAT('₹', min(price)) AS 'Min price of sleeper'
FROM
	price
WHERE
	bus_type = 'sleeper';
    
/* question 5 
Select passenger names whose names start with character 'S'
*/
SELECT
	passenger_name AS Name
FROM
	passenger
WHERE
	passenger_name LIKE 's%';
    
/* question 6 
Calculate price charged for each passenger displaying Passenger name, 
Boarding City, Destination City, Bus_Type, Price in the output
*/
SELECT
	x.passenger_name AS Name, x.boarding_city AS 'Boarding At', 
    x.destination_city AS Destination, x.bus_type AS 'Bus Type', 
    CONCAT('₹', y.price) AS 'Price Charged'
FROM
	passenger x, price y
WHERE
	x.bus_type = y.bus_type AND x.distance = y.distance;
    
/* question 7 
What are the passenger name/s and his/her ticket price who travelled 
in the Sitting bus for a distance of 1000 KM s
*/
SELECT
	passenger_name AS Name, CONCAT('₹', price) AS 'Ticket Price'
FROM
	passenger t1
INNER JOIN
	price t2
ON
	t1.bus_type = t2.bus_type AND t1.distance = t2.distance
WHERE
    t1.distance = 1000 AND t1.bus_type = 'sitting';
    
/* question 8 
What will be the Sitting and Sleeper bus charge for Pallavi to travel from 
Bangalore to Panaji?
*/
SELECT
	bus_type AS 'Bus Type', CONCAT('₹', price) AS 'Price (Blr to Panaji)'
FROM
	price
WHERE
	distance = 600;
    
/* question 9 
List the distances from the "Passenger" table which are unique 
(non-repeated distances) in descending order.
*/
SELECT
	DISTINCT( CONCAT(distance, ' km')) AS 'Distances'
FROM
	passenger
ORDER BY
	distance DESC;
    
/* question 10 
Display the passenger name and percentage of distance travelled by that passenger 
from the total distance travelled by all passengers without using user variables
*/
SELECT
	passenger_name AS Name, CONCAT(distance, ' km') AS 'Distance', 
    CONCAT( ROUND(distance * 100 / (SELECT sum(distance) FROM passenger), 2), '%') AS 'Percentage'
FROM
	passenger;
    
/* question 11 
Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
*/
SELECT
	CONCAT(distance, ' km') AS Distance, CONCAT('₹', price) AS Price,
CASE
    WHEN price > 1000 THEN 'Expensive'
    WHEN price > 500 AND price <= 1000 THEN 'Average Cost'
    ELSE 'Cheap'
END AS Category
FROM 
	price;
