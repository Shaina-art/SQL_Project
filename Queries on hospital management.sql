--1)Write a query in SQL to find all the information of the nurses who are yet to be registered. 
select * from nurse
where registered = 'false';

--2)Write a query in SQL to find the name of the nurse who are the head of their department.
select * from nurse
where position='Head Nurse';

--3)Write a query in SQL to obtain the name of the physicians who are the head of each department.
select p.name , d.name from physician p 
inner join department d 
on p.employeeid=d.head;

--4)Write a query in SQL to count the number of patients who taken appointment with at least one physician.
select count (distinct (patient)) from appointment;

-- 5)Write a query in SQL to count the number unavailable rooms
select * from room;
select count(roomnumber) from room
where unavailable ='false';

-- 6)Write a query in SQL to count the number of available rooms.
select count(roomnumber) from room
where unavailable ='True';

-- 7)Write a query in SQL to obtain the name of the physician and the departments they are affiliated with. 
select employeeid,department, p.name as physician_name , d.name as department  from physician p 
inner join department d
on p.employeeid = d.head 
inner join affiliated_with a
on d.department_id=a.department
where primaryaffiliation ='t';

-- 8)Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.
select employeeid,name
from physician
where employeeid in (select distinct physician
                     from trained_in);

--9)Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.
select p.name as physician_name ,d.name as department_name from physician p
inner join affiliated_with aw
on p.employeeid = aw.physician
inner join department d
on aw.department = d.department_id
where primaryaffiliation='t';

--10)Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.
select p.name as patient_name , count(physician) as no_physician from patient as p 
inner join appointment as a 
on p.ssn=a.patient
inner join physician as phy
on phy.employeeid = a.physician
group by p.name;

--11)Write a query in SQL to obtain the name of the physicians who are not a specialized physician.
select name as not_specialized_physicians from physician 
where employeeid not in(select distinct physician from trained_in);

--12)Write a query in SQL to find the name of the patients, their treating physicians and medication
select distinct p.ssn,p.name as patient_name,ph.name as treating_phy_name,m.name as medicine_name
from patient p           --patient
inner join undergoes u   --undergoes table
on p.ssn = u.patient
inner join prescribes pr   --prescribes
on u.patient = pr.patient
inner join medication m       --medication
on pr.medication = m.code
inner join physician ph       --physician
on pr.physician = ph.employeeid;

--13)Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse.
select p.name as patient_name,ph.name as physician_name
from patient p
inner join undergoes u
on p.ssn = u.patient
inner join physician ph
on u.physician = ph.employeeid
where assistingnurse is null;

--14)Write a query in SQL to count the number of available rooms in each block
select blockcode as block_no,count(*) as no_of_available_rooms
from room
where unavailable='f'
group by blockcode;


