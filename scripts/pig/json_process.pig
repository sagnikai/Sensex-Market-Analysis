-- JSON Data Processing with Hive
-- This script demonstrates JSON SerDe usage for processing JSON data

-- Create table with JSON SerDe
CREATE TABLE json_serde(
    id string,
    name string,
    price double,
    author struct<name:string,surname:string>)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe';

-- Add JSON SerDe JAR file
ADD JAR /home/cloudera/json-serde-1.3.7-jar-with-dependencies.jar;

-- Load JSON data from local file
LOAD DATA LOCAL INPATH '/home/cloudera/jsondata.txt' INTO TABLE json_serde;

-- Query JSON data
SELECT * FROM json_serde;

-- Describe table structure
DESCRIBE json_serde;

-- Access nested struct fields
SELECT id, name, price, author.name, author.surname FROM json_serde;
