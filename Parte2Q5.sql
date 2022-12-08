CREATE TABLE sequence
(
    seq_name    varchar(20) unique not null,
    seq_current int unsigned       not null
);

delimiter //
CREATE PROCEDURE currval(IN seq_name_ varchar(20))
BEGIN
    SELECT seq_current FROM sequence WHERE seq_name = seq_name_;
end //

CREATE PROCEDURE nextval(IN seq_name_ varchar(20))
BEGIN
    UPDATE sequence SET seq_current = (@next := seq_current + 1) WHERE seq_name = seq_name_;
end //

CREATE PROCEDURE newSequence(IN seq_name_ varchar(20), IN startWith int)
BEGIN
    INSERT INTO sequence values (seq_name_, startWith);
end //

delimiter //

-- Testes

CALL newSequence('Prueba1', 1);
CALL newSequence('Prueba2', 1);

SELECT *
FROM sequence;

CALL currval('Prueba1');
CALL nextval('Prueba1');
CALL currval('Prueba1');
CALL nextval('Prueba2');
CALL nextval('Prueba2');
CALL nextval('Prueba2');
CALL currval('Prueba2');

SELECT *
FROM sequence;

CALL newSequence('Prueba2');