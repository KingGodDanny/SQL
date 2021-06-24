--21/06/24 select , from , where 연습문제

select first_name,
       phone_number,
       hire_date,
       salary
from employees;


select first_name,
       last_name,
       salary,
       phone_number,
       email,
       hire_date
from employees;


select employee_id as 사원번호,
       first_name 이름,
       last_name 성,
       salary 월급,
       phone_number 전화번호,
       email 이메일,
       hire_date 입사일
from employees;


select job_id*12   --job_id는 숫자가 아니기때문에 연산을 사용할수없다.
from employees;  


select first_name || '-' || last_name as 성명,
       salary 급여,
       salary*12 연봉,
       salary*12+5000 연봉2,
       phone_number 전화번호
from employees;


select first_name,
       salary
from employees
where salary >= 15000;


select first_name,
       hire_date
from employees
where hire_date >= '07/01/01';  


select salary
from employees
where first_name = 'Lex';


select first_name,
       salary
from employees
where salary <= 14000
or salary >= 17000;


select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';


select first_name,
       salary
from employees
where salary in (2100, 3100, 4100, 5100);


select first_name,
       salary
from employees
where first_name like '%am%';


select first_name,
       salary
from employees
where first_name like '_a%';


select first_name
from employees
where first_name like '___a%';


select first_name,
       salary
from employees
where first_name like '%__a_';