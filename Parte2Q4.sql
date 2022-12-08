-- Q2
USE Chinook;

DROP TRIGGER IF EXISTS invoiceLineInsert;
CREATE TRIGGER invoiceLineInsert
    AFTER INSERT
    ON InvoiceLine
    FOR EACH row
BEGIN
    UPDATE Invoice SET Total = Total + (NEW.UnitPrice * NEW.Quantity) WHERE NEW.InvoiceId = InvoiceId;
END;

DROP TRIGGER IF EXISTS invoiceLineDelete;

delimiter //

CREATE TRIGGER invoiceLineDelete
    AFTER DELETE
    ON InvoiceLine
    FOR EACH row
BEGIN
    UPDATE Invoice SET Total = Total - (OLD.UnitPrice * OLD.Quantity) WHERE OLD.InvoiceId = InvoiceId;
END;

DROP TRIGGER IF EXISTS invoiceLineUpdate;
CREATE TRIGGER invoiceLineUpdate
    AFTER UPDATE
    ON InvoiceLine
    FOR EACH row
BEGIN
    UPDATE Invoice
    SET Total = Total - (OLD.UnitPrice * OLD.Quantity) + (NEW.UnitPrice * NEW.Quantity)
    WHERE NEW.InvoiceId = InvoiceId;
END;