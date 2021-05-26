/* 
1. Explicitly query for wanted fields instead of *
2. Use left and inner join instead of where clause
3. When joining, use index instead of value
*/
select student.student_id, course.course_id, semester.semester_year, semester.semester_name, course_reg.course_grade, avg(course_reg.course_grade) as sem_gpa
from 
/* Use index scans for student i.e. student_id */
(select student_id where student_id = 'UA1234567') as student
/* Use left join to only query one specific student_id */
left join student_course_register as course_reg
on student.student_id = course_reg.course_id
/* Use where clause to specify successful course registration */
where course_register_status = 'Successful'
/* Use inner join to only query one specific student_id related rows*/
inner join course
on course_reg.course_id = course.course_id
inner join course_semester_register as sem_reg
on course.course_id = sem_reg.course_id
inner join semester
/* Use where clause to specify the semester wanted */
on sem_reg.semester_id = semester_semester_id
where semester_year = '2021' and semester_name = 'Sem A'