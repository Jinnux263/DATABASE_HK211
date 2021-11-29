USE master;

USE ASSIGNMENT2;

SELECT * FROM ADMINISTRATOR;
SELECT * FROM ATTACHMENT;
SELECT * FROM CERTIFICATE;
SELECT * FROM COURSE;
SELECT * FROM CREAT_COURSE;
SELECT * FROM ENROLL_COURSE;
SELECT * FROM LEARNER;
SELECT * FROM LEARNER_ASK;
SELECT * FROM LEARNER_TAKE_QUIZZ;
SELECT * FROM LEARNER_WATCH_VIDEO;
SELECT * FROM LECTURE;
SELECT * FROM QUESTION;
SELECT * FROM QUIZ;
SELECT * FROM QUIZ_QUESTION;
SELECT * FROM SUPPORT;
SELECT * FROM TEACHER;
SELECT * FROM TEACHER_ANSWER;
SELECT * FROM UNIVERSITY;
SELECT * FROM UNIVERSITY_LOCATION;
SELECT * FROM UNIVERSITY_PHONE_NUMBER;
SELECT * FROM USERTB;
SELECT * FROM VIDEO;


-- Query

-- Liet ke id va ten cac hoc vien tham gia khoa hoc Programing for everyone
SELECT User_ID AS Learner_ID, First_Name, Last_Name
FROM COURSE, ENROLL_COURSE, USERTB
WHERE USERTB.User_ID = Learner_ID AND COURSE.Course_ID = ENROLL_COURSE.Course_ID AND Course_name = 'Programing for everyone'
ORDER BY Learner_ID DESC;
GO

-- Liet ke id va ten cac hoc vien chua tham gia khoa hoc nao
SELECT LEARNER.User_ID, First_Name, Last_Name
FROM USERTB, LEARNER
WHERE USERTB.User_ID = LEARNER.User_ID AND LEARNER.User_ID NOT IN (
    SELECT Learner_ID
    FROM ENROLL_COURSE
)
ORDER BY LEARNER.User_ID DESC;
GO

-- Liet ke id va ten cac khoa hoc co so luong lecture tren 4
SELECT COURSE.Course_ID, Course_name, COUNT(*) AS Number_of_lecture
FROM COURSE, LECTURE
WHERE COURSE.Course_ID = LECTURE.Course_ID
GROUP BY COURSE.Course_ID, Course_name
HAVING COUNT(*) > 4;
GO

-- Voi moi khoa hoc liet ke id, ten va diem trung binh cua tung hoc vien
SELECT User_ID AS Learner_ID, First_Name, Last_Name, Course_name, AVG(Score) AS Average_score
FROM USERTB, COURSE, LEARNER_TAKE_QUIZZ
WHERE User_ID = Learner_ID AND COURSE.Course_ID = LEARNER_TAKE_QUIZZ.Course_ID
GROUP BY User_ID, First_Name, Last_Name, Course_name
HAVING AVG(Score) > 3
ORDER BY Learner_ID;
GO


-- Procedure

CREATE PROCEDURE p_list_courses_with_greater_x_learners
    @x INT
AS
BEGIN
    SELECT ENROLL_COURSE.Course_ID, Course_name
    FROM ENROLL_COURSE, COURSE
    WHERE COURSE.Course_ID = ENROLL_COURSE.Course_ID
    GROUP BY ENROLL_COURSE.Course_ID, Course_name
    HAVING COUNT(*) > @x;
END;

EXEC p_list_courses_with_greater_x_learners 7;
GO

CREATE PROCEDURE p_insert_course
    @Course_ID VARCHAR(7),
    @Course_name VARCHAR(30),
    @SPECIALIZATION VARCHAR(30),
    @Level VARCHAR(15),
    @Description VARCHAR(255),
    @Fee VARCHAR(15),
    @Admin_ID CHAR(7)
AS
BEGIN
    IF EXISTS(SELECT * FROM COURSE WHERE Course_ID = @Course_ID)
    BEGIN
        RAISERROR('Inputed Course_ID is already exist', 18, 0)
        RETURN
    END

    IF (@Course_ID IS NULL OR @Course_ID = '')
    BEGIN
        RAISERROR('Invalid parameter: @Course_ID cannot be NULL or empty', 18, 0)
        RETURN
    END

    IF (@Course_name IS NULL OR @Course_name = '')
    BEGIN
        RAISERROR('Invalid parameter: @Course_name cannot be NULL or empty', 18, 0)
        RETURN
    END

    IF (@Level NOT IN ('Introductory', 'Intermediate', 'Advanced'))
    BEGIN
        RAISERROR('Invalid parameter: @Level must be "Introductory" or "Intermediate" or "Advanced"', 18, 0)
        RETURN
    END

    IF NOT EXISTS(SELECT * FROM ADMINISTRATOR WHERE User_ID = @Admin_ID)
    BEGIN
        RAISERROR('Error with refering to foreign key', 18, 0)
        RETURN
    END

    INSERT INTO COURSE VALUES (@Course_ID, @Course_name, @SPECIALIZATION, @Level, @Description, @Fee, @Admin_ID)
END;

DROP PROCEDURE p_insert_course;
GO

-- fail
EXEC p_insert_course '5000010', 'Linear Algebra', 'Math', 'Introductory', 'After finishing this course, you will gain the basic knowledge of linear algebra.', '20', '9000001';
GO

-- success
EXEC p_insert_course '5000010', 'Linear Algebra', 'Math', 'Introductory', 'After finishing this course, you will gain the basic knowledge of linear algebra.', '20', '1000001';
GO


-- Function

CREATE FUNCTION f_top_3_student_in_course_x
(
    @x CHAR(7)
)
RETURNS @Result TABLE (
    Learner_ID CHAR(7),
    First_Name VARCHAR(15),
    Last_Name VARCHAR(15),
    Average_score FLOAT
)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM LEARNER_TAKE_QUIZZ WHERE Course_ID = @x)
    BEGIN
        RETURN
    END

    INSERT INTO @Result 
        SELECT TOP 3 User_ID AS Learner_ID, First_Name, Last_Name, AVG(Score) AS Average_score
        FROM USERTB, LEARNER_TAKE_QUIZZ
        WHERE User_ID = Learner_ID AND LEARNER_TAKE_QUIZZ.Course_ID = @x
        GROUP BY User_ID, First_Name, Last_Name
        ORDER BY AVG(Score) DESC
    
    RETURN
END;
GO

SELECT * FROM f_top_3_student_in_course_x(5000001);
GO

-- Triggers

CREATE TRIGGER Raise_fee_on_course ON LECTURE
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT Course_ID
        FROM LECTURE
        GROUP BY Course_ID
        HAVING COUNT(*) > 5
    )
    BEGIN
        UPDATE COURSE
        SET Fee = Fee * 1.25
        WHERE Course_ID IN (
            SELECT Course_ID
            FROM LECTURE
            GROUP BY Course_ID
            HAVING COUNT(*) > 5
        )
    END
END;
GO

SELECT * FROM COURSE;

INSERT INTO LECTURE VALUES ('5000002', 5, 'Assignment', 'You will need to finish the assignment to complete this course');
INSERT INTO LECTURE VALUES ('5000001', 6, 'Assignment 1', 'You have 2 week to finish the assignment');
GO

CREATE TRIGGER Validate_fee ON COURSE
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO [COURSE] (
        [Course_ID],
        [Course_name],
        [SPECIALIZATION],
        [Level],
        [Description],
        [Fee],
        [Admin_ID]
    )
    SELECT Course_ID,
            Course_name,
            SPECIALIZATION,
            Level,
            Description,
            Fee,
            Admin_ID
    FROM inserted
    WHERE Fee >= 0;

    INSERT INTO [COURSE] (
        [Course_ID],
        [Course_name],
        [SPECIALIZATION],
        [Level],
        [Description],
        [Fee],
        [Admin_ID]
    )
    SELECT Course_ID,
            Course_name,
            SPECIALIZATION,
            Level,
            Description,
            0,
            Admin_ID
    FROM inserted
    WHERE Fee < 0;
END;
GO

INSERT INTO COURSE VALUES ('5000009', 'Math modeling', 'Math', 'Intermediate', 'You will learn system dynamic, linear programming, automata', 50, '1000004');
INSERT INTO COURSE VALUES ('5000011', 'Statistics', 'Math', 'Intermediate', 'You will learn the modern statistic methods', -50, '1000004');
