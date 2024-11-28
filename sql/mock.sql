-- psql -h localhost -U postgres -d mock -f mock.sql

-- create postgres database
CREATE DATABASE mock;

-- create table
DROP TABLE IF EXISTS sms;
CREATE TABLE sms (
 id serial PRIMARY KEY,
 sms text NOT NULL,
 cdate timestamptz
);


INSERT INTO sms (sms, cdate)
SELECT
    'Foo ' || EXTRACT(MINUTE FROM time_hour) AS name,
    time_hour
FROM
    generate_series(
        NOW() - INTERVAL '5 minutes',
        NOW(),
        INTERVAL '1 minute'
    ) as time_hour;
