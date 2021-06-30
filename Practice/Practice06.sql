Drop table book;
Drop table author;
DROP SEQUENCE bseq_book_id;
DROP SEQUENCE sequ_author_id;


--Author 테이블 만들기 ( Primary key 설정, Not Null 설정 )
create table author (
    author_id number(10),
    author_name VARCHAR2(100) not null,
    author_desc VARCHAR2(500),
    PRIMARY KEY (author_id)
);


-- Sequence 만들기  (프라이머리 키-Author_id가 1씩 증가하게끔)
create SEQUENCE sequ_author_id
INCREMENT BY 1 
START WITH 1;


-- Insert Into 테이블 Values(시퀀스변수명.NextVal, '', '');
insert into author VALUES(sequ_author_id.nextval, '김문열', '경북 영양');
insert into author VALUES(sequ_author_id.nextval, '박경리', '경상남도 통영');
insert into author VALUES(sequ_author_id.nextval, '유시민', '17대 국회의원');
insert into author VALUES(sequ_author_id.nextval, '기안84', '기안동에서 산 84년생');
insert into author VALUES(sequ_author_id.nextval, '강풀', '온라인 만화가 1세대');
insert into author VALUES(sequ_author_id.nextval, '김영하', '알쓸신잡');


--Book 테이블 만들기 ( Primary key 설정, Forieng Key 설정, Not Null 설정 )
create table book (
    book_id number(10),
    title VARCHAR2(100) not null,
    pubs VARCHAR2(100),
    pub_date date,
    author_id number(10),
    PRIMARY KEY (book_id),
    CONSTRAINT book_fk FOREIGN KEY (author_id) 
    REFERENCES author(author_id)
);


create SEQUENCE bseq_book_id
INCREMENT BY 1 
START WITH 1;


insert into book VALUES(bseq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book VALUES(bseq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);
insert into book VALUES(bseq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);
insert into book VALUES(bseq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
insert into book VALUES(bseq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
insert into book VALUES(bseq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);
insert into book VALUES(bseq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);
insert into book VALUES(bseq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);


--Author & Book  Join해서 출력하기
select bo.book_id,
       bo.title,
       bo.pubs,
       to_char(bo.pub_date, 'YYYY-MM-DD') "PUB_DATE",
       bo.author_id,
       au.author_name,
       au.author_desc
from author au,
     book bo
where au.author_id = bo.author_id;


--강풀의 Author_desc 정보 '서울특별시'로 변경
update author
set author_desc = '서울특별시'
where author_id = 5;


--수정확인
select *
from author;


--Author 테이블에서 기안84 데이터 삭제
delete from author
where author_id = 4;