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

-- EXEC TopEnroll @number = 10



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

-- EXEC add_question_to_quiz @Course_ID = '5000001', @Lecture_Number = 1, @Quizz_ID = 2, @Ques_ID = 4, @Ques_Content = 'Is database hard?', @Ques_Answer = 'No if you learn carefully'

------------------------------------------------------------------------------------------------------------------------

-- Trigger1
GO
USE ASSIGNMENT2
GO
DROP TRIGGER IF EXISTS insertUserTrigger
GO
CREATE TRIGGER insertUserTrigger
ON USERTB
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @insertedUser_ID CHAR(7)
    DECLARE @insertedAccount_Type VARCHAR(15)

    SELECT @insertedUser_ID = User_ID, @insertedAccount_Type = Account_Type FROM INSERTED

    IF (@insertedAccount_Type = 'Administrator') 
        BEGIN
            INSERT INTO ADMINISTRATOR VALUES (@insertedUser_ID,'Junior')
        END;
    ELSE IF (@insertedAccount_Type = 'Teacher') 
        BEGIN
            INSERT INTO TEACHER VALUES (@insertedUser_ID, 'Assistant professor', NULL, NULL, NULL);
        END;
    ELSE IF (@insertedAccount_Type = 'Learner') 
        BEGIN
            INSERT INTO LEARNER VALUES (@insertedUser_ID, 'No Formal')
        END;
END;

-- INSERT INTO USERTB VALUES ('3000044', 'Learner_44', 'Learner41', 'Jones','Newton', '1300000041', '2002-01-23', 'F','United Stated',' New York', 'Learner_41@gmail.com', 'Teacher')

-- SELECT * FROM TEACHER
-- SELECT * FROM LEARNER
-- SELECT * FROM USERTB



-- Trigger2
GO
USE ASSIGNMENT2
GO
DROP TRIGGER IF EXISTS updateUserTrigger;
GO
CREATE TRIGGER updateUserTrigger
ON USERTB
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    -- SELECT * FROM INSERTED
    -- SELECT * FROM DELETED

    DECLARE @insertedUser_ID CHAR(7)
    DECLARE @insertedUsername VARCHAR(30)
    DECLARE @insertedPassword VARCHAR(20)
    DECLARE @insertedFirst_Name VARCHAR(15)

    DECLARE @insertedLast_Name VARCHAR(15) 
    DECLARE @insertedPhone_Number CHAR(10)
    DECLARE @insertedBirthday DATE
    DECLARE @insertedSex CHAR(10)

    DECLARE @insertedCountry VARCHAR(30)
    DECLARE @insertedAddress VARCHAR(30)
    DECLARE @insertedEmail VARCHAR(30)
    DECLARE @insertedAccount_Type VARCHAR(15)

    DECLARE @insertedUser_IDOld VARCHAR(30)

    SELECT @insertedUser_ID = User_ID, @insertedUsername = Username, @insertedPassword = Password, @insertedFirst_Name = First_Name, @insertedLast_Name = Last_Name, @insertedPhone_Number = Phone_Number,  @insertedEmail = Email, @insertedBirthday = Birth_Date, @insertedCountry = Country, @insertedAddress = Address, @insertedAccount_Type = Account_Type, @insertedSex = Sex  FROM INSERTED;

    SELECT @insertedUser_IDOld = User_ID FROM DELETED


    UPDATE SUPPORT SET User_ID = NULL WHERE User_ID = @insertedUser_IDOld
    UPDATE SUPPORT SET Admin_ID = NULL WHERE Admin_ID = @insertedUser_IDOld

    UPDATE USERTB SET User_ID = @insertedUser_ID, Username = @insertedUsername, Password = @insertedPassword, First_Name = @insertedFirst_Name, Last_Name = @insertedLast_Name, Phone_Number = @insertedPhone_Number, Email = @insertedEmail, Birth_Date = @insertedBirthday, Country = @insertedCountry, Address = @insertedAddress, Account_Type = @insertedAccount_Type, Sex = @insertedSex  WHERE USERTB.User_ID = @insertedUser_IDOld

    UPDATE SUPPORT SET User_ID = @insertedUser_ID WHERE User_ID IS NULL
    UPDATE SUPPORT SET Admin_ID = @insertedUser_ID WHERE Admin_ID IS NULL
END;

-- SELECT * FROM USERTB
-- SELECT * FROM SUPPORT

-- UPDATE USERTB SET USERTB.User_ID = '1000006' WHERE USERTB.User_ID = '1000004'
-- UPDATE USERTB SET USERTB.User_ID = '3000041' WHERE USERTB.User_ID = '3000030'



-- Trigger3
GO
USE ASSIGNMENT2
GO
DROP TRIGGER IF EXISTS deleteUserTrigger;
GO
CREATE TRIGGER deleteUserTrigger
ON USERTB
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    --SELECT * FROM DELETED

    DECLARE @deletedUser_ID CHAR(7)
    SELECT @deletedUser_ID = User_ID FROM DELETED;

    DELETE FROM SUPPORT WHERE User_ID = @deletedUser_ID;
    DELETE FROM SUPPORT WHERE Admin_ID = @deletedUser_ID;

    DELETE FROM USERTB WHERE User_ID = @deletedUser_ID;

END;
-- SELECT * FROM USERTB
-- SELECT * FROM SUPPORT

-- DELETE FROM USERTB WHERE User_ID = '2000010';
-- DELETE FROM USERTB WHERE User_ID = '1000003';
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

-- PRINT dbo.TotalEnrollFee('3000001', '2021-01-01')
-- PRINT dbo.TotalEnrollFee('3000000', default)
-- PRINT dbo.TotalEnrollFee('3000001', '2021-12-20')

-----------------------------------------------------------------------------------------------------------------------