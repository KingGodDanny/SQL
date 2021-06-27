--21/06/27 

/*그룹함수*/
--Count() , Sum() , Avg() , Max() , Min()
select count(*) "전체갯수",             
       count(commission_pct) "Null제외Count",   
       sum(commission_pct) "전체합계",                
       avg(commission_pct) "Null제외한 평균",
       sum(commission_pct)/count(commission_pct) "전체합계/Null제외Comis",       
       avg(nvl(commission_pct, 0)) "Null값 0으로 변환", 
       sum(commission_pct)/count(*),
       max(salary) "제일 높은 월급",
       min(salary) "제일 낮은 월급"
from employees;

--유의사항
select count(*),     --Count()는 총갯수를 한줄에 숫자로 표현하는데
       first_name    --first_name은 각 이름들을 전부 출력하기때문에 실행이 불가능하다.
from employees;


/*Group by - Having 복습 및 연습문제*/
--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
--Group by에 조건을 쓰기위해서는 Where이 아닌 Having을 써야한다.
--추가로 조건을 쓰기위해서는 반드시 from밑에 Where절을 써야한다.
--Having절에 and로 또 다른 컬럼의 조건을 써주기위해서는 Group By에도 추가해줘야한다.
select department_id 부서번호,
       count(*) 총인원수,
       sum(salary) 급여합계
from employees
group by department_id
having sum(salary) >= 20000;


select department_id, --부서번호는 있는대로 출력되고
       avg(salary)    --그룹함수Avg(salary)는 한줄에 평균이 출력되는데 실행되는 이유는  
from employees        --Group By로 부서번호를 묶어서 각 부서마다의 평균이 출력되기때문이다.
group by department_id              
order by department_id asc;


select department_id,    --Group by에 참여한 칼럼은 Select절에 그룹함수와 같이 올수있다.
       --job_id,         --job_id같은경우에 그룹으로 묶인 부서번호와 잡아뒤의숫자가 같을수도
       count(*),         --있지만 변할수도있기때문에 함께 출력할수있다.
       sum(salary) 
from employees
group by department_id;


--Case ~ End 문
select employee_id,
       job_id,
       salary,
       case   --컬럼의 특정 이름들에 대해서만 then 값으로 변경해주는것
            when job_id ='AC_ACCOUNT' then '팀해체'   --이렇게 문자열출력과
            when job_id ='SA_REP' then salary+salary*0.2  --산술이 섞인 출력은 불가능해보임
            when job_id ='ST_CLERK' then salary+salary*0.3
            else salary
       end realSalary
from employees;


--Decode()
select employee_id,
       job_id,
       salary,
       Decode(    --조건이 다 같을때 Decode를 사용할수 있다.
            job_id, 'AC_ACCOUNT', salary+salary*0.1,
                    'SA_REP', salary+salary*0.2,
                    'ST_CLERK', salary+salary*0.3,
            salary
       ) as realSalary    
from employees;


--join  기본키가 겹치는 경우(?)가 있다면 From을 2가지 이상도 사용가능한것(?)

select first_name,   --컬럼앞에 변수명을 안써주는 이유는 한 테이블의 고유의 컬럼이기때문이다.
       hire_date, 
       department_name,
       em.department_id,    --반드시 어느 테이블의 컬럼을 출력해줄것인지 잘 파악하고 코딩할것!
       de.manager_id    
from employees em,   --테이블의 변수명같은 개념인듯..
     departments de
where em.department_id = de.department_id;  --변수명을 잘이용하면 컬럼.컬럼의 길이를 줄일수있다.

--출력하면 Employees의 Count(*)가 107개 이므로 DepartMents와 매칭하고 107개가 출력되야하는데
--106개만 나오는 이유는 Null은 매칭되지않고 포함이안됐기때문이다.