# Q4
USE information_schema;
select *  FROM information_schema.TABLE_CONSTRAINTS where TABLE_SCHEMA='Chinook' and CONSTRAINT_NAME='PRIMARY';

SELECT CONCAT(
    'CREATE TABLE ',
    t2.table_name,
    ' ( ',
    attrs,
    IF(primary_key IS NOT NULL, CONCAT(', PRIMARY KEY(',  primary_key, ')'), ''), 
    ' );'
) AS '' FROM (
        SELECT GROUP_CONCAT(column_name) AS attrs, table_name FROM (
            SELECT CONCAT(
                ' ',
                COLUMN_NAME , 
                ' ', 
                DATA_TYPE,
                IF(DATA_TYPE = 'varchar', CONCAT('(',CHARACTER_MAXIMUM_LENGTH, ')'), ''),
                ' ',
                IF(IS_NULLABLE = 'No', '', 'NOT NULL')
            ) AS column_name,
            k.TABLE_NAME AS table_name
            FROM COLUMNS k  WHERE k.TABLE_SCHEMA = 'Chinook'

        ) AS t1 GROUP BY table_name
    ) AS t2 INNER JOIN (
                SELECT 
                    GROUP_CONCAT( COLUMN_NAME) AS primary_key,
                    tc.TABLE_NAME AS table_name
                FROM TABLE_CONSTRAINTS tc
                INNER JOIN KEY_COLUMN_USAGE k ON tc.CONSTRAINT_NAME = k.CONSTRAINT_NAME AND tc.table_name = k.table_name
                WHERE k.CONSTRAINT_SCHEMA = 'Chinook' AND tc.TABLE_SCHEMA = 'Chinook' AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
                GROUP BY tc.table_name
            ) AS t3 ON t2.table_name = t3.table_name;


SELECT CONCAT(
    'ALTER TABLE ', 
    tc.TABLE_NAME,
    ' ADD CONSTRAINT ',
    tc.CONSTRAINT_NAME,
    ' FOREIGN KEY (', 
    COLUMN_NAME,
    ') REFERENCES ', 
    REFERENCED_TABLE_NAME, 
    ' (', 
    REFERENCED_COLUMN_NAME,
    ');'
) as ''
FROM TABLE_CONSTRAINTS tc
INNER JOIN KEY_COLUMN_USAGE k ON tc.CONSTRAINT_NAME = k.CONSTRAINT_NAME
WHERE k.CONSTRAINT_SCHEMA = 'Chinook' AND tc.TABLE_SCHEMA = 'Chinook' AND tc.CONSTRAINT_TYPE = 'FOREIGN KEY';

