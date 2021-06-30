/* 21/06/29 SQL_혼합 문제 */

--문제1.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요. (45건)
select emp.first_name 이름,
       emp.manager_id 매니저아이디,
       emp.commission_pct 커미션비율,
       emp.salary 월급
from employees emp,
     employees man
where emp.manager_id = man.employee_id
and emp.commission_pct is null
and emp.salary > 3000;


--문제2. 
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 
--급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 
--조회하세요 
---조건절비교 방법으로 작성하세요
---급여의 내림차순으로 정렬하세요
---입사일은 2001-01-13 토요일 형식으로 출력합니다.
---전화번호는 515-123-4567 형식으로 출력합니다. (11건)
select employee_id 직원번호,
       first_name 이름,
       salary 급여,
       to_char(hire_date, 'YYYY-MM-DD DAY') 입사일,
       replace(phone_number, '.' , '-') 전화번호,
       department_id 부서번호
from employees
where (department_id,salary) in (select department_id,
                                        max(salary)
                                 from employees
                                 group by department_id)
order by salary desc;


--문제3
--매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
---통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
---매니저별 평균급여가 5000이상만 출력합니다.
---매니저별 평균급여의 내림차순으로 출력합니다.
---매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
---출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 
--매니저별최대급여 입니다. (9건)
select ,
       avg(salary),
       min(salary),
       max(salary)
from employees
group by manager_id;

select *
from employees emp;


--문제4.
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
--부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다. (106명)
select em.employee_id 사번,
       em.first_name 이름,
       de.department_name 부서명,
       ma.first_name 매니저이름
from employees em,
     employees ma,
     departments de
where em.manager_id = ma.employee_id
and em.department_id = de.department_id(+);

--Left Outer Join 
select em.employee_id 사번,
       em.first_name 이름,
       de.department_name 부서명,
       ma.first_name 매니저이름
from employees em Left OUTER JOIN departments de
   ON em.department_id = de.department_id,
     employees ma
where ma.employee_id = em.manager_id;


--문제5.
--2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
--정렬을 하고 > RowNum 하고 > 조건

--정렬
select em.employee_id 사번,
       em.first_name 이름,
       de.department_name 부서명,
       em.salary 급여,
       em.hire_date 입사일
from employees em,
     departments de
where em.department_id = de.department_id
and em.hire_date > '2004/12/31'
order by hire_date asc;

--정렬 + RowNum
select rownum rNum,
       ort.employee_id 사번,
       ort.first_name 이름,
       ort.department_name 부서명,
       ort.salary 급여,
       ort.hire_date 입사일
from (select em.employee_id,
             em.first_name,
             de.department_name,
             em.salary,
             em.hire_date
      from employees em,
           departments de
      where em.department_id = de.department_id
        and em.hire_date > '2004/12/31'
      order by hire_date asc) ort;
      

--정렬 + RowNum + Where절
select rort.rNum,
       rort.employee_id 사번,
       rort.first_name 이름,
       rort.department_name 부서명,
       rort.salary 급여,
       rort.hire_date 입사일
from (select rownum rNum,
             ort.employee_id,
             ort.first_name,
             ort.department_name,
             ort.salary,
             ort.hire_date
       from (select em.employee_id,
                    em.first_name,
                    de.department_name,
                    em.salary,
                    em.hire_date
             from employees em,
                  departments de
             where em.department_id = de.department_id
               and em.hire_date > '2004/12/31'
             order by hire_date asc) ort
        ) rort
where rort.rNum >= 11
and rort.rNum <= 20;


--문제6.
--가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 
--근무하는 부서 이름(department_name)은?
select em.first_name ||' '|| em.last_name 이름,
       em.salary 연봉,
       de.department_name 부서이름,
       em.hire_date
from employees em,
     departments de
where em.hire_date in (select max(hire_date)
                         from employees)
and em.department_id = de.department_id;


--문제7.
--평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 
--성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
select em.employee_id 사번,
       em.first_name 이름,
       em.last_name 성,
       em.salary 급여,
       rasa.asal,
       jo.job_title
from employees em, (select rownum rn,
                           asal,
                           department_id
                    from (select avg(salary) aSal,
                                 department_id
                          from employees
                          group by department_id
                          order by avg(salary) desc) asa 
                    ) rasa,
     jobs jo
where em.department_id = rasa.department_id
and jo.job_id = em.job_id
and rasa.rn = 1;


--문제8. ****수정하기****
--평균 급여(salary)가 가장 높은 부서는? 
select de.department_name
from employees em, (select  department_id,
                            max(avg(salary)) masa
                         
                           from employees
                           group by department_id ) asa ,
     departments de
where em.department_id = asa.department_id
and em.salary = asa.masa
and de.department_id = em.department_id;


select max(avg(salary))
from employees
group by department_id

                      