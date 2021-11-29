USE ASSIGNMENT2

--1
SELECT Quiz_ID, Description FROM LECTURE, QUIZ WHERE Lecture_Name = 'Why we program' AND LECTURE.Course_ID = QUIZ.Course_ID AND LECTURE.Lecture_number = QUIZ.Lecture_number ORDER BY Quiz_ID

--2
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, TEACHER.Degree, UNIVERSITY.University_name  FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND CREAT_COURSE.Teacher_ID = TEACHER.User_ID AND UNIVERSITY.University_ID = TEACHER.University_ID AND CREAT_COURSE.Course_ID = '5000002' ORDER BY USERTB.Last_Name

--3
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, COUNT(*) AS TotalRequest FROM USERTB, SUPPORT  WHERE USERTB.User_ID = SUPPORT.User_ID GROUP BY USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name ORDER BY COUNT(*) DESC

--4
SELECT USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name, COUNT(*) AS TotalCourseCreated FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND TEACHER.User_ID = CREAT_COURSE.Teacher_ID AND UNIVERSITY.University_ID = TEACHER.University_ID GROUP BY USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name HAVING COUNT(*) >= 2 ORDER BY COUNT(*) DESC

------------------------------------------------------------------------------------------------------------------------

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

EXEC add_question_to_quiz @Course_ID = '5000031', @Lecture_Number = 1, @Quizz_ID = 2, @Ques_ID = 4, @Ques_Content = 'Is database hard?', @Ques_Answer = 'No if you learn carefully'

------------------------------------------------------------------------------------------------------------------------

-- -- Trigger1
-- GO
-- USE ASSIGNMENT2
-- GO
-- DROP TRIGGER IF EXISTS updateAdminSupport;

-- GO
-- CREATE TRIGGER updateAdminSupport
-- ON ADMINISTRATOR
-- AFTER UPDATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--     SELECT * FROM INSERTED
--     SELECT * FROM DELETED

--     -- SELECT * FROM SUPPORT
--     DECLARE @User_ID_New CHAR(7)
--     DECLARE @User_ID_Old CHAR(7)

--     SELECT @User_ID_Old = User_ID FROM DELETED
--     SELECT @User_ID_New = User_ID FROM INSERTED

--     UPDATE SUPPORT
--     SET SUPPORT.Admin_ID = @User_ID_New
--     WHERE SUPPORT.Admin_ID = @User_ID_Old;

--     -- SELECT * FROM SUPPORT
-- END;

-- UPDATE ADMINISTRATOR SET Admin_Type = 'Senior' WHERE User_ID = '1000005'
-- UPDATE ADMINISTRATOR SET Admin_Type = 'Junior' WHERE User_ID = '1000005'

-- UPDATE USERTB SET User_ID = '1000005' WHERE User_ID = '1000006'
-- UPDATE USERTB SET User_ID = '1000006' WHERE User_ID = '1000005'
-- SELECT * FROM ADMINISTRATOR
-- SELECT * FROM USERTB
-- SELECT * FROM SUPPORT
-- DELETE FROM USERTB WHERE User_ID = '1000001';

-- Trigger2
-- GO
-- DROP TRIGGER IF EXISTS enrollCourse;

-- GO
-- CREATE TRIGGER enrollCourse
-- ON ENROLL_COURSE
-- FOR  INSERT
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--     IF NOT EXISTS (SELECT * FROM ENROLL_COURSE WHERE ENROLL_COURSE.Course_ID = inserted.Course_ID)
--         BEGIN
--             PRINT ('[WARING]: This user have enrolled too many course to enroll more!')
--             RETURN 0
--         END;
-- END;


-- Trigger3
-- GO
-- DROP TRIGGER IF EXISTS trigger_name;

-- GO
-- CREATE TRIGGER trigger_name
-- ON USERTB
-- AFTER  INSERT, UPDATE, DELETE
-- AS
-- BEGIN
--     SELECT * FROM QUIZ_QUESTION WHERE Course_ID = '5000001' AND Lecture_Number = 1 AND Quiz_ID = 2
-- END;

------------------------------------------------------------------------------------------------------------------------
--Function
GO
USE ASSIGNMENT2
GO
DROP FUNCTION IF EXISTS dbo.TotalEnrollFee;
GO
CREATE FUNCTION dbo.TotalEnrollFee (@LearnerId CHAR(7), @time DATE = '2021-01-01')
RETURNS INT
WITH RETURNS NULL ON NULL INPUT
AS BEGIN
    IF NOT EXISTS (SELECT * FROM LEARNER WHERE User_ID = @LearnerId)
        BEGIN
            RETURN CAST ('[ERROR]: There is no user with this Id in Database, please try again!' AS INT)
        END;
    DECLARE @ans FLOAT;
    IF NOT EXISTS (SELECT * FROM COURSE, ENROLL_COURSE, LEARNER WHERE COURSE.Course_ID = ENROLL_COURSE.Course_ID AND LEARNER.User_ID = @LearnerId AND ENROLL_COURSE.Learner_ID = @LearnerId AND ENROLL_COURSE.Date_enroll > @time)
        RETURN 0;

    SELECT @ans = SUM(Fee) FROM COURSE, ENROLL_COURSE, LEARNER WHERE COURSE.Course_ID = ENROLL_COURSE.Course_ID AND LEARNER.User_ID = @LearnerId AND ENROLL_COURSE.Learner_ID = @LearnerId AND ENROLL_COURSE.Date_enroll > @time
    RETURN @ans
END;
GO

PRINT dbo.TotalEnrollFee('3000001', '2021-12-20')
PRINT dbo.TotalEnrollFee('3000000', default)

SELECT COURSE.Course_ID,Fee FROM COURSE, ENROLL_COURSE, LEARNER WHERE COURSE.Course_ID = ENROLL_COURSE.Course_ID AND LEARNER.User_ID = '3000001' AND ENROLL_COURSE.Learner_ID = '3000001'