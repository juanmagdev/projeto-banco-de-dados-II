# Q2
USE Chinook;
DROP PROCEDURE IF EXISTS deleteIndex;

delimiter //
create procedure deleteIndex(IN table_name_ varchar(255))
begin
    declare finished INTEGER DEFAULT 0;
    declare dropCommand varchar(255);
    declare curDrop cursor for
        SELECT CONCAT('DROP INDEX ', index_name,
            ' ON ', table_schema, '.', table_name, ';')
        FROM information_schema.statistics
        WHERE index_name != 'PRIMARY'
          AND table_name = table_name_
          AND table_schema = 'Chinook';

    declare continue handler
        for not found set finished = 1;

    open curDrop;

    lloop:
    loop
        fetch curDrop into dropCommand;
        IF finished=1 then
            leave lloop;
        end IF;

        set @sdropCommand = dropCommand;

        prepare dropClientUpdateKeyStmt FROM @sdropCommand;

        execute dropClientUpdateKeyStmt;

        deallocate prepare dropClientUpdateKeyStmt;
    end loop;

    close curDrop;
end//
delimiter ;

-- TESTE DO PROCEDURE
CREATE UNIQUE INDEX test1 ON Artist (Name) USING HASH;
CREATE UNIQUE INDEX test2 ON Artist (Name) USING HASH;

SELECT DISTINCT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'Chinook'
  AND TABLE_NAME = 'Artist';

CALL deleteIndex('Artist');

SELECT DISTINCT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'Chinook'
  AND TABLE_NAME = 'Artist';
