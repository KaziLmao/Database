create database lab3;
select * from courses where credits > 3;
select * from classroom where (building  = 'Watson' or building 'Packard');
select * from course where dept_name = 'Comp.Sci';
select * from course,section where course.course.id = section.course.id and section.semester = 'Fall';
select * from student where total_credit > 45 and total_credit < 90;
select * from student where name like '%a' or name like '%e' or name like '%i' or name like '%o' or name like '%u';
select * from course,prereq where course.course.id = prereq.course id and prereq = 'CS-101';
--a
select depy_name, average(salary)
from instructor
group by dept_name
order by average(salary);
--b
select ans.building,max(count_course_id)
from (select count(course_id) as count count_course_id,building from section group by building) as ans
group by ans.building;
--c
select dept_name,(select count(*) from course where department.dept_name = course.dept_name) as num_courses
from department
order by num_courses
--d
select t.id, s.name
where course.course.id = takes.course.id and course.course.id = 'Comp.Sci' and student.id = take.id
group by student.name,takes.id;
having count(*) > 3;
--e
select name,dept_name from instructor where dept_name ='Biology' or dept_name = 'Music' or dept_name= 'Philosophy';
--f
select distinct id from teaches where year  = 2018 and id not in (select id from teaches where year = 2017);

--ex3
--a
select name,coure_id
from takes,student,course
where takes.course.id = course.course.id and takes.id = student.id and course.dept_name = 'Comp.Sci'
and (takes.grade = 'A' or takes.grade = 'A-')
order by name;
--b
select instructor.name = advisor.i_id and student.id = advisior.s_id and takes.id = student.id
and (takes.grade = 'B-' or takes.grade = 'C+' or takes.grade = 'C' and takes.grade = 'C-' and takes.grade = 'F');

--c
select distinct (id),course_id,grade
from takes where grade= 'A' or grade = 'A-' or grade = 'B' or grade = 'B-' or grade = 'A+' or grade = 'B+';
--d

--e
select section.course_id,time_slot.end_hr
from section, time_slot where section.time_slot_id = time_slot.time_slot_time_id and end_hr < 13;