--append

IMPORT Table Data Into HDFS as TextFile
=======================================
sqoop import --connect "jdbc:mysql://localhost:3306/retail_db" \
--username root \
--password cloudera \
--table departments \
--target-dir /user/cloudera/dept2 \
--as-textfile \
-m 2 or --num-mappers 2

--as-sequencefile
--columns department_name
--warehouse-dir "/user/cloudera"        /user/cloudera/departments/jhjh

IMPORT ALL Table Data Into HDFS as TextFile
===========================================
sqoop import --connect "jdbc:mysql://localhost:3306/retail_db" \
--username root \
--password cloudera \
--table customers \
--as-avrodatafile \
--warehouse-dir "/user/cloudera/retail.db" \
--num-mappers 12

--fields-terminated-by '|'
--lines-terminated-by '\n'
--split-by order_id    

IMPORT Directly To HIVE
=======================
sqoop import --connect "jdbc:mysql://localhost:3306/retail_db" \
--username root \
--password cloudera \
--table departments \
--fields-terminated-by '|' \
--lines-terminated-by '\n' \
--hive-home /user/hive/warehouse \
--hive-import \
--hive-database aspirevision \
--hive-table departments_h \
--create-hive-table \
--outdir java_files

EXPORT From HIVE to RDBMS [ create new_dept.txt,put inside HDFS]
=========================
mysql -u root -p (cloudera)

create table employee(id int,name varchar(30),sal decimal(14,2),dept varchar(20));

sqoop export --connect "jdbc:mysql://localhost:3306/retail_db" \
--username root \
--password cloudera \
--table employee \
--export-dir '/user/hive/warehouse/aspirevision.db/employee_data/employees.txt' \
--input-fields-terminated-by ',' \
--input-lines-terminated-by '\n' \
--num-mappers 2 \
--outdir java_files

mysql -u root -p (cloudera)

use retail_db;

select * from employee;