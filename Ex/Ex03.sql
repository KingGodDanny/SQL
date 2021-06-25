/*그룹함수*/

--단일행함수
select first_name,
       round(salary, -4)
from employees;


--그룹함수  --> 오류발생(반드시 이유를 확인할것!!!)
select avg(salary)  --이름은 여러개가 나오지만
     --first_name  --avg는 모든 월급의 평균이기때문에 실행이 불가능하다.
from employees;     --출력되는 양쪽의 개수가 맞아야한다.


--그룹함수 avg()
select avg(salary)
from employees;


--그룹함수 avg() null일때 0으로 변환해서 사용
select count(*),                --전체갯수 107개
       count(commission_pct),   --35개  commission_pct 값이 있는 직원
       sum(commission_pct),         --전체합계
       
       avg(commission_pct),         --commission_pct가 null사람을 포함여부? -->null 포함X
       sum(commission_pct)/count(commission_pct),  --null 제외  7.8/35
       
       avg(nvl(commission_pct, 0)),  --null을 0으로 변경하여 전체수 포함
       sum(commission_pct)/count(*)  --null을 포함   7.8/107       
from employees;


--그룹함수 count()
select count(*),              --null을 포함한 count
       count(first_name),     --컬럼명 사용시 0은 갯수에 포함된다!
       count(commission_pct)  --Null을 제외한 실제가지고있는 값의 갯수출력
from employees;


--count()에 조건절 추가
select count(*)
from employees
where salary > 16000;


--그룹함수 sum()
select sum(salary),
       count(*)
     --first_name  넣었을 시 에러가난다
from employees;


--그룹함수  max() min()
select max(salary),
       min(salary)
from employees;

select first_name,
       salary
from employees
order by salary desc;

select --first_name,      오류발생! 이름과 max의 출력갯수가 다름!
       max(salary)
from employees;


/* group by 절 */
--전체 부서, 급여 출력
select department_id,
       salary
from employees
order by department_id asc;

--부서번호, 부서별 평균
select department_id, avg(salary)   --first_name은 avg와 갯수가 맞지않아 오류가 나지만
from employees                      --department_id는 그룹바이 department_id로 묶었기때문에
group by department_id              --가능하다
order by department_id asc;


-- Group by 절 사용시 주의사항!@#!@#
--Select 절에는 Group by에 참여하는 컬림이나 그룹함수만 올 수 있다.
select department_id, count(*), sum(salary) --group by로 컬럼들을 출력하라
from employees
group by department_id; --Group by에 쓴 컬럼은 select에서 쓸수있다.

select department_id,
       --job_id,         --Group by된 department_id의 갯수와 같을수있지만 
       count(*),       --그렇지 않을수도있기때문에 오류가 난다.
       sum(salary) 
from employees
group by department_id;


--그룹을 더 세분화
select department_id,
       job_id,
       avg(salary)
from employees
group by department_id, job_id;

select avg(salary)
from employees
group by department_id;

--예제
--부서별 부서 번호와, 인원수, 급여합계를 출력하세요.
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id;


--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select department_id,
       count(*),
       sum(salary)
from employees
--where sum(salary) >= 20000    --Where절에는 그룹함수를 쓸수가 없다.
group by department_id;


--그룹전용 Where절 --> Having절
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;


select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000;
--and job_id = 'IT_PROG';
--위처럼 해빙절에 and하고 쓸수있는건 Group by해준 칼럼만 쓸수있다.
--쓰려면 아래 방법을 써야한다.

select department_id,
       job_id,
       count(*),
       sum(salary)
from employees
group by department_id, 
         job_id
having sum(salary) >= 20000
and job_id = 'IT_PROG';


/*
select 문
    select 절
    from 절
    where 절
    group by 절
    having 절
    order by 절
*/

--Case ~ End 문
select employee_id,
       job_id,
       salary,
       case      --if else랑 비슷한 문법
            when job_id ='AC_ACCOUNT' then salary+salary*0.1
            when job_id ='SA_REP' then salary+salary*0.2
            when job_id ='ST_CLERK' then salary+salary*0.3
            else salary
       end realSalary
from employees;

--Decode()
select employee_id,
       job_id,
       salary,
       Decode(  --모두 job_id ==의 조건이라면 DECODE문 가능!@#!@@!#
            job_id, 'AC_ACCOUNT', salary+salary*0.1,
                    'SA_REP', salary+salary*0.2,
                    'ST_CLERK', salary+salary*0.3,
            salary
       ) as realSalary    
from employees;

