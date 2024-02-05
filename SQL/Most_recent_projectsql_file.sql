-- First look at the dataset
SELECT *
FROM fifa
LIMIT 10

-- Check for duplicates
SELECT id, longname, count(*) 
FROM fifa
Group by id, longname
Having count(*) > 1;

-- Column longname was changed to player_name
ALTER TABLE fifa
RENAME COLUMN longname TO player_name

/* The following codes below extracts data columns contract, loanenddate, and joined
to create new columns contract_start_date, contract_end_date, and contract status */

-- Add new columns 
ALTER TABLE fifa
Add COLUMN contract_start_date varchar(50),
Add COLUMN contract_end_date varchar(50),
Add COLUMN contract_status varchar(50);

-- Standardize the column joined by changing the data type to date
ALTER TABLE fifa
ALTER COLUMN joined TYPE date USING joined::date

-- Update the contract_start_date with values
UPDATE fifa
SET contract_start_date = CASE WHEN contracts LIKE '%~%' THEN LEFT(contracts, 4)
WHEN contracts LIKE '%Loan' THEN split_part(joined::varchar, '-', 1)
ELSE null
END;

-- Update the contract_end_date with values
UPDATE fifa
SET contract_end_date = CASE WHEN contracts LIKE '%~%' THEN RIGHT(contracts, 4)
WHEN contracts LIKE '%Loan' THEN TRIM(LEFT(split_part(contracts,',',2), 5))
ELSE null
END;	

-- Update contract_status with values
UPDATE fifa
SET contract_status = CASE WHEN contracts LIKE '%~%' THEN 'Under contract'
WHEN contracts LIKE '%Loan' THEN 'On Loan'
ELSE contracts END;

/* The following code standardizes the columns height and weight to cm and kg respectively
using functions LEFT, RIGHT, SUBSTRINGS and WILDCARDS. */

--Update height column to centimeters
UPDATE fifa
SET height = CASE 
				WHEN height LIKE '%''%' THEN ROUND((((LEFT(height, POSITION('' IN height))::numeric * 30.48 ))) + (SUBSTRING(REPLACE(height, '"', ''), 3,2)::numeric * 2.54))
				ELSE LEFT(height, POSITION('cm' in height)-1)::numeric END

--Update weight column to kilograms
UPDATE fifa
SET weight = CASE
				WHEN weight LIKE '%lbs' THEN ROUND((LEFT(weight, POSITION('l' IN weight) -1)::numeric) * 0.453592) 
				ELSE LEFT(weight, POSITION('k' IN weight) -1)::numeric END 

--Rename column height and weight to indicate their metrics
ALTER TABLE fifa
RENAME column height TO height_cm;
ALTER TABLE fifa
RENAME column weight TO weight_kg;

/*The code below creates a new column and provides the counts of positions played */

-- Add a column called positions_count
ALTER TABLE fifa
ADD COLUMN positions_count int

--The code below counts the number of positions a player can make
UPDATE fifa2
SET positions_count = regexp_count(positions, ',') + 1 

/* The following code below cleans the columns value, wages, and releaseclause */

---Remove the € sign
UPDATE fifa
SET VALUE = REPLACE(value, '€', '')

UPDATE fifa
SET wage = REPLACE(wage, '€', '')

UPDATE fifa
SET releaseclause = REPLACE(releaseclause, '€', '')


--Update the columns by converting K, and M to numerals
Update fifa
SET value = CASE WHEN value LIKE '%M' THEN ROUND((split_part(value, 'M', 1))::numeric *1000000)
WHEN value LIKE '%K' THEN ROUND((split_part(value, 'K', 1))::numeric *1000)
ELSE (value)::numeric END


UPDATE fifa
SET wage = CASE WHEN wage LIKE '%M' THEN ROUND((split_part(wage, 'M', 1))::numeric *1000000)
WHEN wage LIKE '%K' THEN ROUND((split_part(wage, 'K', 1))::numeric *1000)
ELSE (wage)::numeric END


UPDATE fifa
SET releaseclause = CASE WHEN releaseclause LIKE '%M' THEN ROUND((split_part(releaseclause, 'M', 1))::numeric *1000000)
WHEN releaseclause LIKE '%K' THEN ROUND((split_part(releaseclause, 'K', 1))::numeric *1000)
ELSE (releaseclause)::numeric END


---Rename columns value, wage, releaseclause
ALTER TABLE fifa
RENAME COLUMN value TO value_€

ALTER TABLE fifa
RENAME COLUMN wage TO wage_€

ALTER TABLE fifa
RENAME COLUMN releaseclause TO release_clause_€

--Alter the data type of the columns
ALTER TABLE fifa
ALTER COLUMN value_€ TYPE numeric USING value_€::numeric;

ALTER TABLE fifa
ALTER COLUMN wage_€ TYPE numeric USING wage_€::numeric;

ALTER TABLE fifa
ALTER COLUMN release_clause_€ TYPE numeric USING release_clause_€::numeric;

/* The code below was used to remove special characters from columns wf, sm, 
and ir. Also the data types were converted to integers for consistency */

---Remove special characters in WF, IR, SM and cast values to integers
UPDATE fifa
SET WF = (LEFT(wf, 1))

UPDATE fifa
SET IR = (LEFT(ir, 1))

UPDATE fifa
SET sm = (LEFT(sm, 1))


---Update data type
ALTER TABLE fifa
ALTER COLUMN WF TYPE integer USING WF::integer;
		  
ALTER TABLE fifa
ALTER COLUMN sm TYPE integer USING sm::integer;
		  
ALTER TABLE fifa
ALTER COLUMN ir TYPE integer USING ir::integer;


/* The code below updates columns with K into numerals, replaces blanks with nulls
and standarzes the data type to numeric */

SELECT hits, round(LEFT(hits, POSITION('K' IN hits)-1)::numeric * 1000)
from fifa
where hits like '%K'


UPDATE fifa
SET hits = CASE WHEN hits LIKE '%K' THEN round(LEFT(hits, POSITION('K' IN hits)-1)::numeric * 1000)
WHEN hits IS null OR hits = '' THEN NULL
ELSE hits::numeric END

ALTER TABLE fifa
ALTER COLUMN hits TYPE numeric USING hits::numeric

--Rename vague columns 
ALTER TABLE fifa
RENAME COLUMN pot TO player_potential_percent

ALTER TABLE fifa
RENAME COLUMN ova TO overall_analysis_percent

ALTER TABLE fifa
RENAME COLUMN bov TO best_overall_percent

ALTER TABLE fifa
RENAME COLUMN SM TO Skill_moves

ALTER TABLE fifa
RENAME COLUMN AW TO Attacking_work_rate

ALTER TABLE fifa
RENAME COLUMN DW TO Defensive_work_rate

ALTER TABLE fifa
RENAME COLUMN WF TO Weak_Foot

ALTER TABLE fifa
RENAME COLUMN IR TO injury_rating

ALTER TABLE fifa
RENAME COLUMN PAS TO Pass

ALTER TABLE fifa
RENAME COLUMN SHO TO Shooting_Attribute

ALTER TABLE fifa
RENAME COLUMN PAC TO Pace

ALTER TABLE fifa
RENAME COLUMN DRI TO Dribbling_rate

ALTER TABLE fifa
RENAME COLUMN DEF TO Defensive_rate

ALTER TABLE fifa
RENAME COLUMN PHY TO Physical_rate

