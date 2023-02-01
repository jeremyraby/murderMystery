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
