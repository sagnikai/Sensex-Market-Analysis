-- Employee Data Processing with Pig
-- This script demonstrates various Hive operations for employee data analysis

-- Create external table for employee data
CREATE EXTERNAL TABLE employee(
    id int,
    name string,
    salary bigint,
    dept string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- Load employee data from local file system
LOAD DATA LOCAL INPATH '/home/cloudera/employees.txt' INTO TABLE employee;

-- Basic queries
SELECT * FROM employee;
SELECT * FROM employee WHERE dept='Oracle';
SELECT * FROM employee ORDER BY dept;
SELECT MAX(salary) FROM employee;
SELECT dept FROM employee GROUP BY dept;

-- HIVE PARTITIONING
-- Create partitioned table for better query performance
CREATE EXTERNAL TABLE employee_p(
    id int,
    name string,
    salary bigint)
PARTITIONED BY (dept string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- Insert data with dynamic partitioning
INSERT INTO employee_p PARTITION (dept) SELECT * FROM employee;

-- Enable dynamic partitioning
SET hive.exec.dynamic.partition.mode=nonstrict;

-- View partitions
SHOW PARTITIONS employee_p;

-- Check partition data in HDFS
!hdfs dfs -ls /user/hive/warehouse/aspire.db/employee_p/dept=SAP/
!hdfs dfs -cat /user/hive/warehouse/aspire.db/employee_p/dept=SAP/000000_0

-- Load new partition data
LOAD DATA LOCAL INPATH '/home/cloudera/employee1.txt' INTO TABLE employee_p PARTITION(dept='Oracle');

-- HIVE BUCKETING
-- Create bucketed table for efficient sampling and joins
CREATE TABLE employee_b(
    id int,
    name string,
    salary double)
CLUSTERED BY (id) INTO 3 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- Load data into bucketed table
LOAD DATA LOCAL INPATH '/home/cloudera/employees.txt' INTO TABLE employee_b;

SELECT * FROM employee_b;

-- Enable bucketing
SET hive.enforce.bucketing=true;
SET mapred.reduce.tasks=3;

-- COMBINED PARTITIONING AND BUCKETING
-- Create table with both partitions and buckets
CREATE TABLE weblog(
    user_id int,
    url string,
    source_ip string)
PARTITIONED BY (dt string)
CLUSTERED BY (user_id) INTO 96 BUCKETS
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

-- Export query results to HDFS
INSERT OVERWRITE DIRECTORY '/user/cloudera/employee'
SELECT * FROM employee;
