# Q1
SELECT DISTINCT
    STATISTICS.TABLE_NAME,
    STATISTICS.INDEX_NAME,
    STATISTICS.COLUMN_NAME
FROM STATISTICS WHERE INDEX_SCHEMA = 'chinook';