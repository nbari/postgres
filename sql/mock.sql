-- Connect to the mock database using psql:
-- psql -h localhost -U postgres -d mock -f mock.sql

-- Create the mock database (if it doesn't already exist)
CREATE DATABASE mock;

-- Switch to the mock database (execute this only if you're not already connected)
\c mock;

-- Create the sms table
DROP TABLE IF EXISTS sms;
CREATE TABLE sms (
    id serial PRIMARY KEY,
    sms text NOT NULL,
    cdate timestamptz
);

-- Insert sample data using generate_series
INSERT INTO sms (sms, cdate)
SELECT
    'Foo ' || EXTRACT(MINUTE FROM time_hour) AS sms,
    time_hour AS cdate
FROM
    generate_series(
        NOW() - INTERVAL '5 minutes',
        NOW(),
        INTERVAL '1 minute'            -- Step interval
    ) AS time_series(time_hour);
