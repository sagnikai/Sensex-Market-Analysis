# Big Data Analytics Framework for Sensex Market Analysis

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Abstract

This repository presents a comprehensive framework for processing and analyzing large-scale financial data, specifically targeting Sensex market trends. The project leverages the Hadoop ecosystem to perform distributed data processing, ETL (Extract, Transform, Load) operations, and custom analytical computations. This work demonstrates the application of Big Data technologies to financial market analysis.

## Table of Contents

1. [Introduction](#introduction)
2. [System Architecture](#system-architecture)
3. [Implementation](#implementation)
4. [Directory Structure](#directory-structure)
5. [Prerequisites](#prerequisites)
6. [Installation and Setup](#installation-and-setup)
7. [Usage](#usage)
8. [Results](#results)
9. [Contributing](#contributing)
10. [License](#license)
11. [Citation](#citation)
12. [References](#references)

## Introduction

Financial market analysis requires processing vast amounts of data efficiently. This project implements a scalable Big Data analytics framework using the Hadoop ecosystem to analyze Sensex market data. The framework demonstrates:

- Distributed data processing using MapReduce paradigm
- ETL pipelines for structured and semi-structured data
- Custom analytics through User-Defined Functions (UDFs)
- Data warehousing and querying capabilities

## System Architecture

The framework consists of three primary layers:

### 1. Data Ingestion Layer
- **Apache Sqoop**: Automated pipelines for importing structured financial data from RDBMS to HDFS
- **Log Processing**: Parsing and ingestion of semi-structured web server logs

### 2. Processing Layer
- **Apache Pig**: Data transformation scripts for JSON and XML parsing
- **Apache Hive**: SQL-like querying interface for data warehousing
- **MapReduce**: Custom Java implementations for distributed computation

### 3. Analytics Layer
- **Custom UDFs**: Java-based User Defined Functions for encryption and data processing
- **Statistical Analysis**: Frequency analysis and pattern recognition

## Implementation

### MapReduce Programs

**WordCount.java**: Classic MapReduce implementation for text analysis
- Mapper: Tokenizes input text and emits (word, 1) pairs
- Reducer: Aggregates counts for each word
- Application: Frequency analysis of market reports

**MyUDF.java**: Custom Pig UDF for data encryption
- Implements AES encryption for sensitive financial data
- Extends Pig's EvalFunc for seamless integration
- Includes comprehensive error handling

### Data Processing Scripts

**Hive Scripts**: SQL-like queries for structured data analysis
- XML data processing using custom SerDe
- Partitioning and bucketing for query optimization
- Aggregation and analytical queries

**Pig Scripts**: Data transformation workflows
- JSON parsing with JsonSerDe
- XML processing with Piggybank XMLLoader
- Employee data analysis with partitioning

**Sqoop Commands**: Database integration
- Import/export between RDBMS and HDFS
- Support for various file formats (TextFile, SequenceFile, Avro)
- Direct Hive table population

## Directory Structure

```
.
├── data/                   # Sample datasets
│   ├── salary_pigdata.txt  # Employee salary data
│   ├── sampledata.json     # JSON sample data
│   ├── STOCK.txt           # Sensex stock market data
│   ├── testdata.txt        # Test dataset
│   ├── Webdata.log         # Web server logs
│   └── xml_sample.xml      # XML sample data
├── docs/                   # Project documentation
├── scripts/                # Processing scripts
│   ├── hive/              # Hive SQL scripts
│   │   └── setup.sql      # XML data processing
│   ├── pig/               # Pig Latin scripts
│   │   ├── employee_process.pig
│   │   ├── json_process.pig
│   │   └── xml_processing.pig
│   └── sqoop/             # Sqoop commands
│       └── commands.sh    # Import/export scripts
├── src/                   # Java source code
│   ├── MyUDF.java         # Custom Pig UDF
│   └── WordCount.java     # MapReduce implementation
├── CITATION.cff           # Citation information
├── CONTRIBUTING.md        # Contribution guidelines
├── LICENSE                # MIT License
└── README.md              # This file
```

## Prerequisites

- **Hadoop**: Version 2.x or 3.x
- **Apache Pig**: Version 0.12.0 or higher
- **Apache Hive**: Version 1.x or higher
- **Apache Sqoop**: Version 1.4.x
- **Java**: JDK 1.8 or higher
- **MySQL**: For Sqoop database operations

## Installation and Setup

### 1. Hadoop Configuration

Ensure Hadoop is properly configured with HDFS and YARN:

```bash
# Start Hadoop services
start-dfs.sh
start-yarn.sh
```

### 2. Compile Java Programs

```bash
# Compile MapReduce program
javac -classpath $(hadoop classpath) src/WordCount.java
jar cf wordcount.jar -C src/ .

# Compile Pig UDF
javac -classpath $(pig classpath) src/MyUDF.java
jar cf myudf.jar -C src/ .
```

### 3. Setup Hive

```bash
# Initialize Hive metastore
schematool -initSchema -dbType derby
```

## Usage

### Running MapReduce Jobs

```bash
# Execute WordCount
hadoop jar wordcount.jar WordCount /input/path /output/path
```

### Executing Pig Scripts

```bash
# Run in local mode
pig -x local scripts/pig/employee_process.pig

# Run on Hadoop cluster
pig scripts/pig/json_process.pig
```

### Running Hive Queries

```bash
# Execute Hive script
hive -f scripts/hive/setup.sql

# Interactive mode
hive
```

### Sqoop Data Transfer

```bash
# Import from MySQL to HDFS
bash scripts/sqoop/commands.sh
```

## Results

The framework successfully demonstrates:

1. **Scalability**: Processes large-scale financial datasets efficiently
2. **Flexibility**: Handles multiple data formats (CSV, JSON, XML, logs)
3. **Performance**: Optimized through partitioning and bucketing strategies
4. **Extensibility**: Custom UDFs enable domain-specific processing

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

If you use this work in your research, please cite:

```bibtex
@software{mukherjee2019sensex,
  author = {Mukherjee, Sagnik},
  title = {Big Data Analytics Framework for Sensex Market Analysis},
  year = {2019},
  url = {https://github.com/sagnikai/Sensex-Market-Analysis}
}
```

Or use the [CITATION.cff](CITATION.cff) file.

## References

1. White, T. (2012). *Hadoop: The Definitive Guide*. O'Reilly Media.
2. Gates, A. (2013). *Programming Pig*. O'Reilly Media.
3. Apache Hadoop Documentation: https://hadoop.apache.org/docs/
4. Apache Pig Documentation: https://pig.apache.org/docs/
5. Apache Hive Documentation: https://hive.apache.org/

---

**Author**: Sagnik Mukherjee  
**Contact**: 52891096+sagnikai@users.noreply.github.com  
**Year**: 2019
