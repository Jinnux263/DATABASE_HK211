USE master;
DROP DATABASE IF EXISTS ASSIGNMENT2;

CREATE DATABASE ASSIGNMENT2

GO
USE ASSIGNMENT2;
CREATE TABLE USERTB
(
	User_ID CHAR(7) PRIMARY KEY,
	Username VARCHAR(30) NOT NULL UNIQUE,
	Password VARCHAR(20) NOT NULL,
	First_Name VARCHAR(15) NOT NULL,
	Last_Name VARCHAR(15) NOT NULL,
	Phone_Number CHAR(10),
	Birth_Date DATE,
	Sex VARCHAR(10) NOT NULL CHECK(Sex IN ('M','F','Other')),
	Country VARCHAR(30),
	Address VARCHAR(30),
	Email VARCHAR(30) NOT NULL,
	Account_Type VARCHAR(15) NOT NULL CHECK(Account_Type IN ('Administrator', 'Teacher', 'Learner'))
);

GO
CREATE TABLE ADMINISTRATOR
(
	User_ID CHAR(7) PRIMARY KEY,
	Admin_Type VARCHAR(30),
	CONSTRAINT FK_admin_user FOREIGN KEY (User_ID)
				REFERENCES USERTB (User_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE LEARNER
(
	User_ID CHAR(7) PRIMARY KEY,
	Education_Degree VARCHAR(15) NOT NULL CHECK(Education_Degree IN ('Doctorage', 'Master', 'Bachelor','High School', 'No Formal')),
	CONSTRAINT FK_learner_user FOREIGN KEY (User_ID)
				REFERENCES USERTB (User_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE UNIVERSITY
(
	University_ID CHAR(7) PRIMARY KEY,
	University_name VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
);

GO
CREATE TABLE UNIVERSITY_LOCATION
(
	University_ID CHAR(7),
	Country VARCHAR(30),
	City VARCHAR(30),
	PRIMARY KEY (University_ID, Country, City),
	CONSTRAINT FK_location FOREIGN KEY (University_ID)
				REFERENCES UNIVERSITY (University_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE UNIVERSITY_PHONE_NUMBER
(
	University_ID CHAR(7),
	Phone_Number CHAR(10) NOT NULL,
	PRIMARY KEY (University_ID, Phone_Number),
	CONSTRAINT FK_phone_uni FOREIGN KEY (University_ID)
				REFERENCES UNIVERSITY (University_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE TEACHER
(
	User_ID CHAR(7) PRIMARY KEY,
	Degree VARCHAR(30) NOT NULL CHECK(Degree IN ('Professor', 'Director', 'Senior preceptor', 'Assistant professor','Master')),
	Specialization VARCHAR(30),
	Short_Description VARCHAR(255),
	University_ID CHAR(7),
	CONSTRAINT FK_teacher_uni FOREIGN KEY (University_ID)
				REFERENCES UNIVERSITY (University_ID)
				ON DELETE SET NULL,
	CONSTRAINT FK_teacher_user FOREIGN KEY (User_ID)
				REFERENCES USERTB (User_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE SUPPORT
(
	SupportID INT IDENTITY(1,1) PRIMARY KEY,
	Requirement VARCHAR(255) NOT NULL,
	Date_sent DATE,
	Date_process DATE,
	User_ID CHAR(7),
	Admin_ID CHAR(7),
);

GO
ALTER TABLE SUPPORT
	ADD CONSTRAINT FK_support_user FOREIGN KEY (User_ID)
					REFERENCES USERTB (User_ID)
					ON DELETE CASCADE,
		CONSTRAINT FK_support_admin FOREIGN KEY (Admin_ID)
					REFERENCES ADMINISTRATOR (User_ID)
					--ON DELETE SET NULL;
					--Tai sao xoa support khi tai khoản admin bi xoa

GO
CREATE TABLE COURSE
(
	Course_ID CHAR(7) PRIMARY KEY,
	Course_name VARCHAR(30) NOT NULL,
	SPECIALIZATION VARCHAR(30),
	Level VARCHAR(15) CHECK(Level IN ('Introductory', 'Intermediate', 'Advanced')),
	Description VARCHAR(255),
	Fee FLOAT,
	Admin_ID CHAR(7),
	CONSTRAINT FK_course_admin FOREIGN KEY (Admin_ID)
				REFERENCES ADMINISTRATOR (User_ID)
				ON DELETE SET NULL
);

GO
CREATE TABLE CREAT_COURSE
(
	Teacher_ID CHAR(7),
	Course_ID CHAR(7),
	Date_created DATE,
	Date_end DATE,
	PRIMARY KEY (Teacher_ID, Course_ID),
	CONSTRAINT FK_create_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_create_teacher FOREIGN KEY (Teacher_ID)
				REFERENCES TEACHER (User_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE ENROLL_COURSE
(
	Learner_ID CHAR(7),
	Course_ID CHAR(7),
	Date_enroll DATE,
	PRIMARY KEY (Learner_ID, Course_ID),
	CONSTRAINT FK_enroll_learner FOREIGN KEY (Learner_ID)
				REFERENCES LEARNER (User_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_enroll_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE
	-- O day nghia la khi xoa tai khoan thi xoa cac khoa hoc duoc dang ky boi nguoi do
	-- nhung khi xoa mot khoa hoc thi cac tai khoan van khong bi xoa khoi khoa hoc da dang ky
	-- hoi sai vi luc day minh dau con tham chieu duoc nua
);

GO
CREATE TABLE QUESTION
(
	Question_ID INT IDENTITY(1,1) PRIMARY KEY,
	Question_content VARCHAR(255) NOT NULL,
	Date_ask DATE,
	Answer_content VARCHAR(255),
	Date_answer DATE
);

GO
CREATE TABLE LEARNER_ASK
(
	Learner_ID CHAR(7),
	Question_ID INT NOT NULL,
	Course_ID CHAR(7) NOT NULL,
	PRIMARY KEY (Learner_ID, Question_ID),
	CONSTRAINT FK_ask_learner FOREIGN KEY (Learner_ID)
				REFERENCES LEARNER (User_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_ask_question FOREIGN KEY (Question_ID)
				REFERENCES QUESTION (Question_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_ask_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE
	--Xem xet logic mot xiu
);

GO
CREATE TABLE TEACHER_ANSWER
(
	Teacher_ID CHAR(7),
	Question_ID INT,
	Course_ID CHAR(7) NOT NULL,
	PRIMARY KEY (Teacher_ID, Question_ID),
	CONSTRAINT FK_teacher FOREIGN KEY (Teacher_ID)
				REFERENCES TEACHER (User_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_teacher_question FOREIGN KEY (Question_ID)
				REFERENCES QUESTION (Question_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_teacher_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE
	-- Hen xui, o day nghia la chi xoa khi teacher bi xoa tai khoan con lai thi van xai duoc
);

GO
CREATE TABLE CERTIFICATE
(
	Certificate_ID CHAR(7) PRIMARY KEY,
	Learner_ID CHAR(7) NOT NULL,
	Course_ID CHAR(7) NOT NULL,
	University_ID CHAR(7) NOT NULL,
	Date_getted DATE NOT NULL,
	Result VARCHAR(15) NOT NULL CHECK(Result IN ('Excellent', 'Good','Pass')),
	Description VARCHAR(255),
	CONSTRAINT FK_certi_learner FOREIGN KEY (Learner_ID)
				REFERENCES LEARNER (User_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_certi_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE,
	CONSTRAINT FK_certi_uni	FOREIGN KEY (University_ID)
				REFERENCES UNIVERSITY (University_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE LECTURE
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Lecture_name VARCHAR(30) NOT NULL,
	Lecture_content VARCHAR(255) NOT NULL,
	PRIMARY KEY (Course_ID, Lecture_number),
	CONSTRAINT FK_lecture_course FOREIGN KEY (Course_ID)
				REFERENCES COURSE (Course_ID)
				ON DELETE CASCADE
);

GO
CREATE TABLE ATTACHMENT
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Att_ID INT,
	Title VARCHAR(30) NOT NULL,
	Type VARCHAR(30),
	Content VARCHAR(255),
	PRIMARY KEY (Course_ID, Lecture_number, Att_ID)
);

GO
ALTER TABLE ATTACHMENT
	ADD CONSTRAINT FK_att_lecture FOREIGN KEY (Course_ID,Lecture_number)
					REFERENCES LECTURE (Course_ID,Lecture_number)
					ON DELETE CASCADE;

GO
CREATE TABLE VIDEO
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Video_ID CHAR(7),
	Title VARCHAR(30),
	Content VARCHAR(255),
	Length TIME,
	PRIMARY KEY (Course_ID, Lecture_number, Video_ID)
);

GO
ALTER TABLE VIDEO
	ADD CONSTRAINT FK_video_lecture FOREIGN KEY (Course_ID, Lecture_number)
					REFERENCES LECTURE (Course_ID, Lecture_number)
					ON DELETE CASCADE;

GO
CREATE TABLE LEARNER_WATCH_VIDEO
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Video_ID CHAR(7),
	Learner_ID CHAR(7),
	Time_learner_watch TIME,
	PRIMARY KEY (Course_ID, Lecture_number, Video_ID, Learner_ID),
	CONSTRAINT FK_learner FOREIGN KEY (Learner_ID)
				REFERENCES LEARNER (User_ID)
				ON DELETE CASCADE
);

GO
ALTER TABLE LEARNER_WATCH_VIDEO
	ADD CONSTRAINT FK_watch_video FOREIGN KEY (Course_ID, Lecture_number, Video_ID)
					REFERENCES VIDEO (Course_ID, Lecture_number, Video_ID)
					ON DELETE CASCADE;

GO
CREATE TABLE QUIZ
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Quiz_ID CHAR(7),
	Description VARCHAR(255) NOT NULL,
	PRIMARY KEY (Course_ID, Lecture_number, Quiz_ID)
);

GO
ALTER TABLE QUIZ
	ADD CONSTRAINT FK_quiz_lecture	FOREIGN KEY (Course_ID, Lecture_number)
					REFERENCES LECTURE (Course_ID, Lecture_number)
					ON DELETE CASCADE;

GO
CREATE TABLE QUIZ_QUESTION
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Quiz_ID CHAR(7),
	Question_ID INT,
	Question_content VARCHAR(255) NOT NULL,
	Question_answer VARCHAR(255),
	PRIMARY KEY (Course_ID, Lecture_number, Quiz_ID, Question_ID)
);

GO
ALTER TABLE QUIZ_QUESTION
	ADD CONSTRAINT FK_quiz_question_course	FOREIGN KEY (Course_ID, Lecture_number, Quiz_ID)
					REFERENCES QUIZ (Course_ID, Lecture_number, Quiz_ID)
					ON DELETE CASCADE;

GO
CREATE TABLE LEARNER_TAKE_QUIZZ
(
	Course_ID CHAR(7),
	Lecture_number INT,
	Quiz_ID CHAR(7),
	Learner_ID CHAR(7),
	Score FLOAT,
	PRIMARY KEY (Course_ID, Lecture_number, Quiz_ID, Learner_ID),
	CONSTRAINT FK_learner_take_quizz FOREIGN KEY (Learner_ID)
				REFERENCES LEARNER (User_ID)
				ON DELETE CASCADE
);

GO
ALTER TABLE LEARNER_TAKE_QUIZZ
	ADD CONSTRAINT FK_learner_quizz_course FOREIGN KEY (Course_ID, Lecture_number, Quiz_ID)
					REFERENCES QUIZ (Course_ID, Lecture_number, Quiz_ID)
					ON DELETE CASCADE;
