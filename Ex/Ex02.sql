--NULL

select first_name, 
       salary,
       commission_pct,
       salary*commission_pct
from employees
where salary between 13000 and 15000;

select first_name, 
       salary,
       commission_pct
from employees
where commission_pct is not null;

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
       salary,
       commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
SELECT first_name
from employees
where manager_id is null
and commission_pct is null;
--where manager_id || commission_pct is null;


--order by
select first_name,
       salary
from employees
order by salary desc;   --내림차순

select first_name,
       salary
from employees
order by salary asc;    --오름차순

select first_name,
       salary
from employees
order by salary asc , first_name asc;    --1순위 급여 오름차순 , 
                                         --급여가 동률일때 2순위 이름을 오름차순

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요          
select department_id,
       salary,
       first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name,
       salary
from employees
where salary >= 10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select department_id,
       salary,
       first_name
from employees
order by department_id asc, salary desc;


/*단일행 함수*/
--INITCAP(첫글자만 대문자)
select email, INITCAP(email), department_id
from employees
where department_id = 100; 

/*가상의 테이블*/
select INITCAP('aaaa')
from dual;

--lower(전부 소문자), upper(전부 대문자)
select first_name, lower(first_name), upper(first_name) 
from employees
where department_id = 100;

--substr()
select SUBSTR('ABCDEFG',3,2)    --3번째자리에서 2글자를 뜻함
from dual;

select first_name, SUBSTR(first_name,1,3) , SUBSTR(first_name,-3,2) --뒤에서 -3번째자리에서 2글자.
from employees
where department_id = 100;

--lpad() rpad()
select first_name, 
       LPAD(first_name, 10, '*'),
       rpad(first_name, 10, '#')
from employees;


--replace()
select first_name,
       REPLACE(first_name, 'a', '*'),
       replace(first_name, SUBSTR(first_name , 2, 3)  , '***')
from employees;

select first_name, SUBSTR(first_name , 2, 3)
from employees;

/*숫자함수*/
--round() 원하는 자릿수까지 반올림
select round(123.346, 2) as r2,   --소주점 둘째짜리까지 반올림해라
       round(123.346, 0) r0,
       round(124.343, -1)as "r-1",
       round(124.343, -2) as "r-2"
from dual;

--trunc() 원하는 자릿수까지 출력
select trunc(123.456, 2),
       trunc(123.956, 0),
       trunc(123.456, -1)
from dual;


--abs() 절대값출력
SELECT abs(-5)
from dual;

/*날짜 함수*/
select sysdate
from dual;

--MONTH_BETWEEN(d1, d2)
select sysdate, 
       hire_date, 
       trunc(MONTHS_BETWEEN(SYSDATE,hire_date), 0),
       round(MONTHS_BETWEEN(SYSDATE,hire_date), 0)
from employees;


/*변환함수*/
--to_char()
select first_name,
       salary*12,
       to_char(salary*12, '$999,999.99')
from employees
where department_id = 110;

---to_char() 숫자 -->문자열
select to_char(9876, '99999'),
       to_char(9876, '099999'),
       to_char(9876, '$9999'),
       to_char(9876, '9999.99'),
       to_char(987654321, '999,999,999'),
       to_char(987654321, '999,999,999.999')
from dual;

--to_char()날짜 -->문자열
select sysdate, 
       to_char(sysdate, 'yy-mm-dd HH24:MI:SS'),
       to_char(sysdate, 'yyyy mm dd'),
       to_char(sysdate, 'yyyy-mm-dd'),
       to_char(sysdate, 'yyyy"년" mm"월" dd"일"'),
       to_char(sysdate, 'yyyy'),
       to_char(sysdate, 'yy'),
       to_char(sysdate, 'MM'),
       to_char(sysdate, 'MONTH'),
       to_char(sysdate, 'DD'),
       to_char(sysdate, 'DAY'),
       to_char(sysdate, 'HH'),
       to_char(sysdate, 'HH24'),
       to_char(sysdate, 'MI'),
       to_char(sysdate, 'SS'),
       to_char(sysdate, '')
from dual;

--nv1() nv12()
select first_name, 
       commission_pct,
       NVL(commission_pct,0),
       NVL2(commission_pct, '값있음', '널')       
from employees;

select first_name,
       avg(salary)
from employees;