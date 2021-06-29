/* 21/06/29 서브쿼리(SUBQUERY) SQL 문제 */

--문제1.
--평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요. (56건)
select count(employee_id)
from employees
where salary < (select avg(salary)
                from employees);


--문제2. 
--평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 
--최대급여를 급여의 오름차순으로 정렬하여 출력하세요 (51건)
select employee_id,
       first_name,
       salary       
from employees
where salary >= (select avg(salary)                      
                from employees)     
and salary <= (select max(salary)
               from employees)
order by salary asc;


select em.employee_id,
       em.first_name,
       em.salary,
       emh.avgS,
       emh.maxS
from employees em , (select avg(salary) avgS,
                            max(salary) maxS
                     from employees) emh
where em.salary >= emh.avgS
and em.salary <= emh.maxS
order by em.salary asc;


--문제3.
--직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 
--있는 곳의 주소를 알아보려고 한다. 도시아이디(location_id), 
--거리명(street_address), 우편번호(postal_code), 도시명(city), 
--주(state_province), 나라아이디(country_id) 를 출력하세요 (1건)
select lo.location_id 도시아이디,
       lo.street_address 거리명,
       lo.postal_code 우편번호,
       lo.city 도시명,
       lo.state_province 주,
       lo.country_id 나라아이디
from (select first_name || last_name,
             department_id
     from employees
     where first_name = 'Steven'
     and last_name = 'King') em,
     departments de,
     locations lo
where lo.location_id = de.location_id
and de.department_id = em.department_id;


--문제4.
--job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 
--급여의 내림차순으로 출력하세요  -ANY연산자 사용  (74건)
select salary
from employees
where job_id = 'ST_MAN';

select department_id 사번,
       first_name 이름,
       salary 급여
from employees
where salary < Any ( select salary
                     from employees
                     where job_id = 'ST_MAN' )
order by salary desc;


--문제5. 
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 
--이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--조건절비교, 테이블조인 2가지 방법으로 작성하세요 (11건)

/*조건절사용*/
select department_id,
       max(salary)
from employees
group by department_id;


select employee_id 직원번호,
       first_name 이름,
       salary 급여,
       department_id 부서번호
from employees
where (department_id,salary) in (select department_id,
                        max(salary)
                 from employees
                 group by department_id)
order by salary desc;

/*테이블조인 사용*/
select em.employee_id 직원번호,
       em.first_name 이름,
       em.salary 급여,
       em.department_id 부서번호
from employees em , (select department_id,
                            max(salary) mSal
                     from employees
                     group by department_id) dem
where em.department_id = dem.department_id
and em.salary = dem.msal
order by salary desc;


--문제6.
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오. (19건)
select jo.job_title,
       em.sums
from jobs jo , (select sum(salary) sumS ,
                       job_id
                from employees
                group by job_id) em
where jo.job_id = em.job_id
order by em.sums desc;
                

--문제7.
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 
--이름(first_name)과 급여(salary)을 조회하세요 (38건)
select em.employee_id 직원번호,
       em.first_name 이름,
       em.salary 급여
from employees em , (select department_id,
                            avg(salary) avgS
                     from employees
                     group by department_id) emA
where em.department_id = ema.department_id
and em.salary > ema.avgs;


--문제8.
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
select employee_id,  --제일 안쪽의 테이블
       first_name,
       salary,
       hire_date
from employees
order by hire_date asc;
             

select rowT.rn,
       rowT.employee_id 사번,
       rowT.first_name 이름,
       rowT.salary 급여,
       rowT.hire_date 입사일
from (select rownum rn,
             orderT.employee_id,
             orderT.first_name,
             orderT.salary,
             orderT.hire_date
      from (select employee_id,
                   first_name,
                   salary,
                   hire_date
            from employees
            order by hire_date asc) orderT
            ) rowT
where rowT.rn >= 11
and rowT.rn <=15;