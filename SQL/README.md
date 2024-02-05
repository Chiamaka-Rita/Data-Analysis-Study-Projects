# About
This project provides details of the steps taken to clean a very dirty dataset. For this project, SQL (postgreSQL) was used as the primary tool for cleaning the dataset.

## Introduction
Data can be found everywhere around us that recording these data can be very challenging and different menthods could be employed in collecting the same type of record. Hence, there are bound to be errors sure as spelling error, duplicates, missing data, inconsistencies in metrics etc. So, it is part of the job of anyone working with data (data analyst) to ensure that the dataset is cleaned before beginning any analysis. For the cleaning of this dataset, I will be using SQL within the PostgreSQL database management system.

### About the data
This is a fifa21 messy raw dataset gotten from Kaggle. This dataset comprises of 18979 rows and 77 columns. Each of the columns provides details about the personal and physical information of multiple players. More information about the data set [here](https://www.kaggle.com/datasets/yagunnersya/fifa-21-messy-raw-dataset-for-cleaning-exploring) also [here] is a link to the data dictionary.

### Problem Statement
The goal of this project is to clean this dataset by making it consistent, correct and free from errors. Upon an initial look into this dataset, I discovered the following inconsistencies below;
1.	There were lot of special characters within the dataset
2.	Blank columns
3.	Inconsistent metrics used
4.	Unstandardized date

### Skills Demonstrated
The skills demonstrated in this project includes the use of Common Table Expression (CTE), JOINs, (GROUPBY, Data Definition Language (DDL), Data Manipulation Language (DML) CASE statement)

### Data transformation
Excel was used for initial data exploration to get an overall insight on what the data looked like. Upon observation, the club column was filled with lots blanks but with the use of font color and unhiding columns, the data became visible. Also, the issue with line break was resolved by using TRIM, Find and Replace was used to manually remove the line breaks.

### Duplicates
The dataset was checked for duplicates using the ID before starting the cleaning process. No duplicates were found.

### Contract, Loan date end 
The contract column contained special characters (~) when indicating the players that are signed up to a club. Also, it included the information of players that were on loan and those that were free. To make meaningful insight from this column, the contract column was split into two: contract start date and contract end date. Also, because the loan end date included the same information as that of the contract. Another column was created contract status to cover up for the players status. This column will make it easier to know players that are signed to a club and those that are not. After the cleaning the datatype type for the column was changed to standardize things

### Height, Weight
The metric system was chosen as the option for measurement for the height and weight column to standardize them. For this column the clauses LEFT, RIGHT, SUBSTRING, WILDCARDS was used to extract the necessary object and then a conversion of data was performed. Before this was done, the data was converted to numeric to allow for mathematical operation and then the column name were changed for recognition purposes.

### Value, Wages, and Releaseclause
There was inconsistency observed in this column as it can be seen that some rows contained M to represent millions and some contained K to represent thousands. Moreover, this is a money or numeric day type but then this was found to be in varying character type. So for cleaning this, the € symbol was first removed then rows with M was multiplied by 1000000 while rows with K was multiplied by 1000 and the columns were renamed.

### W/F, SM, IR
These columns contained special characters which were removed using LEFT and then they were casted into integers. The columns data type were also adjusted for consistency

### Hits
The hits had K in the rows and lots of blanks, so the blanks were replaced with null because it could be that the data was not available at during data entry time. So, rather than leaving it blank, NULL was used to represent the data.

### Renaming Vague Columns
Columns with less decriptive names were renamed. Some of such columns includes pot, ova, bov,sm, am etc 
