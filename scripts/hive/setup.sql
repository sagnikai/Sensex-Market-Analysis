-download hivexmlserde-1.0.0.0.jar
add jar /home/cloudera/Desktop/hivexmlserde-1.0.0.0.jar


CREATE EXTERNAL TABLE xml_data
(Title string,
Author string,
Price float)
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
with serdeproperties(
"column.xpath.TITLE"="/BOOK/TITLE/text()",
"column.xpath.AUTHOR"="/BOOK/AUTHOR/text()",
"column.xpath.PRICE"="/BOOK/PRICE/text()")
stored as inputformat 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
outputformat 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
tblproperties("xmlinput.start"="<BOOK>","xmlinput.end"="</BOOK>");


LOAD DATA LOCAL INPATH 'xmldata.txt' INTO TABLE xml_data;

select * from xml_data;