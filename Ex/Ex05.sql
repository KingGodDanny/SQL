/* Sub Query */

--단일행
-- 'Den'의 월급  --> 11000
select salary
from employees
where first_name = 'Den';

-- 급여가 11000 이상인 직원들
select first_name,
       salary
from employees
where salary >=11000;


select first_name,
       salary
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');