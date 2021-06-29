/* 21/06/29 SQL_혼합 문제 */

--문제1.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요. (45건)
select emp.first_name,
       emp.manager_id,
       emp.commission_pct,
       emp.salary
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