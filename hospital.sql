use healthcare ;

-- Q1. Display all records from the hospital table.
select *
from hospital ;

-- Q2. Display patient's Name, Age and Gender.
select 
`name` ,
age ,
gender 
from hospital ;

-- Q3. Find patients older than 60.
select *
from hospital
where age > 60 ;

-- Q4. Find all female patients.
select *
from hospital
where gender = 'female' ;

-- Q5. Find patients with Diabetes.
select *
from hospital
where Medical_Condition = 'Diabetes' ;

-- Q6. Display unique medical conditions.
select distinct Medical_Condition
from hospital ;

-- Q7. Find patients with billing amount greater than 30,000.
select *
from hospital
where Billing_Amount > 30000 ;

-- Q8. Sort patients by age from youngest to oldest.
select *
from hospital
order by age asc ;

-- Q9. Sort patients by billing amount from highest to lowest.
select *
from hospital
order by Billing_Amount desc ;

-- Q10. Find patients admitted through Emergency.
select *
from hospital
where `Admission Type` = 'Emergency' ;

-- level 2

-- Q1. Female patients older than 50.
select *
from hospital
where Gender = 'female'
and Age > 50 ;

-- Q2. Patients with Diabetes or Cancer.
select 
`name` ,
Medical_Condition
from hospital
where Medical_Condition = 'Diabetes' 
or Medical_Condition = 'Cancer' ; 

-- Q3. Patients older than 50 with Diabetes or Hypertension.
select
`name` ,
age ,
Medical_Condition
from hospital
where Age > 50
and Medical_Condition = 'Diabetes'
or Medical_Condition = 'Hypertension'  ;

-- Q4. Patients aged between 30 and 50.
select 
`name` ,
age 
from hospital
where age between 30 and 50 ;

-- Q5. Patients with A+, O+, or AB+ blood type.
select 
`name` ,
blood_type 
from hospital
where Blood_Type in ('A+' , 'O+' , 'AB+');

-- Q6. Patients whose insurance is not Medicare or Aetna.
select
`name` ,
Insurance_Provider 
from hospital
where Insurance_Provider not in ('Medicare' , 'Aetna') ;
-- Q7. Patients whose name starts with M.
select
`name` ,
age ,
gender 
from hospital
where `name` like 'M%' ;

-- Q8. Hospitals containing "Brown".
select
`name` ,
age ,
gender 
from hospital
where `name` like '%Brown%' ;

-- Q9. Patients admitted after January 1, 2021.
select
`name` ,
`Date of Admission`
from hospital
where `Date of Admission` > '2021-01-01' 
order by `Date of Admission` asc;

-- Q10. Male, younger than 40, A+/O+, billing > 20,000.
select
`name` ,
age ,
Gender ,
Blood_Type ,
Billing_Amount
from hospital
where Gender = 'male' 
and age < 40 
and Blood_Type in ('A+' , 'O+')
and Billing_Amount > 20000;

-- Q1. Find the total number of patients.
select 
count(*) as total_patients 
from hospital ;

-- Q2. Find the average age of patients.
select
avg(Age) as average_age 
from hospital ;

-- Q3. Find the total billing amount.
select
sum(Billing_Amount) as total_bill 
from hospital ;

-- Q4. Find the minimum and maximum billing amount.
select
min(Billing_Amount) as minimum_bill ,
max(Billing_Amount) as maximum_bill
from hospital ;

-- Q5. Find the number of patients by gender.
select
gender ,
count(*) as total_patients
from hospital
group by Gender ;

-- Q6. Find the number of patients for each medical condition.
select
Medical_Condition ,
count(*) as number_of_patients
from hospital
group by Medical_Condition ;

-- Q7. Find the average age for each medical condition.
select 
Medical_Condition ,
avg(Age) as average_age
from hospital
group by Medical_Condition ;

-- Q8. Find the average billing amount for each insurance provider.
select 
Insurance_Provider ,
avg(Billing_Amount) as average_bill
from hospital
group by Insurance_Provider ;

-- Q9. Find the total billing amount for each insurance provider.
select 
Insurance_Provider ,
sum(Billing_Amount) as total_amount
from hospital
group by Insurance_Provider ;

-- Q10. Find the average billing amount by admission type for patients older than 40.
select 
`Admission Type` ,
avg(Billing_Amount) as average_amount 
from hospital
where age > 40
group by `Admission Type` ;

-- Q1. Find medical conditions having more than 10 patients. 
select
Medical_Condition ,
count(*) as total_patients
from hospital
group by Medical_Condition
having total_patients > 10 ;

-- Q2. Find insurance providers whose average billing is greater than 25,500.
select 
Insurance_Provider ,
avg(Billing_Amount) as average_bill 
from hospital
group by Insurance_Provider
having average_bill >25000 ;

-- Q3. Find medical conditions whose total billing is greater than 42,000,000.
select
Medical_Condition ,
sum(Billing_Amount) as total_bill
from hospital
group by Medical_Condition
having total_bill > 42000000 ;

-- Q4. Create Age Groups.
select
`name` ,
age ,
case
when age < 30 then 'Young' 
when age between 30 and 60 then 'Adult' 
else 'Senior' 
end as age_group
from hospital ;

-- Q5. Create Billing Categories.
select 
`name` ,
Billing_Amount ,
case 
when Billing_Amount < 15000 then 'Low'   
when Billing_Amount between 15000 and 30000 then 'Medium'
else 'High'
end as  Billing_Categories
from hospital ;

-- Q6. Count patients in each Age Group.
select 
case
when age < 30 then 'Young' 
when age between 30 and 60 then 'Adult' 
else 'Senior' 
end as age_group ,
count(*) as total_patients
from hospital
group by age_group ;

-- Q7. Display patient names in uppercase.
select
upper(`name`) as patients_name
from hospital ;

-- Q8. Number of patients admitted in each year.
select
year(`Date of Admission`) as admission_year  ,
count(*) as number_of_patients
from hospital 
group by admission_year 
order by admission_year asc ;

-- Q9. Calculate hospital stay in days.
select
`name` ,
`Date of Admission` ,
`Discharge Date` ,
datediff(`Discharge Date` , `Date of Admission`) as total_days
from hospital ;

-- Find the average hospital stay for each medical condition, but only include patients who:
-- stayed in the hospital for more than 5 days
-- and have a billing amount greater than 20,000
-- Then show only medical conditions where the resulting average stay is greater than 7 days.
select
Medical_Condition ,
avg(datediff(`Discharge Date` , `Date of Admission`)) as average_stay
from hospital
where datediff(`Discharge Date` , `Date of Admission`) > 5 
and Billing_Amount > 20000
group by Medical_Condition
having avg(datediff(`Discharge Date` , `Date of Admission`)) > 7 ;

create table doctors (
    Doctor varchar(100),
    Specialization varchar(100),
    Experience int
);

insert into doctors (name, specialization, years_of_experience)
values
('Patrick Parker', 'Diabetes', 12),
('Diane Jackson', 'Asthma', 5),
('Paul Baker', 'Obesity', 14),
('Brian Chandler', 'Asthma', 9),
('Dustin Griffin', 'Arthritis', 9),
('Robin Green', 'Arthritis', 10),
('Patricia Bishop', 'Hypertension', 11),
('Brian Kennedy', 'Arthritis', 6),
('Kristin Dunn', 'Diabetes', 15),
('Jessica Bailey', 'Asthma', 5),
('Anthony Roberts', 'Cancer', 7),
('William Miller', 'Hypertension', 4),
('Laura Roberts', 'Diabetes', 7),
('James Carney', 'Diabetes', 6),
('Katherine Lowe', 'Cancer', 9),
('Curtis Smith', 'Arthritis', 4),
('Clayton Mcknight', 'Diabetes', 10),
('Debra Meyers', 'Arthritis', 6),
('Megan Sanders', 'Obesity', 9),
('Zachary Horton DDS', 'Arthritis', 7),
('Kelly Thompson', 'Arthritis', 15),
('Michael Chang', 'Asthma', 5),
('Nicole Wood', 'Obesity', 15),
('Angela Kim', 'Diabetes', 4),
('Jodi Holland', 'Asthma', 4),
('Christina Flores', 'Obesity', 10),
('Natalie Sullivan', 'Obesity', 14),
('Carolyn Baker MD', 'Hypertension', 9),
('Nicole Mcclain', 'Cancer', 9),
('Chloe Thomas', 'Hypertension', 15),
('Brian Watson', 'Arthritis', 11),
('Dr. Kyle Dickson', 'Obesity', 13),
('Michael Smith', 'Asthma', 9),
('Pamela Brown', 'Asthma', 9),
('Tiffany Crawford', 'Cancer', 7),
('Rachel Sullivan', 'Asthma', 10),
('Samuel Taylor', 'Obesity', 11),
('John Harvey', 'Diabetes', 4),
('Sylvia Johnson', 'Diabetes', 10),
('Janice Vargas', 'Cancer', 13),
('Mark Hill', 'Arthritis', 12),
('Amber Gonzalez', 'Hypertension', 8),
('Wendy Galloway', 'Asthma', 5),
('Michael Harris', 'Diabetes', 8),
('Emily West', 'Hypertension', 9),
('Cody Wright', 'Hypertension', 9),
('Melissa Kelley', 'Arthritis', 4),
('Larry Guzman', 'Obesity', 10),
('Kelsey Clark', 'Cancer', 15),
('Corey Sutton', 'Diabetes', 15),
('Ashley Edwards', 'Cancer', 10),
('Leon Price', 'Arthritis', 14),
('Kyle Estrada', 'Obesity', 11),
('Jared Harmon', 'Cancer', 6),
('Adrian Pierce', 'Arthritis', 6),
('Jesus Snyder', 'Obesity', 4),
('Sara Watts', 'Cancer', 11),
('Stacy Brewer', 'Hypertension', 10),
('Nicholas Aguirre', 'Diabetes', 14),
('Miranda Robinson', 'Cancer', 11),
('Tina Rogers', 'Cancer', 4),
('Dennis Mitchell', 'Cancer', 15),
('Robin Rodriguez', 'Obesity', 7),
('Sergio Conner', 'Diabetes', 14),
('Mr. John Short', 'Hypertension', 5),
('Gina Maddox', 'Asthma', 8),
('Heather Warner', 'Arthritis', 4),
('Amber Hayes', 'Obesity', 8),
('Karen Nelson', 'Cancer', 8),
('Brenda Bates DVM', 'Hypertension', 9),
('Gabriella White', 'Arthritis', 9),
('Sean Thomas', 'Cancer', 13),
('Aaron Burnett', 'Arthritis', 4),
('Caleb Rasmussen', 'Obesity', 4),
('Christopher Castaneda', 'Diabetes', 6),
('Angela Mcdonald', 'Diabetes', 10),
('Julia Gibson', 'Cancer', 8),
('Denise Jones', 'Diabetes', 12),
('Sandra Hogan', 'Arthritis', 13),
('Kathryn Garcia', 'Cancer', 6),
('Adrian Terry', 'Arthritis', 9),
('Joseph Santiago', 'Arthritis', 4),
('Kristin Nash', 'Asthma', 9),
('Donald Nelson', 'Obesity', 5),
('Nathan Colon', 'Arthritis', 6),
('John Chavez MD', 'Cancer', 9),
('Stephen West', 'Diabetes', 8),
('Eric Sellers', 'Arthritis', 6),
('Raymond Moore Jr.', 'Cancer', 15),
('Briana Olson', 'Diabetes', 14),
('Sherri Jones', 'Cancer', 15),
('Bethany Graham', 'Hypertension', 10),
('Angelica Gross', 'Diabetes', 13),
('Carrie Ho', 'Arthritis', 8),
('David Williams', 'Arthritis', 4),
('Stacy Salazar', 'Hypertension', 7),
('Mitchell Bradshaw', 'Arthritis', 4),
('Jennifer Barry', 'Asthma', 11),
('Catherine Russell', 'Cancer', 13),
('William Martinez', 'Obesity', 13),
('Amanda Young', 'Obesity', 10),
('Angela Cruz DDS', 'Hypertension', 14),
('Marcus Reed', 'Diabetes', 4),
('Denise Richards', 'Hypertension', 8),
('Andrea Nguyen', 'Obesity', 6),
('Ian Hunter', 'Asthma', 13),
('Thomas Smith', 'Obesity', 11),
('Wesley Thompson', 'Diabetes', 7),
('Eduardo Ross', 'Obesity', 13),
('Rita Payne', 'Obesity', 8),
('Sherry Sharp', 'Obesity', 4),
('Diana Hunt', 'Hypertension', 12),
('Christina Gonzalez', 'Diabetes', 12),
('Rodney Obrien', 'Cancer', 12),
('Shannon Pineda', 'Diabetes', 7),
('Laurie Gonzalez', 'Obesity', 5),
('Sydney Brown', 'Arthritis', 6),
('Jonathan Phillips', 'Diabetes', 12),
('Brandon Ray', 'Cancer', 6),
('Deborah Johnson', 'Obesity', 15),
('Matthew Williams', 'Hypertension', 7),
('Tim Bradshaw', 'Asthma', 11),
('Charles Medina', 'Arthritis', 5),
('Kathleen Cummings MD', 'Hypertension', 8),
('Judy Carlson', 'Arthritis', 7),
('William Wolf', 'Hypertension', 4),
('Carl Rivera', 'Arthritis', 10),
('Jennifer Vasquez', 'Arthritis', 13),
('Rachel Wheeler', 'Arthritis', 8),
('David Stephenson', 'Diabetes', 14),
('Stephanie Parker', 'Hypertension', 6),
('Kelly Sanchez', 'Diabetes', 15),
('Sierra Graves', 'Arthritis', 6),
('Ryan Wilkins', 'Cancer', 15),
('Nicole Holland', 'Obesity', 15),
('Victoria Stafford', 'Obesity', 11),
('Timothy Miller', 'Hypertension', 12),
('Angela Wright', 'Arthritis', 15),
('Jillian Marshall', 'Cancer', 12),
('Zachary Potter', 'Diabetes', 10),
('Gabrielle Pitts', 'Arthritis', 4),
('Jason Mcintosh', 'Asthma', 9),
('Jessica Smith', 'Arthritis', 14),
('Spencer Bentley', 'Hypertension', 6),
('Bruce Matthews', 'Asthma', 10),
('Jason Ryan', 'Asthma', 10),
('Mark Fischer', 'Asthma', 14),
('Katherine George', 'Hypertension', 11),
('Nicholas Glover', 'Cancer', 9),
('Christopher Wallace', 'Asthma', 15),
('Adam Rasmussen', 'Hypertension', 5),
('Richard Harris', 'Arthritis', 13),
('Erika Long', 'Hypertension', 15),
('Nathan Hawkins', 'Arthritis', 9),
('Christopher Sullivan', 'Asthma', 12),
('Laura Johnson', 'Diabetes', 9),
('Tammy Williamson', 'Asthma', 14),
('Kara Frey', 'Diabetes', 13),
('Dr. Jessica Harris MD', 'Hypertension', 12),
('Jeffery Maxwell', 'Asthma', 4),
('Stephanie Clark', 'Hypertension', 13),
('Jenna Ward', 'Hypertension', 9),
('Vicki Merritt', 'Obesity', 15),
('Kevin Davis', 'Asthma', 12),
('Emily Jensen', 'Hypertension', 12),
('Michael Pacheco', 'Asthma', 11),
('Jason Little', 'Cancer', 8),
('Mark Nichols', 'Obesity', 12),
('Joseph Navarro', 'Asthma', 8),
('Allison Bond', 'Asthma', 11),
('Douglas Holmes', 'Hypertension', 12),
('Shannon Hall', 'Cancer', 11),
('Charles Mora', 'Diabetes', 13),
('Kevin Morris', 'Obesity', 6),
('Heather Anderson', 'Hypertension', 15),
('Joshua Larson', 'Hypertension', 7),
('Alyssa Acevedo', 'Diabetes', 13),
('Kelly Scott MD', 'Cancer', 10),
('Ashley Taylor', 'Asthma', 13),
('William Meza', 'Obesity', 13),
('Jessica Powell MD', 'Diabetes', 10),
('Theresa Garcia', 'Hypertension', 9),
('Stephanie Bennett', 'Cancer', 10),
('Michelle Harris', 'Hypertension', 11),
('Lee Evans', 'Cancer', 13),
('Michael Sutton', 'Obesity', 8),
('James Nichols', 'Asthma', 11),
('Terry Bean', 'Hypertension', 11),
('Jose Cross', 'Diabetes', 6),
('Dennis Morris', 'Asthma', 13),
('David Davis', 'Arthritis', 10),
('Shane Browning', 'Arthritis', 14),
('Kara Barton', 'Cancer', 8),
('Bonnie Weaver', 'Asthma', 6),
('Christopher Barton', 'Diabetes', 14),
('Andrew Mendez', 'Asthma', 12),
('Jonathan Rodriguez', 'Asthma', 5),
('Geoffrey Diaz', 'Arthritis', 14),
('Austin Alvarado', 'Arthritis', 10),
('Russell Soto', 'Arthritis', 13),
('Anna Meyers', 'Arthritis', 8),
('Susan Pennington', 'Obesity', 12),
('Wanda Warren', 'Asthma', 12),
('Brenda Burton', 'Diabetes', 7),
('Christopher Garcia', 'Cancer', 14),
('Zachary Rogers', 'Arthritis', 9),
('Jennifer Merritt', 'Diabetes', 5),
('Colleen Velazquez', 'Cancer', 14),
('Austin Fernandez', 'Cancer', 13),
('Christina Barnes', 'Asthma', 8),
('Brian Walsh', 'Cancer', 6),
('Latoya Knapp', 'Asthma', 12),
('Terry Berger', 'Obesity', 13),
('Michelle Perez', 'Hypertension', 6),
('Amber Jennings', 'Cancer', 4),
('Tony Hawkins', 'Obesity', 6),
('Chris Cobb DVM', 'Obesity', 6),
('Aaron Taylor', 'Obesity', 10),
('Gregory Schroeder', 'Asthma', 14),
('Monica Mueller', 'Diabetes', 13),
('Ann Butler', 'Hypertension', 8),
('Sheri Ramirez', 'Cancer', 14),
('Richard Shaw', 'Cancer', 9),
('Samuel Sutton', 'Arthritis', 7),
('Kimberly Palmer', 'Diabetes', 6),
('Alex Sutton', 'Cancer', 9),
('Tina Jordan', 'Hypertension', 12),
('Jose Love MD', 'Hypertension', 9),
('Meredith Johnson DDS', 'Diabetes', 15),
('John Thompson', 'Hypertension', 12),
('Mark Barnes', 'Hypertension', 5),
('Philip Torres', 'Cancer', 14),
('William Hart', 'Arthritis', 8),
('Joshua Wilson', 'Asthma', 4),
('Kenneth Higgins', 'Diabetes', 11),
('Rebekah Cruz', 'Arthritis', 11),
('Destiny Avery', 'Hypertension', 13),
('Jerry Cruz', 'Arthritis', 11),
('Nicole Fernandez', 'Cancer', 4),
('Misty Clark', 'Arthritis', 11),
('Christopher Tran', 'Hypertension', 8),
('Dana Adams', 'Hypertension', 10),
('Nicole Miller', 'Obesity', 13),
('Misty Lopez', 'Cancer', 14),
('Alexis Reeves', 'Arthritis', 11),
('Donald Johnson', 'Hypertension', 6),
('Norman Weaver', 'Hypertension', 8),
('Barbara Hurst', 'Diabetes', 11),
('Vanessa Wilson', 'Diabetes', 9),
('Scott Beck', 'Asthma', 4),
('Rebecca Morales', 'Obesity', 7),
('Jessica Sanders', 'Cancer', 12),
('Bradley Ellis', 'Hypertension', 13),
('Jessica Newton', 'Diabetes', 10),
('Monica Wright', 'Asthma', 14),
('Amber Flores', 'Asthma', 5),
('Anne White', 'Cancer', 12),
('Annette Cook', 'Diabetes', 12),
('William Oconnor', 'Asthma', 10),
('Michael Sullivan', 'Hypertension', 6),
('Christopher Howard', 'Arthritis', 13),
('Sarah Torres', 'Diabetes', 10),
('Melissa Nguyen', 'Obesity', 9),
('Catherine Jones', 'Diabetes', 9),
('Elizabeth Cordova', 'Asthma', 9),
('Stephanie Bryan', 'Asthma', 8),
('Samuel Lowe', 'Asthma', 9),
('Mr. Eric Smith', 'Arthritis', 9),
('Jamie Marks', 'Diabetes', 7),
('Wesley Mcpherson', 'Asthma', 10),
('Jordan Johnston', 'Hypertension', 8),
('Nathan Mason', 'Obesity', 4),
('Jason Smith', 'Obesity', 7),
('Kimberly Valentine', 'Obesity', 13),
('Brittany Weaver', 'Cancer', 10),
('Robert Page', 'Hypertension', 12),
('Sean Black', 'Obesity', 11),
('Jamie Wright', 'Obesity', 7),
('Aaron Padilla', 'Cancer', 7),
('Dustin Martinez', 'Arthritis', 8),
('John Ryan MD', 'Cancer', 12),
('Kelsey Ross', 'Hypertension', 8),
('Andrea Owen', 'Diabetes', 4),
('Melissa Gomez MD', 'Hypertension', 12),
('Sharon Banks', 'Diabetes', 9),
('Peter Bailey', 'Hypertension', 11),
('Lindsay Watson', 'Asthma', 11),
('Sarah Williams', 'Cancer', 8),
('Nicole Johnson', 'Obesity', 10),
('Nathaniel Wilson', 'Arthritis', 14),
('Elizabeth Clark DDS', 'Arthritis', 8),
('Jose Harris', 'Asthma', 4),
('Ronnie Hernandez', 'Arthritis', 14),
('Veronica Bradley', 'Hypertension', 4),
('Charles Blake', 'Hypertension', 14),
('Jose Richard', 'Cancer', 4),
('Richard Fuller', 'Hypertension', 8),
('Amanda Blackburn', 'Asthma', 13),
('Rachel Roberts', 'Obesity', 10),
('Robert Leblanc', 'Cancer', 9),
('Dawn Waller', 'Asthma', 5),
('Leslie Walls', 'Obesity', 10),
('Jennifer Newton', 'Arthritis', 5),
('Dr. Sean Russell', 'Cancer', 5),
('Diane Fuller', 'Asthma', 13),
('Jordan Wise', 'Asthma', 8),
('Mr. Samuel Burgess', 'Arthritis', 7),
('Nathaniel Richardson', 'Cancer', 9),
('Amber Meza', 'Hypertension', 14),
('Amber Flores', 'Arthritis', 7),
('Cheryl Robles', 'Obesity', 12),
('Victoria Smith', 'Asthma', 8),
('Christopher Flores', 'Cancer', 7),
('Jason Wright', 'Asthma', 15),
('Michael Chung', 'Asthma', 12),
('Lucas Clark', 'Obesity', 9),
('Joyce Cuevas', 'Asthma', 6),
('Joanne Owen', 'Obesity', 4),
('Jill Hughes', 'Hypertension', 12),
('Scott Martin', 'Asthma', 6),
('Gina Beasley', 'Arthritis', 10),
('Tricia Mcclure', 'Cancer', 15),
('Rodney Johnson', 'Diabetes', 4),
('Katie Erickson', 'Arthritis', 11),
('James Garcia', 'Cancer', 7),
('Tonya Castaneda', 'Asthma', 14),
('Theresa Brown', 'Obesity', 4),
('James Holmes', 'Hypertension', 12),
('Randy White', 'Asthma', 7),
('Jason Kelley', 'Asthma', 15),
('Kimberly Brewer', 'Cancer', 15),
('Jonathan Good', 'Obesity', 7),
('Cory Fletcher', 'Hypertension', 13),
('Amy Matthews', 'Obesity', 7),
('Anne Velazquez', 'Hypertension', 14),
('Todd Jackson', 'Obesity', 10),
('Sandra Scott', 'Arthritis', 10),
('Dr. Nicolas Bryant', 'Diabetes', 8),
('Heather Lewis', 'Cancer', 11),
('David Patel', 'Cancer', 6),
('Jerome Davis', 'Obesity', 15),
('Michael Villanueva', 'Cancer', 13),
('Elizabeth Chase', 'Asthma', 15),
('Edward Collins', 'Arthritis', 9),
('Jonathon Klein', 'Diabetes', 6),
('David Sanchez', 'Asthma', 11),
('Matthew Downs', 'Obesity', 9),
('Jennifer Acosta', 'Diabetes', 10),
('Karen Collier', 'Diabetes', 8),
('Cheryl Palmer', 'Cancer', 8),
('Joseph Ortega', 'Arthritis', 4),
('Donna Vasquez', 'Cancer', 4),
('Alexander Shelton', 'Obesity', 15),
('Anna Adams', 'Arthritis', 8),
('Karen Cox', 'Cancer', 9),
('Lindsey Gentry', 'Cancer', 6),
('Jordan Garrett', 'Arthritis', 6),
('Julia Perez', 'Cancer', 7),
('Theresa Ramsey', 'Hypertension', 4),
('Carolyn Mann', 'Hypertension', 5),
('Terry Cameron MD', 'Obesity', 15),
('Alexander Hamilton', 'Cancer', 10),
('Jessica Rodriguez', 'Arthritis', 5),
('Kayla Reyes', 'Arthritis', 13),
('Victoria Chavez', 'Asthma', 11),
('Melinda Brown', 'Hypertension', 14),
('Wendy Hooper', 'Cancer', 12),
('Pedro Harmon', 'Asthma', 4),
('Lucas Phillips', 'Cancer', 4),
('Renee Brown', 'Cancer', 15),
('Paula Washington', 'Hypertension', 12),
('Jordan Lutz', 'Arthritis', 4),
('Dr. Jessica Castro', 'Asthma', 4),
('Taylor Braun', 'Arthritis', 7),
('Lori Morton', 'Arthritis', 12),
('Whitney Gibson', 'Obesity', 12),
('Sierra Farmer', 'Hypertension', 7),
('Amy Bush', 'Obesity', 14),
('Adam Gonzales', 'Asthma', 12),
('Troy Kim', 'Hypertension', 7),
('Dwayne Mooney', 'Arthritis', 4),
('Teresa Griffith DDS', 'Cancer', 13),
('Samuel Carrillo', 'Cancer', 6),
('Elizabeth Humphrey', 'Diabetes', 5),
('Tina Stevenson', 'Cancer', 9),
('Angela Garcia', 'Asthma', 7),
('Michael Robinson', 'Cancer', 5),
('Gina Turner', 'Diabetes', 4),
('Matthew Hammond', 'Hypertension', 5),
('Shannon Gonzales', 'Asthma', 14),
('Jared Diaz', 'Obesity', 9),
('Gregory Casey', 'Arthritis', 9),
('Gene Goodman', 'Arthritis', 6),
('Nancy Smith', 'Arthritis', 7),
('Brianna Cervantes', 'Obesity', 7),
('Gregory Anderson', 'Cancer', 12),
('Julia Wu', 'Hypertension', 6),
('Patrick Ochoa', 'Hypertension', 4),
('Monique Meyer', 'Arthritis', 9),
('Jessica Daniels', 'Arthritis', 13),
('Nicole George', 'Cancer', 13),
('James Garza', 'Arthritis', 5),
('Jennifer Rose', 'Hypertension', 8),
('Nicole Leon', 'Diabetes', 5),
('David Smith', 'Obesity', 6),
('Christopher Walker', 'Hypertension', 15),
('Nathaniel White', 'Cancer', 5),
('Juan Jordan', 'Obesity', 5),
('John Martin', 'Asthma', 15),
('Eric Powell', 'Asthma', 7),
('Tammy Harris', 'Diabetes', 12),
('Christopher Russell', 'Obesity', 10),
('Joe Leonard', 'Asthma', 9),
('Erik Noble', 'Diabetes', 8),
('Benjamin Cameron', 'Diabetes', 4),
('Kelly Neal', 'Obesity', 5),
('Elaine Medina', 'Cancer', 8),
('Jacob Smith', 'Asthma', 9),
('Rebecca Ortiz', 'Arthritis', 13),
('Alyssa Collins', 'Cancer', 13),
('James May', 'Arthritis', 14),
('Diamond Robbins', 'Asthma', 5),
('Vickie Brooks', 'Asthma', 5),
('Sarah Anderson', 'Diabetes', 4),
('Anthony Jones', 'Arthritis', 8),
('Jacob White', 'Obesity', 5),
('Jane Berger', 'Diabetes', 13),
('Ryan Guerra', 'Hypertension', 13),
('Cynthia Brown', 'Cancer', 10),
('Melissa Roman', 'Diabetes', 8),
('Matthew Stafford', 'Asthma', 11),
('Mr. Rodney Morrow DDS', 'Diabetes', 7),
('Michael Solis', 'Obesity', 6),
('Jeffrey Steele', 'Cancer', 10),
('Craig Haley', 'Arthritis', 12),
('Shelley Lang', 'Obesity', 5),
('Kari Patrick', 'Obesity', 6),
('Jeremy Farley', 'Diabetes', 4),
('Brittany Keith', 'Obesity', 15),
('Anna Knapp', 'Asthma', 10),
('Monica Peters', 'Cancer', 13),
('Betty Evans', 'Diabetes', 15),
('Phillip Crawford', 'Diabetes', 11),
('Andrew Nash', 'Asthma', 5),
('Chris Torres', 'Asthma', 10),
('Jennifer Carlson', 'Obesity', 12),
('Steven Melton', 'Arthritis', 6),
('Vanessa Gutierrez', 'Arthritis', 13),
('Crystal Wallace', 'Cancer', 5),
('Alexis Alexander', 'Cancer', 10),
('Brooke Phillips', 'Asthma', 10),
('Kathy Walker', 'Cancer', 13),
('Lori Stone', 'Diabetes', 14),
('Justin Carter', 'Cancer', 10),
('Laura Herrera', 'Obesity', 11),
('James Novak', 'Hypertension', 15),
('Michelle Moyer', 'Hypertension', 15),
('Tasha Pierce', 'Hypertension', 9),
('Dustin Cunningham', 'Asthma', 8),
('Mr. Andrew Keller', 'Diabetes', 10),
('Sara Howard', 'Asthma', 8),
('Robin Lopez', 'Obesity', 6),
('John Leon', 'Arthritis', 9),
('Mr. Charles Garcia', 'Asthma', 11),
('Jonathan Shaw', 'Diabetes', 5),
('Tim Clark', 'Hypertension', 11),
('Samuel Gilbert', 'Cancer', 4),
('Miss Rachel Barnes', 'Obesity', 5),
('Miguel Jones', 'Diabetes', 5),
('Lisa Salazar', 'Asthma', 14),
('Sean Charles', 'Hypertension', 12),
('Amber Madden', 'Obesity', 11),
('Charles Clayton', 'Diabetes', 8),
('Kayla Hernandez', 'Asthma', 12),
('Amanda Shepard', 'Hypertension', 14),
('Kristy Reynolds', 'Cancer', 15),
('Kristin Young', 'Cancer', 15),
('Heather Burke', 'Asthma', 10),
('Morgan Johnson', 'Arthritis', 8),
('Francisco Cortez', 'Hypertension', 9),
('Laura Wright', 'Hypertension', 12),
('Allison Schroeder', 'Asthma', 10),
('Jimmy Brown', 'Cancer', 10),
('David Phillips', 'Diabetes', 13),
('Timothy Hoffman', 'Arthritis', 11),
('John Mcdonald', 'Diabetes', 5),
('Debbie Fritz', 'Hypertension', 5),
('Nicole Carter', 'Obesity', 14),
('Shane Matthews', 'Hypertension', 5),
('Anthony Ross', 'Asthma', 4),
('Wesley Rice', 'Asthma', 15),
('Laura Bell', 'Obesity', 5),
('Brian Adams', 'Asthma', 11),
('Karen Mullen', 'Asthma', 6),
('Christopher Blair', 'Cancer', 15),
('Eddie Shah', 'Asthma', 15),
('Joseph Small', 'Diabetes', 11),
('Teresa Cannon', 'Cancer', 7),
('William Hart', 'Cancer', 8),
('Rachel Jimenez', 'Arthritis', 6),
('Ashley Garcia', 'Hypertension', 12),
('John Brown', 'Cancer', 9),
('Ashley Perez', 'Hypertension', 7),
('Trevor Walker', 'Diabetes', 4),
('Paul Tanner', 'Asthma', 8),
('Autumn Washington', 'Obesity', 11),
('Ryan Cline', 'Arthritis', 11),
('Shannon Ochoa', 'Hypertension', 10),
('Matthew Wyatt', 'Hypertension', 8),
('Deborah Jones', 'Diabetes', 9),
('Angela Branch', 'Diabetes', 15),
('Kathleen Oconnor DDS', 'Arthritis', 13),
('Janice Morgan', 'Hypertension', 7),
('Michael Harris', 'Arthritis', 12),
('Amy Carpenter', 'Obesity', 10),
('Denise Gonzalez', 'Diabetes', 15),
('Pamela Davis MD', 'Cancer', 4),
('Tara Jones', 'Asthma', 14),
('Gary Baldwin', 'Cancer', 7),
('Wendy Gallagher', 'Hypertension', 10),
('William Townsend', 'Asthma', 13),
('Amanda Clark', 'Hypertension', 14),
('Joshua Lopez', 'Hypertension', 10),
('George Davis', 'Cancer', 5),
('David Richardson', 'Arthritis', 15),
('Kristen Henderson', 'Obesity', 12),
('Deborah Andrews', 'Hypertension', 7),
('Susan Franklin', 'Obesity', 10),
('James Fleming', 'Hypertension', 8),
('Blake Young', 'Obesity', 9),
('Bradley Jones', 'Asthma', 12),
('Toni Hoover', 'Asthma', 14),
('Tara Kaufman', 'Diabetes', 7),
('Kathryn Boone', 'Asthma', 14),
('Penny Moore', 'Hypertension', 14),
('Dana Daniels', 'Diabetes', 9),
('Carla Sanchez', 'Arthritis', 14),
('Robert Johnson', 'Hypertension', 12),
('Michelle Ali', 'Hypertension', 10),
('Julia Lang', 'Diabetes', 5),
('Jeffrey Bush', 'Obesity', 4),
('Sean Knight', 'Cancer', 6),
('Daniel Barnett', 'Diabetes', 5),
('Randy Carlson', 'Obesity', 8),
('Curtis Sanchez', 'Hypertension', 12),
('Penny Jones', 'Arthritis', 12),
('Samuel Tran', 'Diabetes', 12),
('Jonathan Ruiz', 'Obesity', 5),
('John Sloan', 'Obesity', 4),
('Jessica Cook', 'Obesity', 4),
('Stephen Henderson', 'Hypertension', 6),
('Mr. Jeffrey Oliver', 'Asthma', 11),
('Joshua Ramirez', 'Hypertension', 9),
('Luis Brown', 'Hypertension', 10),
('Denise Costa', 'Cancer', 14),
('Maurice Collins', 'Asthma', 8),
('Tim Bauer', 'Arthritis', 10),
('Joshua Myers', 'Obesity', 10),
('Louis Vasquez', 'Diabetes', 8),
('Douglas Contreras', 'Obesity', 8),
('Julie Carr', 'Obesity', 10),
('Mr. Samuel Garcia', 'Diabetes', 6),
('Michael Holder', 'Hypertension', 14),
('Andre Hernandez', 'Asthma', 5),
('Chris Weeks', 'Cancer', 6),
('Mike Allen', 'Arthritis', 9),
('Adam Snyder', 'Arthritis', 6),
('Anna Mclean', 'Asthma', 15),
('Laura Norris', 'Asthma', 12),
('Theresa Ingram', 'Diabetes', 8),
('Paul Walker', 'Cancer', 9),
('Mario Dillon', 'Hypertension', 10),
('Amber Carter', 'Asthma', 10),
('Michael Allen', 'Diabetes', 9),
('Tony Bean', 'Asthma', 4),
('Nicole Rodriguez', 'Arthritis', 11),
('Eric Clark', 'Hypertension', 6),
('Nichole Lewis', 'Hypertension', 10),
('Wanda Meyers', 'Obesity', 12),
('Steven Smith', 'Asthma', 7),
('Carl Sanders', 'Obesity', 4),
('Dr. Robert Massey', 'Cancer', 13),
('Eric Knox', 'Arthritis', 11),
('Eric Marquez', 'Asthma', 10),
('Seth Lewis', 'Hypertension', 10),
('James Phillips', 'Cancer', 15),
('Gregory Smith', 'Arthritis', 9),
('Colleen Miller', 'Diabetes', 5),
('Christopher Henry', 'Asthma', 7),
('Wendy Santiago', 'Obesity', 7),
('Paul Hill', 'Cancer', 10),
('Jay Lopez', 'Hypertension', 6),
('John Diaz', 'Obesity', 15),
('George May', 'Diabetes', 15),
('Daniel Stephens', 'Hypertension', 7),
('Joe Avery', 'Asthma', 14),
('Chad Riley', 'Arthritis', 6),
('Mrs. Tammy Rose', 'Obesity', 10),
('Mindy Lindsey', 'Arthritis', 13),
('Linda Gomez', 'Cancer', 4),
('Diana Cooper', 'Asthma', 10),
('Sheri Mclean', 'Arthritis', 7),
('Julia Murray', 'Diabetes', 6),
('Kristi Leblanc', 'Obesity', 10),
('Robert Morgan', 'Diabetes', 5),
('Renee Ford', 'Asthma', 7),
('James Roberson', 'Asthma', 9),
('Ricky Ryan', 'Asthma', 6),
('Jordan Moss', 'Diabetes', 6),
('Mr. Seth Watson II', 'Diabetes', 15),
('Norman Williams', 'Cancer', 9),
('Holly Chan', 'Arthritis', 8),
('Lori Chandler', 'Hypertension', 12),
('Christopher Owens', 'Asthma', 14),
('Steven Allen', 'Diabetes', 5),
('Derrick Krause', 'Cancer', 14),
('Ryan Kirk', 'Hypertension', 5),
('Kyle Miller', 'Cancer', 15),
('Jessica Yu', 'Obesity', 15),
('Michelle Lopez', 'Asthma', 14),
('Alexander Cruz', 'Asthma', 13),
('Derek Martin', 'Arthritis', 13),
('Carol Brown', 'Asthma', 8),
('Mr. Mark Nguyen', 'Cancer', 13),
('Kimberly Garcia', 'Cancer', 15),
('Dylan Andrews', 'Asthma', 14),
('Amber Welch', 'Diabetes', 15),
('Zachary Fuentes', 'Arthritis', 8),
('Jared Marshall', 'Arthritis', 9),
('Mr. Timothy Santiago', 'Asthma', 12),
('Matthew Kennedy', 'Arthritis', 13),
('Thomas Rice', 'Obesity', 6),
('Kristi Chan', 'Cancer', 7),
('Mark Watkins', 'Arthritis', 15),
('Hunter Carter', 'Arthritis', 14),
('George Jones', 'Cancer', 5),
('Gregory Patton', 'Diabetes', 10),
('Duane Lane', 'Cancer', 7),
('Jesse Bailey', 'Hypertension', 4),
('Laurie Floyd', 'Cancer', 8),
('Alexandria Potts', 'Diabetes', 11),
('Jessica Jackson', 'Cancer', 5),
('Julie Moreno', 'Arthritis', 13),
('Carla Dougherty', 'Diabetes', 11),
('Franklin Martin', 'Hypertension', 14),
('Adrian Davis', 'Cancer', 15),
('Anthony Davis', 'Hypertension', 10),
('Kristen Sherman', 'Hypertension', 6),
('Heather Burns', 'Obesity', 9),
('Mrs. Lindsey Howell', 'Arthritis', 14),
('Xavier Wright', 'Arthritis', 12),
('Patty Murphy', 'Asthma', 13),
('Emily Watson', 'Diabetes', 10),
('Russell Smith', 'Cancer', 4),
('Melissa Cervantes', 'Obesity', 5),
('Anthony Cole', 'Diabetes', 9),
('Peggy Bailey', 'Cancer', 4),
('David Jennings', 'Arthritis', 7),
('Connie Johnson', 'Diabetes', 4),
('Ashley Brooks', 'Diabetes', 13),
('Morgan Johnson', 'Hypertension', 11),
('Jasmine Russell', 'Cancer', 7),
('Charles Weber', 'Cancer', 10),
('Joseph Banks', 'Arthritis', 7),
('Beverly Carlson', 'Arthritis', 15),
('Michael Dougherty', 'Diabetes', 5),
('Karen Rogers', 'Asthma', 13),
('Jake White', 'Obesity', 9),
('David Dean', 'Obesity', 13),
('Randy Scott', 'Cancer', 11),
('Luke Lawrence', 'Diabetes', 12),
('Sean Warren', 'Hypertension', 4),
('Michele Cruz', 'Cancer', 15),
('Jordan Shelton', 'Hypertension', 6),
('Philip Mullins', 'Cancer', 4),
('Garrett Benton', 'Hypertension', 15),
('Michelle Kennedy', 'Asthma', 14),
('Mary Gonzales', 'Obesity', 12),
('Dana Black', 'Hypertension', 5),
('Anthony Hernandez', 'Diabetes', 15),
('Cory Campbell', 'Cancer', 7),
('Michael Kelly', 'Asthma', 7),
('Jacob Olson', 'Cancer', 11),
('Kendra Shields', 'Hypertension', 7),
('Deanna Williams MD', 'Asthma', 11),
('Nicholas Bailey', 'Arthritis', 9),
('Kimberly Henry', 'Cancer', 13),
('Henry Garcia', 'Diabetes', 4),
('Madeline Smith', 'Asthma', 11),
('Brian Barnett', 'Asthma', 11),
('Nicholas Valenzuela', 'Arthritis', 10),
('Donna Hicks', 'Obesity', 15),
('Amanda Stout', 'Cancer', 13),
('Adrian Boyd', 'Arthritis', 8),
('Dr. Ann Mcdonald', 'Diabetes', 5),
('Christine Lewis', 'Hypertension', 13),
('Carol Harris', 'Obesity', 12),
('Tracy Ward', 'Diabetes', 4),
('Maria Walker', 'Hypertension', 13),
('Carol Park', 'Asthma', 12),
('Lisa Bennett', 'Arthritis', 5),
('Sandra Cross', 'Cancer', 8),
('Danny Mcdaniel', 'Arthritis', 15),
('Mary Williams', 'Arthritis', 14),
('Susan Olson', 'Hypertension', 9),
('Kendra Flores', 'Hypertension', 15),
('Sylvia Avery', 'Arthritis', 8),
('Deanna Baldwin', 'Hypertension', 11),
('Michael Strickland', 'Hypertension', 6),
('Mary Carson', 'Obesity', 7),
('Pamela Patel', 'Asthma', 10),
('Michael Sexton', 'Obesity', 13),
('David Gregory', 'Obesity', 8),
('Elizabeth Vance', 'Hypertension', 6),
('Mark Dunn', 'Asthma', 6),
('Pamela Taylor', 'Cancer', 5),
('Michael Waters', 'Diabetes', 10),
('Michele Henderson', 'Diabetes', 10),
('Carrie Becker', 'Hypertension', 9),
('Robert Burton', 'Cancer', 5),
('Jason Coleman', 'Diabetes', 15),
('Amy Simmons', 'Diabetes', 14),
('Matthew Rodriguez', 'Asthma', 5),
('Ryan Castillo', 'Arthritis', 13),
('Ellen Spence', 'Cancer', 13),
('Mr. Adam Ramirez', 'Cancer', 11),
('Joshua Miller', 'Diabetes', 15),
('Steven Serrano', 'Asthma', 14),
('Daniel Mack', 'Asthma', 8),
('Mike Alvarez', 'Asthma', 9),
('Lori Horton', 'Cancer', 14),
('Linda Tran', 'Asthma', 15),
('Erin Scott', 'Obesity', 4),
('Aaron Johnson', 'Arthritis', 14),
('Alice Gross DVM', 'Hypertension', 13),
('Diana Castro', 'Diabetes', 9),
('Samuel Sutton', 'Diabetes', 12),
('Michael Flores', 'Hypertension', 11),
('Cynthia Freeman', 'Hypertension', 4),
('Steven Hawkins', 'Obesity', 9),
('Gina Daniel', 'Cancer', 12),
('Alexander Jones', 'Asthma', 5),
('Jeffrey Jackson', 'Hypertension', 6),
('Brittany Gilbert', 'Obesity', 5),
('Tony Wright', 'Arthritis', 7),
('Sheri Garcia', 'Hypertension', 12),
('Charles James', 'Obesity', 6),
('Dawn Graves', 'Hypertension', 9),
('Debbie Fisher', 'Arthritis', 7),
('Mr. Aaron Chase', 'Arthritis', 13),
('Natalie Smith', 'Hypertension', 8),
('Paula Chavez', 'Cancer', 9),
('Stephanie Smith', 'Arthritis', 5),
('Richard Freeman', 'Diabetes', 5),
('Gerald Green', 'Obesity', 5),
('Patrick Williams', 'Diabetes', 11),
('James Flynn', 'Diabetes', 13),
('Barbara Cantrell', 'Hypertension', 7),
('Rebecca Myers', 'Obesity', 14),
('Matthew Olsen', 'Cancer', 9),
('Kelly Guerrero', 'Obesity', 7),
('Jason Williams', 'Diabetes', 6),
('Misty Allen', 'Obesity', 10),
('Heather Livingston', 'Obesity', 10),
('Jessica Rodriguez', 'Obesity', 5),
('Christine Frey', 'Diabetes', 14),
('Kevin Higgins', 'Asthma', 13),
('Leslie Cook', 'Obesity', 9),
('Thomas Hutchinson', 'Obesity', 4),
('Lacey Keith', 'Hypertension', 11),
('Lindsay Curry', 'Asthma', 14),
('Amy Williams', 'Arthritis', 9),
('Dawn Hughes', 'Hypertension', 6),
('Michael Evans', 'Arthritis', 15),
('Craig Harris', 'Cancer', 5),
('Ashley Kim', 'Cancer', 15),
('Nicole King', 'Asthma', 13),
('Shannon Rodriguez', 'Hypertension', 4),
('David Lopez', 'Diabetes', 12),
('Samantha May', 'Hypertension', 4),
('Shannon Perry', 'Asthma', 10),
('Matthew Williams', 'Diabetes', 11),
('Debra Parsons', 'Hypertension', 13),
('Michael Taylor', 'Diabetes', 4),
('Elizabeth Ashley', 'Diabetes', 10),
('Frances Watson', 'Hypertension', 6),
('Lisa Hill', 'Arthritis', 6),
('Stephen Fletcher', 'Asthma', 12),
('Paul Ward', 'Hypertension', 6),
('Janice Lee', 'Obesity', 8),
('Robert George', 'Asthma', 4),
('Sarah Holden', 'Obesity', 9),
('Robert Edwards', 'Diabetes', 11),
('Robert Brown', 'Obesity', 15),
('Erin Yang', 'Diabetes', 4),
('Justin Lynch', 'Arthritis', 13),
('Brittany Lewis', 'Cancer', 11),
('Meredith Harris', 'Obesity', 8),
('Melissa Wyatt', 'Diabetes', 12),
('Jeffrey White', 'Hypertension', 11),
('Robert Fisher', 'Arthritis', 14),
('Brandon Hines', 'Cancer', 13),
('Sergio Johnson', 'Hypertension', 10),
('Eric Thomas', 'Hypertension', 12),
('Nancy Lewis', 'Arthritis', 11),
('Mrs. Cheryl Gomez', 'Arthritis', 7),
('William Alexander', 'Arthritis', 6),
('Dawn Alvarez', 'Arthritis', 13),
('Allen Powers', 'Asthma', 7),
('Paula Gonzalez', 'Hypertension', 13),
('Richard Rhodes', 'Cancer', 15),
('Cassidy Williams', 'Arthritis', 13),
('Kenneth Nunez', 'Asthma', 12),
('James Larsen', 'Diabetes', 4),
('John Webb', 'Cancer', 14),
('Jon Rodriguez', 'Hypertension', 8),
('Angela Lee', 'Diabetes', 6),
('Dr. Gabriel Gibson', 'Asthma', 8),
('Traci Henderson', 'Obesity', 10),
('John Duncan', 'Cancer', 13),
('Andre Schultz', 'Diabetes', 13),
('Mark Thompson', 'Hypertension', 11),
('Luis Cabrera', 'Asthma', 8),
('Christine Stein', 'Diabetes', 14),
('Kara Curry', 'Hypertension', 5),
('Jeremy Mills', 'Obesity', 15),
('Angela Gomez', 'Diabetes', 12),
('Dr. Tyler Anthony', 'Asthma', 10),
('Kristen Hancock', 'Hypertension', 12),
('Edward Figueroa PhD', 'Hypertension', 7),
('Jennifer Carr', 'Asthma', 15),
('Joshua Blackwell', 'Arthritis', 15),
('Kevin Ryan', 'Cancer', 9),
('Pamela Williams', 'Hypertension', 13),
('Jason Chase', 'Arthritis', 11),
('Michael Lloyd', 'Asthma', 11),
('Christopher Mcfarland', 'Diabetes', 5),
('Theresa Thomas', 'Hypertension', 7),
('Mrs. Theresa Rosales MD', 'Diabetes', 13),
('Claire Young', 'Obesity', 9),
('Jose Boone', 'Asthma', 8),
('Rhonda Porter', 'Obesity', 13),
('Karen Garrison', 'Cancer', 15),
('Ashley Price', 'Diabetes', 5),
('Derrick Francis', 'Hypertension', 9),
('Sherry Lara', 'Cancer', 14),
('Gloria Hernandez', 'Cancer', 12),
('Cassandra Johnson', 'Arthritis', 12),
('Natasha Valenzuela', 'Cancer', 10),
('Robert Hanson', 'Arthritis', 6),
('Jason Boone', 'Hypertension', 10),
('Wendy King', 'Cancer', 15),
('John Henderson', 'Diabetes', 5),
('Kelly Smith', 'Cancer', 7),
('Jonathan Mcmillan', 'Asthma', 14),
('Charles Robinson', 'Arthritis', 12),
('Amanda Peterson', 'Hypertension', 5),
('Robert Day', 'Diabetes', 7),
('Ryan Barron', 'Hypertension', 8),
('Zachary Anderson', 'Diabetes', 4),
('Karen Baker', 'Asthma', 9),
('Brian Rocha', 'Diabetes', 7),
('Corey Hopkins', 'Asthma', 6),
('Amanda Shaw', 'Diabetes', 11),
('Lindsay Collins', 'Obesity', 14),
('Christopher Sandoval', 'Cancer', 8),
('Allison Mendoza', 'Arthritis', 14),
('Amber Young', 'Cancer', 8),
('Zachary Griffith', 'Diabetes', 4),
('Troy Parker', 'Obesity', 14),
('Sarah Mcneil', 'Arthritis', 9),
('Jenna Stone', 'Arthritis', 4),
('Michelle Robinson MD', 'Asthma', 11),
('Michael Hodges', 'Asthma', 5),
('Gabriel Hopkins', 'Cancer', 15),
('Amanda James', 'Obesity', 7),
('Terri Williams', 'Arthritis', 13),
('Maria Griffin', 'Asthma', 14),
('Mr. Austin West Jr.', 'Hypertension', 15),
('Sean Bean', 'Asthma', 5),
('Joan Andrews', 'Hypertension', 6),
('Abigail Cooper', 'Hypertension', 4),
('Andre Watson', 'Arthritis', 13),
('Brenda Lawson', 'Arthritis', 6),
('Robert Walker', 'Hypertension', 13),
('Kenneth Montgomery', 'Asthma', 11),
('Dean Hart', 'Asthma', 6),
('Mary Wagner', 'Arthritis', 7),
('James Johnson', 'Arthritis', 15),
('Kristen Stewart', 'Obesity', 15),
('David Duke', 'Asthma', 7),
('Samantha Wagner', 'Asthma', 12),
('Dr. Lori Lowe', 'Cancer', 5),
('Elizabeth Welch', 'Diabetes', 14),
('Lori Hanna', 'Cancer', 4),
('Richard Newman', 'Hypertension', 14),
('Tiffany Perry', 'Obesity', 14),
('Donald Williams', 'Asthma', 9),
('Aaron Smith', 'Cancer', 10),
('Brent Murray', 'Cancer', 5),
('Kevin Conrad', 'Cancer', 7),
('Jennifer Beasley', 'Diabetes', 15),
('James Copeland', 'Cancer', 4),
('Kelsey Anderson', 'Diabetes', 5),
('Jacob Friedman', 'Obesity', 9),
('Melissa Hawkins', 'Hypertension', 5),
('Scott Barton', 'Diabetes', 12),
('Joseph Park', 'Cancer', 9),
('Stephanie Avila', 'Cancer', 8),
('Miranda Silva', 'Obesity', 9),
('Victoria Myers', 'Arthritis', 8),
('Michael Olson', 'Asthma', 6),
('Jason Beck', 'Obesity', 14),
('James Allison', 'Asthma', 11),
('Travis Davidson', 'Asthma', 14),
('Sandra Moore', 'Hypertension', 14),
('Michael Goodman', 'Cancer', 12),
('Bradley Dillon', 'Obesity', 6),
('Ronald Taylor', 'Hypertension', 14),
('Karen James', 'Diabetes', 6),
('Alexandra Robbins', 'Arthritis', 14),
('Michelle Sanchez', 'Diabetes', 12),
('Margaret Jacobs', 'Arthritis', 10),
('Deborah Blackwell', 'Diabetes', 12),
('Henry Mcbride', 'Hypertension', 15),
('Marco Gallegos', 'Asthma', 10),
('Samuel Francis', 'Asthma', 8),
('Crystal Farmer', 'Obesity', 5),
('Melissa Jackson', 'Hypertension', 9),
('Laura Webster', 'Hypertension', 13),
('Leon Small', 'Diabetes', 5),
('Tamara Carter', 'Cancer', 12),
('Theresa Santana', 'Cancer', 6),
('Stephen Johnson', 'Asthma', 13),
('Dawn Pierce', 'Diabetes', 14),
('Kenneth Mccoy', 'Diabetes', 13),
('Jacqueline Steele', 'Asthma', 11),
('Dana Payne', 'Obesity', 5),
('Deborah Guerra MD', 'Diabetes', 6),
('Nichole Black', 'Diabetes', 6),
('Matthew Arnold', 'Obesity', 14),
('Shane Cabrera', 'Cancer', 13),
('Megan Torres', 'Obesity', 6),
('David Fowler', 'Obesity', 11),
('Michelle Guzman', 'Obesity', 5),
('Robert Alexander', 'Hypertension', 7),
('Angelica Houston', 'Arthritis', 12),
('James Jackson', 'Hypertension', 15),
('Lauren Phillips', 'Diabetes', 10),
('John Russell', 'Diabetes', 4),
('Jennifer Wade', 'Cancer', 10),
('Christine Smith', 'Cancer', 10),
('Glenn Burns', 'Obesity', 14),
('Ronald Chen', 'Cancer', 15),
('James Richard', 'Asthma', 5),
('Laura Ortiz', 'Obesity', 9),
('Mark Martin', 'Asthma', 7),
('Matthew Curtis', 'Arthritis', 15),
('Nathan Meyers', 'Hypertension', 14),
('Rachel Wood', 'Diabetes', 5),
('Brittany Strickland', 'Hypertension', 5),
('Joann Meyer', 'Asthma', 6),
('Dana Davidson', 'Asthma', 6),
('Cody Osborne', 'Asthma', 10),
('Joshua Harris', 'Cancer', 14),
('Jennifer Smith', 'Hypertension', 7),
('Gabriela Cooley', 'Hypertension', 7),
('Kim Payne', 'Hypertension', 7),
('Donna Williams', 'Arthritis', 6),
('Brittany Carter', 'Asthma', 11),
('Eric Bowen', 'Diabetes', 4),
('Tiffany Pacheco', 'Obesity', 11),
('James Hatfield', 'Obesity', 5),
('Natalie Moore', 'Diabetes', 4),
('Rhonda Adams', 'Obesity', 6),
('Michael Gonzalez', 'Obesity', 5),
('Claudia Lee', 'Diabetes', 9),
('Brandon Mccarthy', 'Diabetes', 15),
('Mitchell Holder', 'Arthritis', 15),
('Haley Riley', 'Diabetes', 11),
('Laura Cruz', 'Cancer', 5),
('Antonio Richardson', 'Cancer', 8),
('Ashley Sherman', 'Arthritis', 14),
('Jennifer Monroe', 'Obesity', 6),
('David Vargas', 'Cancer', 14),
('Claudia Davis', 'Arthritis', 10),
('Sherri Vaughn', 'Arthritis', 9),
('Anna Lyons', 'Hypertension', 14),
('Lisa Clark', 'Obesity', 6),
('John Brown', 'Asthma', 8),
('Ashley Jackson', 'Hypertension', 14),
('Erica Guzman', 'Hypertension', 5),
('Frederick Reed', 'Hypertension', 5),
('Anthony Miller', 'Cancer', 4),
('Roberta Adams', 'Obesity', 9),
('Deborah Adams', 'Arthritis', 14),
('Jordan Gonzales', 'Obesity', 12),
('Daniel Nelson', 'Asthma', 9),
('Mindy Bell', 'Obesity', 4),
('Tyrone Robertson', 'Diabetes', 14);

select *
from doctors ;

-- Basic INNER JOIN. Display:
-- Patient Name
-- Doctor
-- Doctor's Specialization
select
h.`name` ,
h.doctor ,
d.specialization
from hospital as h
inner join doctors as d
on h.doctor = d.doctor  ;

-- INNER JOIN + WHERE
-- Find all patients whose doctor's specialization is cancer. Display:
-- Name
-- Doctor
-- Specialization
select
h.`name` ,
h.doctor ,
d.specialization
from hospital as h
inner join doctors as d
on h.doctor = d.doctor  
where d.specialization = 'cancer' ;

-- LEFT JOIN
-- Display all patients, along with their doctor's specialization.
select
h.`name` ,
h.doctor ,
d.specialization
from hospital as h
left join doctors as d
on h.doctor = d.doctor  ;

-- RIGHT JOIN
-- Display all doctors and the patients assigned to them. Show:
-- Doctor
-- Specialization
-- Name
select
h.doctor ,
d.specialization ,
h.`name` 
from hospital as h
right join doctors as d
on h.doctor = d.doctor  ;

-- JOIN + Filtering
-- Find patients who have:
-- a doctor specializing in cancer
-- and a billing amount greater than 30,000 . 
-- Display:
-- Name
-- Doctor
-- Specialization
-- Billing_Amount 
select
h.`name` ,
h.doctor ,
d.specialization ,
h.Billing_Amount
from hospital as h
inner join doctors as d
on h.doctor = d.doctor 
where specialization = 'cancer'
and Billing_Amount > 30000 ;

-- JOIN + GROUP BY
-- Find the number of patients handled by each doctor. Display:
-- Doctor
-- Total_Patients
select
h.doctor ,
count(*) as total_patients
from hospital as h
inner join doctors as d
on h.doctor = d.doctor
group by h.Doctor
order by total_patients ;

-- JOIN + AVG()
-- Find the average billing amount for each doctor. Display:
-- Doctor
-- Average_Billing
select
h.doctor ,
avg(h.Billing_Amount) as average_bill
from hospital as h
inner join doctors as d
on h.doctor = d.doctor
group by h.Doctor
order by average_bill desc;

-- JOIN + GROUP BY + HAVING
-- Find doctors who have:
-- more than 1 patient
-- and an average billing amount greater than 25,000.
select
h.doctor ,
count(*) as total_patients ,
avg(h.Billing_Amount) as average_bill
from hospital as h
inner join doctors as d
on h.doctor = d.doctor
group by h.Doctor 
having total_patients > 1
and average_bill > 25000 ;

-- Multiple Conditions
-- Find all female patients older than 50 whose doctor's specialization is Neurology or cancer. Display:
-- Name
-- Age
-- Gender
-- Doctor
-- Specialization
select
h.`name` ,
h.age ,
h.gender ,
h.doctor ,
d.specialization 
from hospital h
inner join doctors d
on h.doctor = d.doctor
where h.gender = 'female'
and h.age > 50 
and d.specialization in ('Neurology' , 'cancer') ;

-- Advanced JOIN Challenge
-- For each medical condition, find:
-- the number of patients
-- the average billing amount
-- the average age
-- But only include patients whose doctor's experience is greater than 10 years. Display:
-- Medical_Condition
-- Total_Patients
-- Average_Billing
-- Average_Age
-- Then show only medical conditions having at least 2 patients.
select
h.Medical_Condition,
count(*) as Total_Patients,
avg(h.Billing_Amount) as Average_Billing,
avg(h.Age) as Average_Age
from hospital h
inner join doctors d
on h.Doctor = d.Doctor
where d.years_of_experience > 10
group by h.Medical_Condition
having count(*) >= 2;

-- Scalar Subquery
-- Find all patients whose billing amount is greater than the average billing amount of all patients.
-- You need to compare:
-- patient's Billing_Amount
--         >
-- overall average Billing_Amount
select
`name` ,
Billing_Amount 
from hospital
where Billing_Amount > (
select avg (Billing_Amount)
from hospital
);

-- Subquery with MAX()
-- Find all patients who have the highest billing amount in the dataset. Display:
-- Name
-- Billing_Amount
select
`name` ,
Billing_Amount 
from hospital
where Billing_Amount = (
select max(Billing_Amount)
from hospital
);

-- Subquery with IN
-- Find all patients whose Doctor has treated at least 10 patients.
-- Hint: First find doctors with at least 10 patients, then find the patients belonging to those doctors.
select
`name` ,
Doctor 
from hospital
where doctor in (
select Doctor
from hospital
group by Doctor
having count(*) >= 1
) ;

-- Subquery + AVG()
-- Find patients whose age is greater than the average age of patients with Diabetes. Display:
-- Name
-- Age
-- Medical_Condition
select
`name` ,
age ,
Medical_Condition
from hospital
where age > (
select avg(age)
from hospital
where Medical_Condition = 'Obesity');


-- EXISTS
-- Find patients whose doctor exists in the doctors table. Display:
-- Name
-- Doctor
select
`name` ,
h.doctor
from hospital as h
where exists (
select 1
from doctors as d
where d.doctor = h.doctor);


-- Correlated Subquery
-- Find patients whose billing amount is greater than the average billing amount for their own medical condition. Display:
-- Name
-- Medical_Condition
-- Billing_Amount
 select
`name` ,
Medical_Condition ,
Billing_Amount
from hospital as h
where Billing_Amount > (
select avg(h2.Billing_Amount)
from hospital as h2
where h2.Medical_Condition = h.Medical_Condition) ;

-- Basic CTE
-- Using a CTE, calculate the average billing amount for each medical condition. Your result should contain:
-- Medical_Condition
-- Average_Billing
 WITH condition_billing AS (
    SELECT
        Medical_Condition,
        AVG(Billing_Amount) AS Average_Billing
    FROM hospital
    GROUP BY Medical_Condition
)
SELECT
    Medical_Condition,
    Average_Billing
FROM condition_billing ;


-- CTE + Filtering  Using a CTE:
-- Calculate the average billing amount for each medical condition.
-- Then display only conditions whose average billing is greater than 25,000.
WITH condition_billing AS (
    SELECT
        Medical_Condition,
        AVG(Billing_Amount) AS Average_Billing
    FROM hospital
    GROUP BY Medical_Condition
)
SELECT
    Medical_Condition,
    Average_Billing
FROM condition_billing
WHERE Average_Billing > 25000 ;


-- UNION vs UNION ALL
-- Create one result containing the names of patients who have:
-- Diabetes or Cancer
SELECT `Name`
FROM hospital
WHERE Medical_Condition = 'Diabetes'
UNION
SELECT `Name`
FROM hospital
WHERE Medical_Condition = 'Cancer' ;

SELECT `Name`
FROM hospital
WHERE Medical_Condition = 'Diabetes'
UNION ALL
SELECT `Name`
FROM hospital
WHERE Medical_Condition = 'Cancer' ;

-- Using a CTE:
-- Calculate each doctors:
-- total patients
-- average billing
-- average patient age
-- Then display only doctors who:
-- have at least 2 patients
-- have an average billing greater than 25,000
-- have more than 10 years of experience
-- Display:
-- Doctor
-- Total_Patients
-- Average_Billing
-- Average_Age
-- Experience
with doctor_stats as (
select
d.doctor ,
count(*) as total_patients ,
avg(h.Billing_Amount) as average_billing ,
avg(h.age) as average_age ,
d.years_of_experience as experience 
from hospital as h
inner join doctors as d
on h.doctor = d.doctor
group by 
d.doctor ,
d.years_of_experience
)
select
doctor ,
total_patients ,
average_billing ,
average_age , 
experience
from doctor_stats
where total_patients >= 2
and average_billing > 25000
and experience > 10 ;

-- Basic ROW_NUMBER()
-- Assign a unique row number to every patient based on their Billing_Amount from highest to lowest. Display:
-- Name
-- Billing_Amount
-- Row_Number
select
`name` ,
Billing_Amount ,
row_number() over(order by Billing_Amount desc) as row_numbers
from hospital ;

-- ROW_NUMBER() + PARTITION BY
-- Assign a row number to patients within each Medical_Condition, ranking them by billing amount from highest to lowest. Display:
-- Name
-- Medical_Condition
-- Billing_Amount
-- Row_Number
select
`name` ,
Billing_Amount ,
Medical_Condition ,
row_number() 
over( partition by Medical_Condition order by Billing_Amount desc) as row_numbers
from hospital ;

-- RANK()
-- Rank all patients according to their Billing_Amount from highest to lowest. Display:
-- Name
-- Billing_Amount
-- Billing_Rank
select
`name` ,
Billing_Amount ,
rank() 
over(order by Billing_Amount desc) as biling_rank
from hospital ;

-- DENSE_RANK()
-- Rank patients according to their billing amount from highest to lowest using DENSE_RANK(). Display:
-- Name
-- Billing_Amount
-- Billing_Rank
select
`name`,
Billing_Amount,
dense_rank() over(
order by Billing_Amount desc
    ) as Billing_Rank
from hospital;


-- Rank Patients Within Each Medical Condition 
-- For every medical condition, rank patients according to their Billing_Amount from highest to lowest. Display:
-- Name
-- Medical_Condition
-- Billing_Amount
-- Rank
select
`name` ,
Medical_Condition ,
Billing_Amount ,
rank() 
over( partition by Medical_Condition order by Billing_Amount desc) as `rank`
from hospital ;

-- Window AVG() 
-- Display every patients:
-- Name
-- Medical Condition`
-- Billing Amount
-- Average billing amount for their medical condition
select
`name` ,
Medical_Condition ,
Billing_Amount ,
avg(Billing_Amount) over (partition by Medical_Condition) as condition_average 
from hospital ;

-- Compare Patient Billing With Condition Average. Display:
-- Name
-- Medical_Condition
-- Billing_Amount
-- Average_Billing
-- Difference
select
`name` ,
Medical_Condition ,
Billing_Amount ,
avg(Billing_Amount) 
over (partition by Medical_Condition ) as average_billing ,

Billing_Amount - avg(Billing_Amount) over (partition by Medical_Condition) as difference
from hospital ;

-- Running Total 
-- Calculate a running total of billing amounts ordered by Date_of_Admission. Display:
-- Name
-- Date_of_Admission
-- Billing_Amount
-- Running_Total
select
`name`,
`Date of Admission`,
Billing_Amount,
sum(Billing_Amount) over (
order by `Date of Admission`) as Running_Total
from hospital;

-- LAG() 
-- For each patient, display their billing amount and the billing amount of the previous patient according to admission date. Display:
-- Name
-- Date_of_Admission
-- Billing_Amount
-- Previous_Billing
select
`name` ,
`Date of Admission` ,
Billing_Amount ,
lag(Billing_Amount) over(order by `Date of Admission`) as previous_billing
from hospital ;

-- For each Medical_Condition, find the top 3 patients by Billing_Amount. Display:
-- Medical_Condition
-- Name
-- Billing_Amount
-- Rank
with ranked_patients as (
select
Medical_Condition ,
`name`,
Billing_Amount ,
rank() over(partition by Medical_Condition order by Billing_Amount desc) as `rank` 
from hospital
)
select
Medical_Condition ,
`name` ,
Billing_Amount ,
`rank` 
from ranked_patients
where `rank` <= 3
order by Medical_Condition , `rank` ;