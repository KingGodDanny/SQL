--21/06/26 null, order by 연습문제 , 문자, 숫자, 날짜, 변환함수

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
       commission_pct
from employees
where commission_pct is not null;


--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null
and commission_pct is null;


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select department_id 부서번호,
       salary 급여,
       first_name 이름
from employees
order by department_id asc;


--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name 이름,
       salary 급여
from employees
where salary >= 10000
order by salary desc;


--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select department_id 부서번호,
       salary 급여,
       first_name 이름
from employees
order by department_id asc,    --오름차순 정렬하구 혹시나 같다면
salary desc;                   --급여 내림차순


/*문자함수*/
-- Initcap() 첫글자만 대문자로 출력
select INITCAP(first_name) "Name",
       INITCAP(email) "Email"
from employees
where salary > 10000;


-- Upper()전부 대문자 / Lower() 전부 소문자
select Upper(first_name) "NAME",
       Lower(email) "email"
from employees;


-- SubStr(칼럼 , 문자열 몇번째, 몇번째까지)  
select first_name,
       substr(first_name , 3 , 2)
from employees
where first_name = 'David'
or first_name = 'Ellen';


-- LPAD() / RPAD()
select first_name,
       LPAD(first_name, 7, '@'),
       RPAD(first_name, 8, '&')
from employees;


-- Replace(컬럼, 문자열1, 문자열2로 바꾸기)
select first_name,
       REPLACE(first_name, 'e', '★')
from employees;


/*숫자함수*/
--Round() , TRUNC()
select commission_pct,
       round(commission_pct, 1) "ROUND()",      --소수점 첫번째자리까지 반올림
       trunc(commission_pct, 1) "TRUNC()"       --소수점 1째자리까지만 두고 다버림
from employees
where commission_pct is not null;


/*날짜함수*/
--MONTH_BETWEEN(컬럼1, 컬럼2) 컬럼1과 컬럼2의 개월수차이 
select sysdate, 
       hire_date, 
       MONTHS_BETWEEN(SYSDATE,hire_date), 
       round(MONTHS_BETWEEN(SYSDATE,hire_date), 0)
from employees;


/*변환함수*/
--to_char() 
select first_name,
       salary*30,
       to_char(salary*30,'999,999')   -- ￦은 되지않음.
from employees
where department_id = 110;


select hire_date,
       to_char(hire_date, 'YYYY"*"mm"*"dd HH24"시"MI"분"SS"초"')
from employees;


--nvL() / nvL2(칼럼, null이 아닌 값 변경출력, null인 값변경 출력)
select commission_pct,
       nvl(commission_pct, 100),
       nvl2(commission_pct, 123123, 777)
from employees;
