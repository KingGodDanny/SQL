/*from절 select절*/
--모든 컬럼 조회하기(column)
select * 
from employees;

select * 
from departments;

--원하는 컬럼만 조회하기(세로값)
select employee_id, first_name, last_name
from employees;

select first_name, phone_number,hire_date, salary
from employees;

select first_name,
       last_name,
       salary,
       phone_number, 
       email,
       hire_date
from employees;

--출력할 때 컬럼에 별명 사용하기
--as를 생략해도 내가 사용하는 name으로 변경할수있다.
select employee_id as empNo,
       first_name as "f-name",
       salary  "급   여"
from employees;

--예제) 한글은 대소문자가 없기때문에 ""를 써주지않아도 표현가능하다.
select first_name 이름,
       phone_number 전화번호,
       hire_date 입사일,
       salary 급여
from employees;

--as를 쓸거면 다써주고 아니면 다 빼줘서 가독성 높이기
select employee_id as 사원번호,
       first_name 이름,
       last_name as 성,
       salary 급여,
       phone_number 전화번호,
       email as 이메일,
       hire_date 입사일
from employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기
select first_name,
       last_name
from employees;

select first_name || last_name 
from employees;

select first_name || '' || last_name 
from employees;

select first_name || ' hire date is ' || hire_date as 입사일 
from employees;

--산술 연산자 사용하기
select first_name, 
       salary
from employees;

select first_name,
       salary,
       salary*12
from employees;

select first_name,
       salary,
       salary*12,
       (salary+300)*12
from employees;

select job_id*12 --job_id는 숫자가 아니기때문에 숫자연산이 불가능하다.
from employees;

select first_name || '-' || last_name as 성명,
       salary as 급여,
       salary*12 as 연봉,
       salary*12+5000 as 연봉2,
       phone_number as 전화번호      
from employees;

/*where절*/
select first_name
from employees
where department_id = 10;

select first_name,
       salary
from employees
where salary>=15000;

select first_name,
       hire_date
from employees
where hire_date >= '07/01/01';  --07.01.01 , 07-01-01 가능

select salary
from employees
where first_name = 'Lex';

select first_name,
       salary
from employees
where salary >= 14000 
and salary <= 17000;

--예제
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


--BETWEEN 연산자로 특정구간 값 출력하기
select first_name,
       salary
from employees
where salary between 14000 and 17000;  --비트윈&앤드 한세트

--IN 연산자로 여러 조건을 검사하기
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

select first_name, last_name, salary  -- 위의 조건이랑 같은방법
from employees
where first_name = 'Neena' 
or first_name = 'Lex'
or first_name = 'John';

select first_name,  --모두 or일경우 아래같은 방법을 쓸수있다.
       salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;

select first_name,
       salary
from employees
where salary in (2100, 3100 ,4100 ,5100);

--Like 연산자로 비슷한것들 모두 찾기
select first_name,
       last_name,
       salary
from employees
where first_name like 'L%';

--예제
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

select first_name
from employees
where first_name like '__a_';
