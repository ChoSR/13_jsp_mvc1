# 실습을 위한 데이터 베이스 구성

CREATE DATABASE LOGIN_EX;

USE LOGIN_EX;

CREATE TABLE MEMBER (
	ID       	VARCHAR(20),
    PASSWD   	VARCHAR(20),
    NAME     	VARCHAR(20),
    JOIN_DATE	DATE
);

SELECT 
		* 
FROM 
		MEMBER;