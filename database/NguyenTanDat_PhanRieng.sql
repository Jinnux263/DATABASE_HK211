USE ASSIGNMENT2

--1
SELECT Quiz_ID, Description FROM LECTURE, QUIZ WHERE Lecture_Name = 'Why we program' AND LECTURE.Course_ID = QUIZ.Course_ID AND LECTURE.Lecture_number = QUIZ.Lecture_number ORDER BY Quiz_ID

--2
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, TEACHER.Degree, UNIVERSITY.University_name  FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND CREAT_COURSE.Teacher_ID = TEACHER.User_ID AND UNIVERSITY.University_ID = TEACHER.University_ID AND CREAT_COURSE.Course_ID = '5000002' ORDER BY USERTB.Last_Name

--3
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, COUNT(*) AS TotalRequest FROM USERTB, SUPPORT  WHERE USERTB.User_ID = SUPPORT.User_ID GROUP BY USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name ORDER BY COUNT(*) DESC

--4
SELECT USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name, COUNT(*) AS TotalCourseCreated FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND TEACHER.User_ID = CREAT_COURSE.Teacher_ID AND UNIVERSITY.University_ID = TEACHER.University_ID GROUP BY USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name HAVING COUNT(*) >= 2 ORDER BY COUNT(*) DESC

--Procedure 1
GO
DROP PROCEDURE IF EXISTS TopEnroll;
GO
CREATE PROCEDURE TopEnroll @number INT 
AS
BEGIN
    SELECT TOP(@number) USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, COUNT(*) AS EnrolledCourse FROM USERTB, ENROLL_COURSE  WHERE USERTB.User_ID = ENROLL_COURSE.Learner_ID GROUP BY USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name ORDER BY COUNT(*) DESC
    RETURN @@ROWCOUNT
END;

EXEC TopEnroll @number = 10

--Procedure 2
GO
DROP PROCEDURE IF EXISTS add_question_to_quiz;
GO
CREATE PROCEDURE add_question_to_quiz @Course_ID CHAR(7), @Lecture_Number INT, @Quizz_ID CHAR(7), @Ques_ID INT, @Ques_Content VARCHAR(255), @Ques_Answer VARCHAR(255)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM QUIZ_QUESTION WHERE Course_ID = @Course_ID AND Lecture_Number = @Lecture_Number AND Quiz_ID = @Quizz_ID)
        BEGIN
            PRINT ('[ERROR]: There is no matched quiz in the database! Please create quiz first.')
            RETURN 0
        END;
    IF EXISTS (SELECT * FROM QUIZ_QUESTION WHERE Course_ID = @Course_ID AND Lecture_Number = @Lecture_Number AND Quiz_ID = @Quizz_ID AND Question_ID = @Ques_ID)
        BEGIN
            PRINT ('[ERROR]: The question id has already existed in the database!')
            RETURN 0
        END;
    INSERT INTO QUIZ_QUESTION VALUES (@Course_ID, @Lecture_Number, @Quizz_ID, @Ques_ID, @Ques_Content, @Ques_Answer)
    RETURN @@ROWCOUNT
END;

EXEC add_question_to_quiz @Course_ID = '5000001', @Lecture_Number = 1, @Quizz_ID = 2, @Ques_ID = 4, @Ques_Content = 'Is database hard?', @Ques_Answer = 'No if you learn carefully'

SELECT * FROM QUIZ_QUESTION WHERE Course_ID = '5000001' AND Lecture_Number = 1 AND Quiz_ID = 2

-- Trigger1
GO
DROP TRIGGER IF EXISTS trigger_name;

GO
CREATE TRIGGER trigger_name
ON USERTB
AFTER  INSERT, UPDATE, DELETE
AS
BEGIN
    SELECT * FROM QUIZ_QUESTION WHERE Course_ID = '5000001' AND Lecture_Number = 1 AND Quiz_ID = 2
END;

-- Trigger2
GO
DROP TRIGGER IF EXISTS trigger_name;

GO
CREATE TRIGGER trigger_name
ON USERTB
AFTER  INSERT, UPDATE, DELETE
AS
BEGIN
    SELECT * FROM QUIZ_QUESTION WHERE Course_ID = '5000001' AND Lecture_Number = 1 AND Quiz_ID = 2
END;

-- Trigger3
GO
DROP TRIGGER IF EXISTS trigger_name;

GO
CREATE TRIGGER trigger_name
ON USERTB
AFTER  INSERT, UPDATE, DELETE
AS
BEGIN
    SELECT * FROM QUIZ_QUESTION WHERE Course_ID = '5000001' AND Lecture_Number = 1 AND Quiz_ID = 2
END;