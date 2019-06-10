-- XML Data Processing with Pig
-- This script demonstrates XML parsing using Piggybank XMLLoader

-- Register Piggybank JAR for XML processing
REGISTER piggybank-0.15.0.jar;

-- Load XML data using XMLLoader
-- The 'BOOK' parameter specifies the XML tag to parse
A = LOAD 'xml_data.txt' USING org.apache.pig.piggybank.storage.XMLLoader('BOOK') AS (x:chararray);

-- Define XPath UDF for extracting XML elements
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();

-- Extract TITLE and AUTHOR from XML using XPath
B = FOREACH A GENERATE 
    XPath(x,'BOOK/TITLE') AS title,
    XPath(x,'BOOK/AUTHOR') AS author;

-- Display results
DUMP B;

-- Store processed data to output directory
STORE B INTO 'output/' USING PigStorage(',');
