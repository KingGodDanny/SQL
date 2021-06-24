/*기본 SQL Practice01*/

--문제1 (Order by)
select first_name || last_name 이름,
       salary 월급,
       phone_number 전화번호,
       hire_date 입사일
from employees
order by hire_date ASC;


--문제2 (from jobs)
select job_title 업무이름,
       max_salary 최고월급
from jobs
order by max_salary DESC;


--문제3 (Null)
select first_name as 이름,
       manager_id as 아이디,
       commission_pct as 커미션비율,
       salary as 월급
from employees
where commission_pct is null
and salary>3000;


--문제4 (ASC & DESC)
select job_title 이름,
       max_salary 최고월급
from jobs
where max_salary >= 10000
order by max_salary DESC;


--문제5 (nv1)
select first_name 이름,
       salary 월급,
       nvl(commission_pct, 0) 커미션비율
from employees
where salary >= 10000
and salary < 14000
order by salary DESC;


--문제6 (to_char & in)
select first_name 이름,
       salary 월급,
       to_char(hire_date, 'YYYY-MM') 입사일,
       department_id 부서번호
from employees
where department_id in (10, 90, 100);


--문제7 (like %)
select first_name 이름,
       salary 월급
from employees
where first_name like '%S%'
or first_name like '%s%';


--문제8 (length)
select *
from departments
order by length(department_name) desc;


--문제9 Upper(대문자) , Lower(소문자)
select upper(country_name)
from countries
order by country_name asc;


--문제10 replace(select , '~에서' , '~로') 
select first_name 이름,
       salary 월급,
       replace(phone_number, '.', '-') 전화번호,
       hire_date 입사일
from employees
where hire_date <= '03/12/31' ;
