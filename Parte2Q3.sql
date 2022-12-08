-- Q3 Parte 2

USE Chinook;

-- 1. Empregados devem ter no min ́ımo 18 anos
-- 2. O email do empregado e cliente deve contener ’@’ e ’.’
-- 3. O telefono do empregado e cliente devex comencar com ’+’

DROP PROCEDURE p_insert_employee;

CREATE PROCEDURE p_insert_employee(
    `EmployeeId` int(11),
    `LastName` varchar(20),
    `FirstName` varchar(20),
    `Title` varchar(30),
    `ReportsTo` int(11),
    `BirthDate` datetime,
    `HireDate` datetime,
    `Address` varchar(70),
    `City` varchar(40),
    `State` varchar(40),
    `Country` varchar(40),
    `PostalCode` varchar(10),
    `Phone` varchar(24),
    `Fax` varchar(24),
    `Email` varchar(60))
BEGIN

    IF Email LIKE '%_@%_.__%'
        AND TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) > 18
        AND Phone LIKE '_+_%'
    THEN
        INSERT INTO Employee (EmployeeId, LastName, FirstName,
                              Title, ReportsTo, BirthDate, HireDate, Address, City,
                              State, Country, PostalCode, Phone, Fax, Email)
        VALUES (EmployeeId, LastName, FirstName, Title, ReportsTo, BirthDate,
                HireDate, Address, City, State, Country, PostalCode,
                Phone, Fax, Email);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Incorrect data';
    END IF;

end;

DROP PROCEDURE p_insert_customer;

CREATE PROCEDURE p_insert_customer(
    `FirstName` varchar(40),
    `LastName` varchar(20),
    `Company` varchar(80),
    `Address` varchar(70),
    `City` varchar(40),
    `State` varchar(40),
    `Country` varchar(40),
    `PostalCode` varchar(10),
    `Phone` varchar(24),
    `Fax` varchar(24),
    `Email` varchar(60),
    `SupportRepId` int(11),
    `CustomerID` int(11)
)
BEGIN
    IF Email LIKE '%_@%_.__%' AND Phone LIKE '_+_%'
    THEN
        INSERT INTO Customer(CustomerID, SupportRepId, Email, Fax, Phone, PostalCode,
                             Country, State, City, Address, Company, LastName, FirstName)
        VALUES (CustomerID, SupportRepId, Email, Fax, Phone, PostalCode,
                Country, State, City, Address, Company, LastName, FirstName);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Incorrect data';
    end if;
end;

-- Testes

SELECT *
FROM Employee;
CALL p_insert_employee(2016, 'Juan', 'Garcia', 'a', 1, '2020/2/18', '2010/2/18', 'a', 'a', 'a', 'a', 'a',
                       ' + 12 2131 12312', 'a', 'asasa@asdads.com');

CALL p_insert_employee(2016, 'Juan', 'Garcia', 'a', 1, '2000/2/18', '2010/2/18', 'a', 'a', 'a', 'a', 'a',
                       ' + 12 2131 12312', 'a', 'asasa@asdads.com');

CALL p_insert_customer(a, 'Juan', 'Garcia', null, 'a', 'a', null, null, 12312, '+1 12121 121', null, 'asasaasd.com', 3);

SELECT * FROM Customer;
CALL p_insert_customer( 'Juan', 'Garcia', null, 'C/Ronda 2', 'Malaga', null, 'Spain', 29340, ' +34 611 11 11 11',
                       null, 'jasd.com', 3, 101);
CALL p_insert_customer( 'Juan', 'Garcia', null, 'C/Ronda 2', 'Malaga', null, 'Spain', 29340, ' +34 611 11 11 11',
                       null, 'asjdajsd@jasd.com', 3, 101);