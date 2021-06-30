--테이블 만들기
create table book(
    book_id number(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_hub date
);

-- pubs라는 컬럼을 추가하는것
alter table book add(
    pubs VARCHAR2(50)
);

-- title의 글자제한크기 수정
alter table book MODIFY(
    title VARCHAR2(100)
);

-- title의 컬럼명을 subject로 번경
alter table book RENAME COLUMN title TO subject;


--Book테이블의 author 컬럼삭제
alter table book drop(author);


--Table Book을 Article로 이름변경
rename book to article;


--테이블 Article을 삭제
drop table article;


--Author 테이블 만들기 ( Primary key 설정, Not Null 설정)
create table author (
    author_id   number(10),
    author_name VARCHAR2(100) not null,
    author_desc VARCHAR2(500),
    PRIMARY Key(author_id)
);


--테이블 만들기 (PRIMARY KEY / foreign key)
create table book (
    book_id number(10),
    title VARCHAR2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id number(10),
    PRIMARY KEY (book_id),
    CONSTRAINT book_fk foreign key(author_id) 
    REFERENCES author(author_id)
);


/* INSERT */
--Insert (묵시적방법 - 테이블생성시 정의한 순서로 넣어야함!)
insert into author values(1, '박경리', '토지 작가');

--확인
select * 
from author;


--Insert (명시적 방법 )
insert INTO author (author_id, author_name) 
values (2, '이문열');

--확인
select * 
from author;


/* Update */
update author
set author_name = '기안84',
    author_desc = '웹툰작가'
where author_id = 1;

update author
set author_name = '대니조'
where author_id = 1;   -- author_id < 2도 가능

update author
set author_name = '강풀',
    author_desc = '인기작가';
--where절을 안써준다면 모든데이터가 위에 값으로 변경된다. 조심해야한다!


/* Delete - 꼭 where절을 써서 원하는곳만 삭제해주기 */
delete from author
where author_id = 1;


/* Commit & RollBack */
insert into author values(1, '박경리', '토지 작가');
commit; -- **(0)** Commit을 실행하고 나서 이 아래 두가지의 컬럼들은 추가한다고해도
        -- 다시 Commit하지않으면 가상으로 생기는것이다.

insert into author values(2, '기안84', '웹툰 작가'); --(1)
insert into author values(3, '이문여', '인기 작가'); --(2)
commit; -- 위에 두줄은 Commit을 실행하기전까지 가상의 컬럼이다.


Update author
set author_desc = '나혼자산다 출연'
where author_id = 2;            --(3)

delete from author
where author_id = 1;            --(4)



ROLLBACK; --**(5)** commit한 시점까지로 다시 돌아가는것이다.
--(0)번의 커밋만하고 (1)과 (2)번, (3), (4)번을 실행하고 (5)번의 ROLLBACK을 하면
--(0)번의 COMMIT의 상태로 다시 돌아간다.

--위의 Commit과 RollBack은 INSERT / UPDATE / DELETE에서만 적용된다.


/* SEQUENCE */
create SEQUENCE seq_author_id
INCREMENT BY 1                  --author_id가 1씩 증가하라
START WITH 1                    --1부터 시작하라
NOCACHE;                        


delete from author;
commit;

select * 
from author;

insert into author VALUES(seq_author_id.nextval, '기안84', '웹툰작가');
insert into author VALUES(seq_author_id.nextval, '이문열', '작가');

seq_author_id.nextval; --이렇게 실행을 하기라도하면 혼자서 번호가 들어가버린다.

select *
from user_SEQUENCES;

select seq_author_id.currval from dual;  --현재 시퀀스 번호 조회

select seq_author_id.nextval from dual;  --다음 시퀀스 번호조회

insert into author VALUES(seq_author_id.nextval, '대니', '작가');