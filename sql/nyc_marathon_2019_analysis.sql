
-- ============================================================

-- Women's Running Analytics — NYC Marathon 2019

-- ============================================================


-- ============================================================
-- INITIAL DATA EXPLORATION
-- ============================================================




PRAGMA table_info(nyc_marathon_2019_raw)
;

SELECT *
FROM nyc_marathon_2019_raw
LIMIT 10
;


--Checking total records

SELECT COUNT (*) AS total_records
FROM nyc_marathon_2019_raw
;

SELECT 
					COUNT (DISTINCT "bib_number") AS distinct_bib_numbers         
FROM nyc_marathon_2019_raw
;


--Checking Race 

SELECT 
				("Race"),  
				COUNT ("Race") AS race_records									
FROM nyc_marathon_2019_raw
GROUP BY "Race"
;


--Checking for null bib numbers

SELECT 
					COUNT(*)
FROM nyc_marathon_2019_raw
WHERE "bib_number" IS NULL 
				OR TRIM("bib_number") = ' '
;


-- Checking Year

SELECT DISTINCT 	("Year")  		        
FROM nyc_marathon_2019_raw
;

--Checking for gender

SELECT 
						COUNT(*) AS count_by_gender,
						"gender"
														
FROM nyc_marathon_2019_raw
GROUP BY "gender"
;

--Checking for nationality


SELECT DISTINCT 
						"nationality"
FROM nyc_marathon_2019_raw
;


SELECT 
						COUNT("nationality") AS count_by_nationality,
						"nationality"
														
FROM nyc_marathon_2019_raw
GROUP BY "nationality"
ORDER BY count_by_nationality DESC
;

SELECT 
						"nationality"
FROM nyc_marathon_2019_raw
WHERE "nationality" IS NULL 
;

--Checking Overall Age Statistics

SELECT 
				MIN("age") AS younger_age,
				MAX("age") AS older_age,
				ROUND(AVG("age") ,2) AS average_age
FROM nyc_marathon_2019_raw
;				

--Checking Women's Age Range

SELECT 
				MIN("age") AS women_younger_age,
				MAX("age") AS women_older_age,
				ROUND(AVG("age") ,2) AS women_average_age
FROM nyc_marathon_2019_raw
WHERE "gender" =  'F'
;	

	
SELECT 
			    COUNT(*)
FROM nyc_marathon_2019_raw
WHERE "age" IS NULL
				AND "gender" = 'F'
;	
	
	
--Checking for Missing Women's Finish Times		


SELECT 
				COUNT(*) AS female_null_time_full
FROM nyc_marathon_2019_raw
WHERE "gender" ='F'
					AND "time_full" IS NULL 
;

--Checking for Blank Women's Finish Times	

SELECT
				COUNT(*) AS female_empty_whitespace_time_full
FROM nyc_marathon_2019_raw
				WHERE "gender" = 'F'
				AND TRIM("time_full") = ''
 ;


 --Inspecting Finish-Time Format

 
SELECT
				"time_full"			
FROM nyc_marathon_2019_raw
LIMIT 10
;


--Testing Finish-Time Conversion Components

SELECT 
               "time_full",
				 printf(
							'%02d', CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER)) AS hour,
				 printf(
							'%02d', CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER)) AS 	minute,
				 printf(
							'%02d', CAST(substr("time_full", -2) AS INTEGER)) AS second

FROM nyc_marathon_2019_raw
LIMIT 10 OFFSET 53515
;



--Converting Finish Time to Seconds


SELECT
				 "time_full",
				 
							(CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) * 3600) +
							(CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER) * 60) +
							(CAST(substr("time_full", -2) AS INTEGER)) AS time_full_in_seconds
FROM nyc_marathon_2019_raw
LIMIT 10 
;


--Testing Finish-Time Formatting

SELECT 
               "time_full",
			   printf(
							'%02d', CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) )||':'||
				printf(
			                '%02d',CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER)) ||':'||
				printf(
								'%02d', CAST(substr("time_full", -2) AS INTEGER)) AS time
				
FROM nyc_marathon_2019_raw
LIMIT 10 OFFSET 53515
;


-- Calculating Finish-Time Statistics


SELECT 
				ROUND(MIN( 
							(CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) * 3600) +
							(CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER) * 60) +
							(CAST(substr("time_full", -2) AS INTEGER))),2) AS fastest_time,
				ROUND(MAX( 
							(CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) * 3600) +
							(CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER) * 60) +
							(CAST(substr("time_full", -2) AS INTEGER))),2) AS slowest_time,
				ROUND(AVG(
							(CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) * 3600) +
							(CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER) * 60) +
							(CAST(substr("time_full", -2) AS INTEGER))),2) AS average_time
FROM nyc_marathon_2019_raw
WHERE  "gender" = 'F'
;	


-- ============================================================
-- CREATE AND VALIDATE CLEAN TABLE
-- ============================================================


CREATE TABLE nyc_marathon_2019_clean AS 

SELECT
				"place",
				"name",
				"gender",
				"age",
				"nationality",
				"bib_number",
				"Race",
				"Year",
				"time_full",
				((CAST(substr("time_full",1, instr("time_full", ':') - 1) AS INTEGER) * 3600) +
				(CAST(substr("time_full", instr("time_full", ':') +1, 2) AS INTEGER) * 60) +
				(CAST(substr("time_full", -2) AS INTEGER))) AS time_full_in_seconds

FROM nyc_marathon_2019_raw
;



-- Validating new table nyc_marathon_2019_clean


PRAGMA table_info(nyc_marathon_2019_clean)
;


SELECT *
FROM nyc_marathon_2019_clean
LIMIT 10
;

SELECT COUNT(*)
FROM nyc_marathon_2019_clean
;


SELECT COUNT(*) AS missing_converted_time
FROM nyc_marathon_2019_clean
WHERE time_full_in_seconds IS NULL
;



-- ============================================================
-- END OF SCRIPT
-- ============================================================
