/*
A crime has taken place and the detective needs your help. The detective gave you the 
crime scene report, but you somehow lost it. You vaguely remember that the crime was a 
​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by 
retrieving the corresponding crime scene report from the police department’s database.
*/

-- Find the crime scene report
SELECT * 
FROM crime_scene_report 
WHERE type = 'murder' AND date = 20180115 AND city = 'SQL City';

/*
CRIME SCENE REPORT DESCRIPTION
Security footage shows that there were 2 witnesses. The first witness lives at the last 
house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on 
"Franklin Ave".
*/

-- Find the witness interviews 
SELECT
	pers.id,
	pers.name,
	ints.transcript
FROM interview ints
LEFT JOIN person pers
ON ints.person_id = pers.id
WHERE
	(pers.name LIKE 'Annabel%' AND pers.address_street_name = 'Franklin Ave') OR 
	pers.address_street_name = 'Northwestern Dr';

/*
INTERVIEW TRANSCRIPT FOR FIRST WITNESS ON 'Northwestern Dr.' (Morty Schapiro)

I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The 
membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W".
*/

/*
INTERVIEW TRANSCRIPT FOR SECOND WITNESS NAMED 'ANNABEL' & LIVES ON 'FRANKLIN AVE'
(Annabel Miller)

I saw the murder happen, and I recognized the killer from my gym when I was working out 
last week on January the 9th.
*/

-- Find gym member with member number starting with '48Z'
SELECT
	member.id,
	member.name,
	checkIn.check_in_date
FROM get_fit_now_check_in checkIn
LEFT JOIN get_fit_now_member member
ON checkIn.membership_id = member.id
WHERE 
	checkIn.check_in_date = 20180109 AND
	member.id LIKE '48Z%'

/*
SUSPECTS BASED ON GYM MEMBERSHIP ID WHO CHECKED IN 1/9/2018

48Z7A	Joe Germuska
48Z55	Jeremy Bowers
*/

-- Find J. Germuska's & J. Bowers' person IDs
SELECT
	person.id AS 'person id',
	member.id AS 'member id',
	member.name
FROM get_fit_now_member member
LEFT JOIN person
ON member.person_id = person.id
WHERE 
	member.id = '48Z7A' OR member.id = '48Z55';

-- 67318 Jeremy Bowers
-- 28819 Joe Germuska

-- Compare J. Germuska's & J. Bowers' person IDs to their license plates
SELECT
	person.id,
	person.name,
	dLic.plate_number
FROM person
LEFT JOIN drivers_license dLic
ON dLic.id = person.license_id
WHERE 
	person.name LIKE '%Bowers' OR 
	person.name LIKE '%Germuska'AND
	dLic.plate_number LIKE '%H42W%';

-- 67318 Jeremy Bowers 0H42W2

/*
Congrats, you found the murderer! But wait, there's more... If you think you're up for a 
challenge, try querying the interview transcript of the murderer to find the real villain 
behind this crime. If you feel especially confident in your SQL skills, try to complete this 
final step with no more than 2 queries. Use this same INSERT statement with your new suspect 
to check your answer.
*/

-- Check J. Bowers' interview transcript
SELECT
	person_id,
	transcript
FROM interview
WHERE person_id = 67318;

/*
I was hired by a woman with a lot of money. I don't know her name but I know she's around 
5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she 
attended the SQL Symphony Concert 3 times in December 2017.
*/

-- Find women matching physical description and driving a Tesla Model S
SELECT
	person.id,
	person.name
FROM person
LEFT JOIN drivers_license
ON person.license_id = drivers_license.id
WHERE 
	drivers_license.gender = 'female' AND
	drivers_license.hair_color = 'red'AND
	drivers_license.height BETWEEN 65 AND 67 AND
	drivers_license.car_make = 'Tesla' AND
	drivers_license.car_model = 'Model S'

/*
id	name
78881	Red Korb
90700	Regina George
99716	Miranda Priestly
*/

-- Check which suspect attended SQL Symphony Concert x3 in Dec 2017

