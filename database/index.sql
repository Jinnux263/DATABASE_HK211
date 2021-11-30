USE ASSIGNMENT2
DROP INDEX IF EXISTS dbo.COURSE.Index_set_course;
DROP INDEX IF EXISTS dbo.CREAT_COURSE.Index_create_course;
DROP INDEX IF EXISTS dbo.LEARNER.Index_Learner;
DROP INDEX IF EXISTS dbo.USERTB.Index_UserTB;
DROP INDEX IF EXISTS dbo.TEACHER.Index_Teacher;
DROP INDEX IF EXISTS dbo.CERTIFICATE.Index_certificate;
--Chỉ mục
--Tạo chỉ mục cho course

create unique index Index_set_course on dbo.COURSE(Course_ID)
-- Xóa: drop index Index_set_course on dbo.COURSE

--Tạo chỉ mục cho create_course
create unique index Index_create_course on dbo.CREAT_COURSE(Teacher_ID, Course_ID)
-- Xóa: drop index Index_create_course on dbo.CREAT_COURSE

-- Tạo chỉ mục cho Learner
create unique index Index_Learner on dbo.LEARNER(User_ID)
-- Xóa: drop index Index_Learner on dbo.LEARNER

--Tạo chỉ mục cho UserTB
create unique index Index_UserTB on dbo.USERTB(User_ID)
--xóa: drop index Index_UserTB on dbo.USERTB

--Tạo chỉ mục cho Teacher
create unique index Index_Teacher on dbo.TEACHER(User_ID)
--Xóa: drop index Index_Teacher on dbo.TEACHER

-- Tạo chỉ mục trên bảng certificate
create index Index_certificate on dbo.CERTIFICATE(Learner_ID, Course_ID)
--xóa: drop index Index_certificate on dbo.CERTIFICATE
