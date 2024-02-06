# About
This project provides details of the steps taken to clean a very dirty dataset. For this project, SQL (postgreSQL) was used as the primary tool for cleaning the dataset.

## Introduction
Data can be found everywhere around us such that recording these data can be a very challenging process. Different methods and metrics could be utilized when collecting the same type of data thereby leading to errors. Errors found within a dataset could include but not limited to spelling error, duplicates, missing data, inconsistencies in metrics and so forth. Hence, it is the responsibility of anyone working with any type of data to ensure that the dataset is accurate, complete, consistent and trustworthy before beginning any analysis. For the cleaning of this dataset, I will be using SQL within the PostgreSQL database management system.

### About the data
This is a fifa21 messy raw dataset gotten from Kaggle. This dataset comprises of 18979 rows and 77 columns. Each of the columns provides details about the personal and physical information of multiple players. More information about the data set [here](https://www.kaggle.com/datasets/yagunnersya/fifa-21-messy-raw-dataset-for-cleaning-exploring).

### Problem Statement
The goal of this project is to clean this dataset by making it consistent, correct and free from errors. Upon an initial look into this dataset, I discovered the following inconsistencies;
1.	There were lot of special characters within the dataset
2.	Blank columns
3.	Inconsistent use of metrics within some columns
4.	Mismatched data types

### Skills Demonstrated
The skills demonstrated in this project includes the use of GROUPBY, Data Definition Language (DDL), Data Manipulation Language (DML) and CASE statements.

### Data transformation
Excel was used for initial data exploration to get an overall insight on what the data looked like. Upon initial observation, the club column was filled with lots blanks. However, with the use of font color and unhiding the columns, the data became visible. In addtion to an invisible data, the club column had line breaks within which made the data within the column not visible when imported into postgreSQL database. To resolve this, TRIM together with Find and Replace was used to fix this issue.

### Duplicates
The dataset was checked for duplicates using before starting off with the cleaning process. No duplicates were found.

### Contract, Loan Date End 
The contract column contained special characters (~) to indicate the expected duration of players signed to a club. Also, it included the information of players that were on loan and those that were free. To make meaningful insight from this column, the contract column was split into two: contract_start_date and contract_end_date. Also, the loan Date End column included the same information about players on loan as the contract column. Hence, an additional column was created to indicate a player's contract status. This column (contract_status) will make it easier to know players that are signed to a club, those on loan, and free agents. After the cleaning, the datatype type for each of the columns were standardized.

### Height, Weight
For the purpose of consistency, the metric system chosen for the height and weight columns were **cm** and **kg** respectively. The SQL statements LEFT, RIGHT, SUBSTRING, POSITION, REPLACE, and WILDCARDS were used to extract the necessary object before the data was converted to numeric to allow for mathematical operation. Subsequently, the columns were renamed to be more descriptive by including the metric type to the column name.

### Positions
A new column (positions_count) was created to indicate the total number of positions that can be played by each player.

### Value, Wages, and Releaseclause
There were inconsistencies in these columns with regards to the represention of the monetary values where thousands were represented with K and millions in M. In addition, the the columns had an inconsistent data type. For consistency and correctness, the € symbol was first removed then rows with M was multiplied by 1000000 while rows with K was multiplied by 1000. Also, the columns were renamed to include the currency type of the players wages.

### W/F, SM, IR
These columns contained special characters which were removed using LEFT and then the values were casted into the right data type.

### Hits
The hits column had an inconsistent data type, inconsitent represntation of the values where a thousand was represented with K and it included lot of blanks. For this column, the blanks spaces were replaced with NULL, the values were casted to the correct data type and rows with K were converted by multiplying each with a thousand.

### Renaming Vague Columns
Columns with less decriptive names were renamed. Some of such columns includes pot, ova, bov,sm, am etc.
