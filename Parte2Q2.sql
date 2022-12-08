-- Q2 Parte 2

-- 1. Empregados devem ter no min ́ımo 18 anos
USE Chinook;
delimiter //

CREATE TRIGGER EmployeeInsert
    BEFORE INSERT
    ON Employee
    FOR EACH row
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.BirthDate, CURDATE()) > 18
    THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Employee must be 18 or older';
    END IF;
END;

delimiter ;

INSERT INTO `Employee` (`EmployeeId`, `LastName`, `FirstName`, `Title`, `BirthDate`, `HireDate`, `Address`, `City`,
                        `State`, `Country`, `PostalCode`, `Phone`, `Fax`, `Email`)
VALUES (2017, N'Adams', N'Andrew', N'General Manager', '2010/2/18', '2002/8/14', N'11120 Jasper Ave NW', N'Edmonton',
        N'AB', N'Canada', N'T5K 2N1', N' +1 (780) 428-9482', N' +1 (780) 428-3457', N'andrew@chinookcorp.com');

delimiter ;

-- 2. O email do empregado e cliente deve contener ’@’ e ’.’
CREATE TRIGGER EmailInsertEmployee
    BEFORE INSERT
    ON Employee
    FOR EACH ROW
BEGIN
    IF NEW.Email NOT LIKE '%_@%_.__%' THEN
        SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '`email` column is not valid';
    END IF;
END ;

CREATE TRIGGER EmailInsertCustumer
    BEFORE INSERT
    ON Customer
    FOR EACH ROW
BEGIN
    IF NEW.Email NOT LIKE '%_@%_.__%' THEN
        SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '`email` column is not valid';
    END IF;
END ;

INSERT INTO `Employee` (`EmployeeId`, `LastName`, `FirstName`, `Title`, `BirthDate`, `HireDate`, `Address`, `City`,
                        `State`, `Country`, `PostalCode`, `Phone`, `Fax`, `Email`)
VALUES (2019, N'Adams', N'Andrew', N'General Manager', '2000/2/18', '2002/8/14', N'11120 Jasper Ave NW', N'Edmonton',
        N'AB', N'Canada', N'T5K 2N1', N'+1 (780) 428-9482', N'+1 (780) 428-3457', N'andrewchinookcorp.com');

--  3.O telefono do empregado e cliente devex comen ̧car com ’+’
CREATE TRIGGER PhoneInsertEmployee
    BEFORE INSERT
    ON Employee
    FOR EACH ROW
BEGIN
    IF NEW.Phone NOT LIKE '%_+_%' THEN
        SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = ' `phone` column is not valid';
    END IF;
END ;

CREATE TRIGGER PhoneInsertCustumer
    BEFORE INSERT
    ON Customer
    FOR EACH ROW
BEGIN
    IF NEW.Phone NOT LIKE '_+_%' THEN
        SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = ' `phone` column is not valid';
    END IF;
END ;

INSERT INTO `Employee` (`EmployeeId`, `LastName`, `FirstName`, `Title`, `BirthDate`, `HireDate`, `Address`, `City`,
                        `State`, `Country`, `PostalCode`, `Phone`, `Fax`, `Email`)
VALUES (2109, N'Adams', N'Andrew', N'General Manager', '1999/2/18', '2002/8/14', N'11120 Jasper Ave NW', N'Edmonton',
        N'AB', N'Canada', N'T5K 2N1', N'1 +(780) 428-9482', N'+1 (780) 428-3457', N'andrewch@inookcorp.com');
