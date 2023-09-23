
SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS shop;

USE shop;

CREATE TABLE SalesPeople (
    Snum INT,
    S_name VARCHAR(50),
    City VARCHAR(50),
    Comm INT
);

INSERT INTO SalesPeople (Snum, S_name, City, Comm)
VALUES
    (1001, 'Peel', 'London', 12),
    (1002, 'Serres', 'San Jose', 13),
    (1004, 'Motika', 'London', 11),
    (1007, 'Rifkin', 'Barcelona', 15),
    (1003, 'Axelrod', 'New York', 10);

-- Select all records from the SalesPeople table
SELECT * FROM SalesPeople;

-- Create the Customers table
CREATE TABLE Customers (
    Cnum INT PRIMARY KEY,
    Cname VARCHAR(50),
    City VARCHAR(50) NOT NULL,
    Snum INT,
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);


INSERT INTO Customers (Cnum, Cname, City, Snum)
VALUES
    (2001, 'Hoffman', 'London', 1001),
    (2002, 'Giovanni', 'Rome', 1003),
    (2003, 'Liu', 'Sanjose', 1002),
    (2004, 'Grass', 'Berlin', 1002),
    (2006, 'Clemens', 'London', 1001),
    (2008, 'Cisneros', 'Sanjose', 1007),
    (2007, 'Pereira', 'Rome', 1004);

CREATE TABLE Orders (
    Onum INT PRIMARY KEY,
    Amt DECIMAL(10, 2),
    Odate DATE,
    Cnum INT,
    Snum INT,
    FOREIGN KEY (Cnum) REFERENCES Customers(Cnum),
    FOREIGN KEY (Snum) REFERENCES SalesPeople(Snum)
);

INSERT INTO Orders (Onum, Amt, Odate, Cnum, Snum)
VALUES
    (3001, 18.69, '1990-03-10', 2008, 1007),
    (3003, 767.19, '1990-03-10', 2001, 1001),
    (3002, 1900.10, '1990-03-10', 2007, 1004),
    (3005, 5160.45, '1990-03-10', 2003, 1002),
    (3006, 1098.16, '1990-03-10', 2008, 1007),
    (3009, 1713.23, '1990-04-10', 2002, 1003),
    (3007, 75.75, '1990-04-10', 2004, 1002),
    (3008, 4273.00, '1990-05-10', 2006, 1001),
    (3010, 1309.95, '1990-06-10', 2004, 1002),
    (3011, 9891.88, '1990-06-10', 2006, 1001);

SELECT COUNT(*) AS "Count"
FROM SalesPeople
WHERE S_name LIKE 'A%';

SELECT S.Snum, S.S_name
FROM SalesPeople S
WHERE NOT EXISTS (
    SELECT O.Cnum
    FROM Orders O
    WHERE O.Snum = S.Snum
    AND O.Amt <= 2000
);


SELECT COUNT(*) AS "Count"
FROM SalesPeople
WHERE City = 'New York';


SELECT City, COUNT(*) AS "Count"
FROM SalesPeople
WHERE City IN ('London', 'Paris')
GROUP BY City;


SELECT S.Snum, S.S_name, COUNT(O.Onum) AS "Number of Orders"
FROM SalesPeople S
LEFT JOIN Orders O ON S.Snum = O.Snum
GROUP BY S.Snum, S.S_name
ORDER BY S.Snum;

