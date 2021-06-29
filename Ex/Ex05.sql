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


--11000(Den) 보다 많은 사람은? 
select first_name,
       salary
from employees
where salary >= (select salary
                 from employees
                 where first_name = 'Den');
    
                 
--예제) 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1. 급여를 가장 적게 받는 사람의 급여 --> 10000
select min(salary)
from employees;


--2. 2100을 받는 사람의 이름 급여 사원번호
select first_name,
       salary,
       employee_id
from employees
where salary = 2100;

--3. 2식을 조합
select first_name,
       salary,
       employee_id
from employees
where salary = (select min(salary)
                from employees);
                
                
--연습문제
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요
-- (1)
select avg(salary)    --6461.83
from employees;


-- (2)
select first_name,
       salary
from employees
where salary < 6461.83;


--3.  (1) + (2) 조합
select first_name,
       salary
from employees
where salary < (select avg(salary)
                from employees);
                

/* Where 절  IN 사용 */       
--예제
--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요.

--ex>(1).부서번호 110 = 마케팅팀 -> 이효리, 정우성, 유재석
--(2).이효리 급여 = 10000 / 정우성 급여 = 20000 / 유재석 급여 = 30000
--(1)+(2) 우리회사에서 급여서 10000,20000,30000인 직원의 이름과 급여를 출력하세요.

--(1)
select salary
from employees
where department_id = 110;

--(2)
select employee_id,
       first_name,
       salary
from employees
where salary = 12008
or salary = 8300;

--(1) + (2) 조합  IN 사용
select employee_id,
       first_name,
       salary
from employees
where salary in ( select salary
                  from employees
                  where department_id = 110);

-- in 자리에 =를 쓸 수 있는건 값이 하나라고 절대 변하지않을거라고 단정지을수
--있으면 쓰는것이다 Sum , Avg 이런 경우에 =를 사용할수있다.


--예제) 각 부서별로 최고급여를 받는 사원을 출력하세요
--(1) 그룹별 최고급여를 출력한다.
select department_id,
       max(salary)
from employees
group by department_id;

--(2) 사원테이블에서 그룹번호와 급여가 같은 직원의 정보를 구한다.
select first_name,
       salary
from employees
where (department_id,salary) in (select department_id,
                                 max(salary)
                                 from employees
                                 group by department_id);
                                 
--Where 절의 () 안에 컬럼의 순서와 in () 안의 
--Select 절의 컬럼 순서가 맞아야 비교가 된다.


/* Any (Or) 사용*/
--예제) 부서번호가 110인 직원의 급여*보다 큰* 모든 직원의
--     사번, 이름, 급여를 출력하세요. (or연산 --> 8300보다 큰)
--(1) 부서번호가 110인 직원리스트 급여 
select salary
from employees
where department_id = 110;

--(2)부서번호가 110인 급여 (12008, 8300) 보다 급여가 큰 직원리스트를 구하시오.
select employee_id,
       first_name,
       salary
from employees
where salary > Any (select salary
                    from employees
                    where department_id = 110);


/* ALL (And) 사용 */
--Any (or)가 12008, 8300의 기준으로 8300보다 큰이였으면
--ALL (and)는 결국 8300은 안되고 12008보다 큰것만 포함되는 것이다
select employee_id,
       first_name,
       salary
from employees
where salary > All (select salary
                    from employees
                    where department_id = 110);


--예제 (Where절 사용)
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서별 최고 급여 리스트 구하기
select department_id,
       max(salary)
from employees
group by department_id;

--2. 직원테이블 부서코드 , 급여가 동시에 같은 직원 리스트 출력하기
select first_name,
       department_id,
       salary
from employees
where (department_id, salary) in (select department_id, 
                                         MAX (salary)
                                  FROM employees
                                  GROUP BY department_id);
                                  
                    
-- Join으로 사용한 방법              
--각 부서별로 최고급여를 받는 사원을 출력하세요    
-- (1) 각 부서별 최고 급여 테이블 s
select department_id,
       max(salary)
from employees
group by department_id;

-- (2) 직원 테이블과 Join한다.  e
       -- e.부서번호 = s.부서번호 / e.급여 = s.급여(최고급여)
select e.employee_id,
       e.first_name,
       e.department_id,
       e.salary,
       s.department_id,
       s.mSalary
from employees e, (select department_id,
                          max(salary) mSalary
                   from employees
                   group by department_id ) s
where e.department_id = s.department_id
and e.salary = s.Msalary;


/****************************
RowNum
****************************/
--예제) 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--(1)정렬을 하면 RowNum이 비순차적으로 섞인다. (X) -->정렬하고 RowNum을한다.
select rownum,
       employee_id,
       first_name,
       salary
from employees
order by salary desc;


--정렬하고 RowNum을한다.
select rownum ,     --rownum은 컬럼이라기보다 자체적인 기능
       ot.employee_id,
       ot.first_name,
       ot.salary,
       ot.hire_date
from (select employee_id,  --셀렉트절의 시작같지만 결국 이러한 테이블로
             first_name,   --만들어진거기때문에 위에 셀렉트에 컬럼을 추가하고
             salary,       --싶다면 이곳에도 컬럼을 써줘야한다.
             hire_date
      from employees
      order by salary desc) ot   --정렬되어있는 테이블이라면?
where rownum >= 1   --RowNum >= 2로하면 출력이되지않는다.
and rownum <= 5;    --RowNum은 늘 1부터시작한다.


-- (1)정렬하고 RowNum을 하고 Where절을 한다.  (하나씩 차근차근해야함)

select ort.rn,
       ort.employee_id,
       ort.first_name,
       ort.salary
from (select rownum rn, 
             ot.employee_id,
             ot.first_name,
             ot.salary
      from (select employee_id,
                   first_name,
                   salary
            from employees
            order by salary desc) ot
            ) ort
where  rn>=2
and rn <= 5;



select *
from employees
order by salary desc;



select rownum,
       employee_id,
       first_name,
       salary
from employees
where rownum >= 1
and rownum <= 5
order by salary desc;


--예제)07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
select ort.rn,
       ort.first_name,
       ort.salary,
       ort.hire_date
from (select rownum rn ,
       rt.first_name,
       rt.salary,
       rt.hire_date
      from (select first_name,
                   salary,
                   hire_date
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31'
            order by salary desc
            ) rt
      ) ort
where rn >= 3
and rn <= 7;

--To_char를 이용한 Hire_Date 값 넣는 방법
select ort.rn,
       ort.first_name,
       ort.salary,
       ort.hire_date
from (select rownum rn ,
       rt.first_name,
       rt.salary,
       rt.hire_date
      from (select first_name,
                   salary,
                   hire_date
            from employees
            where to_char(hire_date, 'YYYY') = '2007'
            order by salary desc
            ) rt
      ) ort
where rn >= 3
and rn <= 7;