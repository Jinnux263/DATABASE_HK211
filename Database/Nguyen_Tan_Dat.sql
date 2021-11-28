USE ASSIGNMENT2

--1
SELECT Quiz_ID, Description FROM LECTURE, QUIZ WHERE Lecture_Name = 'Why we program' AND LECTURE.Course_ID = QUIZ.Course_ID AND LECTURE.Lecture_number = QUIZ.Lecture_number ORDER BY Quiz_ID

--2
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, TEACHER.Degree, UNIVERSITY.University_name  FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND CREAT_COURSE.Teacher_ID = TEACHER.User_ID AND UNIVERSITY.University_ID = TEACHER.University_ID AND CREAT_COURSE.Course_ID = '5000002' ORDER BY USERTB.Last_Name

--3
SELECT USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name, COUNT(*) AS TotalRequest FROM USERTB, SUPPORT  WHERE USERTB.User_ID = SUPPORT.User_ID GROUP BY USERTB.User_ID, USERTB.First_Name, USERTB.Last_Name ORDER BY COUNT(*) DESC

--4
SELECT USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name, COUNT(*) AS TotalCourseCreated FROM USERTB, TEACHER, CREAT_COURSE, UNIVERSITY WHERE USERTB.User_ID = TEACHER.User_ID AND TEACHER.User_ID = CREAT_COURSE.Teacher_ID AND UNIVERSITY.University_ID = TEACHER.University_ID GROUP BY USERTB.User_ID, USERTB.Username, USERTB.First_Name, USERTB.Last_Name, UNIVERSITY.University_name HAVING COUNT(*) >= 2 ORDER BY COUNT(*) DESC