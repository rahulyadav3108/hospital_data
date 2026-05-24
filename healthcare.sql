create DATABASE Healthcare;

use healthcare

SELECT * FROM healthcare_data;

DESC healthcare_data;

SELECT COUNT(*) FROM healthcare_data;

-- finding max , min , avg of hospitalized patients.
select max(age) as maximum from healthcare_data;
select min(age) as minimum FROM healthcare_data;
select avg(age) as avrage from healthcare_data;

-- Calculating Patients Hospitalized Age-wise from Maximum to Minimum
select age ,  count(*) as total
from healthcare_data
GROUP BY `Age`
ORDER BY `Age` DESC;

-- Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.
select age , COUNT(age) as total
from healthcare_data
GROUP BY `Age`
order BY total desc ;

-- Ranking Age on the number of patients Hospitalized   
SELECT age , count(age) as total , 
DENSE_RANK () over ( order by count (age) desc , `Age` DESC) as ranking 
from healthcare_data
GROUP BY `Age`
having count(age) > 1;

--  Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
SELECT `Medical Condition`, COUNT(`Medical Condition`) as Total_Patients 
FROM healthcare_data
GROUP BY `Medical Condition`
ORDER BY Total_patients DESC;

SELECT COUNT(*) AS Null_Values
FROM healthcare_data
WHERE `Medical Condition` IS NULL;

-- Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.
select 'Medical Condition' , 'Medication' , count(Medication) as medication_to_patients, 
rank() over(PARTITION BY 'Medical Condition' 
from healthcare_data
order by count(Medication) DESC) as rank_medication
GROUP BY 1,2
ORDER BY 2;

--  Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.   
SELECT Medical_Condition, Medication, 
COUNT(medication) as Total_Medications_to_Patients, 
RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(medication) DESC) as Rank_Medicine
FROM healthcare_data
GROUP BY 1,2
ORDER BY 1; 

-- Most preffered Insurance Provide  by Patients Hospatilized
SELECT Insurance_Provider , count(Insurance_Provider) AS total 
from healthcare_data
GROUP BY Insurance_Provider
ORDER BY Insurance_Provider DESC ;

SELECT Insurance_Provider , count(Insurance_Provider) AS total 
from healthcare_data
GROUP BY 1
ORDER BY 1 DESC ;

-- Finding out most preffered Hospital 
select Hospital , count(hospital) as total
from healthcare_data
group BY 1
ORDER BY 1 DESC;

-- Identifying Average Billing Amount by Medical Condition.
select Medical_Condition, ROUND(avg(`Billing Amount`),2) as avrage_ampont
from healthcare_data
GROUP BY 1;

-- Finding Billing Amount of patients admitted and number of days spent in respective hospital.
SELECT Medical_Condition, `Name`, Hospital, DATEDIFF(`Discharge date`,`Date of Admission`) as Number_of_Days, 
SUM(ROUND(`Billing Amount`,2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_Amount
FROM healthcare_data
ORDER BY Medical_Condition;

-- Finding Total number of days sepnt by patient in an hospital for given medical condition
SELECT `name` ,medical_condition , hospital , DATEDIFF(`Discharge Date` , `Date of Admission`) as total_days
FROM healthcare_data;

-- changed datatype of column
ALTER TABLE healthcare_data
MODIFY COLUMN `Discharge Date` date;

-- chanded date format according to 
UPDATE healthcare_data
SET `Discharge Date` = STR_TO_DATE(`Discharge Date`, '%d-%m-%Y')
where `Discharge Date` is not null;

-- Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to Normal
SELECT Medical_Condition,Hospital,DATEDIFF(`Discharge Date`, `Date of Admission`) as total_days,Test_Results
FROM healthcare_data
WHERE Test_Results LIKE 'Normal'
ORDER BY Medical_Condition , Hospital ;

-- Calculate number of blood types of patients which lies betwwen age 20 to 45
SELECT age , `Blood Type` , COUNT(`Blood Type`) as blood_type_count
FROM healthcare_data
WHERE age BETWEEN 20 AND 45
GROUP BY 1,2
ORDER BY `Blood Type` DESC; 

-- Find how many of patient are Universal Blood Donor and Universal Blood reciever
SELECT 
(SELECT COUNT(`Blood Type`) FROM healthcare_data WHERE `Blood Type` = 'O-') AS Universal_Blood_Donor,
(SELECT COUNT(`Blood Type`) FROM healthcare_data WHERE `Blood Type` = 'AB+') AS Universal_Blood_Receiver;

ALTER Table healthcare_data
RENAME COLUMN `Blood Type` to Blood_Type

--  Create a procedure to find Universal Blood Donor to an Universal Blood Reciever,
--  with priority to same hospital and afterwards other hospitals

DELIMITER $$

CREATE PROCEDURE blood_matcher(IN name_of_patient VARCHAR(200))
BEGIN

SELECT 
    D.Name AS Donor_name,
    D.Age AS Donor_Age,
    D.Blood_Type AS Donors_Blood_type,
    D.Hospital AS Donors_Hospital,

    R.Name AS Receiver_name,
    R.Age AS Receiver_Age,
    R.Blood_Type AS Receivers_Blood_type,
    R.Hospital AS Receivers_hospital

FROM healthcare_data D
INNER JOIN healthcare_data R
    ON D.Blood_Type = 'O-'
   AND R.Blood_Type = 'AB+'

WHERE R.Name = name_of_patient
  AND D.Age BETWEEN 20 AND 40;

END $$

DELIMITER ;
CALL Blood_Matcher('Matthew Cruz');

-- Provide a list of hospitals along with the count of patients admitted in the year 2024 AND 2025?

SELECT DISTINCT Hospital , count(`Hospital`) as total_admitted
from healthcare_data
where YEAR(`Date of Admission`) in (2018,2019,2020,2021,2022,2023)
GROUP BY 1
ORDER BY total_admitted desc;

SELECT DISTINCT YEAR(`Date of Admission`) AS admission_year
FROM healthcare_data
ORDER BY admission_year;

SELECT 
    YEAR(`Date of Admission`) AS Admission_Year,
    Hospital,
    COUNT(*) AS total_admitted
FROM healthcare_data
GROUP BY YEAR(`Date of Admission`), Hospital
ORDER BY Admission_Year, total_admitted DESC;

-- Find the average, minimum and maximum billing amount for each insurance provider?

SELECT Insurance_Provider, 
ROUND(AVG(Billing_Amount),1) as Average_Amount, 
ROUND(Min(Billing_Amount),0) as Minimum_Amount, 
ROUND(Max(Billing_Amount),0) as Maximum_Amount
FROM healthcare_data
GROUP BY 1;

-- Create a new column that categorizes patients as high, medium, or low risk based on their medical condition.
select `name`, Medical_Condition, Test_Results,
case 
when Test_Results = 'Inconclusive' THEN 'need more cheaks / cannot be discharge'
when Test_Results = 'Normal' THEN 'Can take discharge, But need to follow Prescribed medications timely' 
when Test_Results = 'Abnormal' THEN 'Needs more attention and more tests'
end as 'status', Hospital, Doctor

from healthcare_data ;

--  Find the total patient of each blood group
SELECT Blood_Type, count(`Blood_Type`) as total_patients
from healthcare_data
GROUP BY Blood_Type;

-- Total amount by the insurance provider 
SELECT Insurance_Provider, round(sum(Billing_Amount),2) as total_amount
from healthcare_data
GROUP BY `Insurance_Provider`;