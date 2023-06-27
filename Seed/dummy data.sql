use University_Bachelor;
--CREATING DUMMY DATA FOR TESRING PURPOSES
USE University_Bachelor;

DECLARE @out1 int
DECLARE @out2 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drCAROLINE', @email='caroline.sabty@giu-uni.de', @phone_number='13579', @user_id = @out1 output, @password = @out2 output

DECLARE @out3 int 
DECLARE @out4 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drNADA', @email='nada.hamed@giu-uni.de', @phone_number='13579', @user_id = @out3 output, @password = @out4 output

DECLARE @out5 int
DECLARE @out6 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drALIA', @email='alia.elbolock@giu-uni.de', @phone_number='13579', @user_id = @out5 output, @password = @out6 output

DECLARE @out7 int
DECLARE @out8 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drMustfa', @email='mustafa.elagmy@giu-uni.de', @phone_number='13579', @user_id = @out7 output, @password = @out8 output
---creating deans!!!!
--cs dean
DECLARE @out11 int
DECLARE @out12 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drKLAUS', @email='klaus.baer.abdennahder@giu-uni.de', @phone_number='13579', @user_id = @out11 output, @password = @out12 output
--engineering dean
DECLARE @out13 int
DECLARE @out14 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drANSGAR', @email='ansger.meroth@giu-uni.de', @phone_number='13579', @user_id = @out13 output, @password = @out14 output
--design dean
DECLARE @out15 int
DECLARE @out16 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drKatrin', @email='katrin.hinz@giu-uni.de', @phone_number='13579', @user_id = @out15 output, @password = @out16 output


INSERT INTO Faculty (Faculty_Code, FacultyName, Dean) VALUES ('CSEN', 'Informatics&ComputerScience',221);
INSERT INTO Faculty (Faculty_Code, FacultyName, Dean)VALUES ('ENG','Engineering',222);
INSERT INTO Faculty (Faculty_Code, FacultyName, Dean) VALUES ('DES','Design',223);


INSERT INTO Major VALUES('DS','CSEN','Data science');
INSERT INTO Major VALUES('SE','CSEN','Software Engineering');
INSERT INTO Major VALUES('ITS','CSEN','IT Security')
INSERT INTO Major VALUES('MI','CSEN','Media Informatics')
INSERT INTO Major VALUES('AM','ENG','Automotive Mechatronics');
INSERT INTO Major VALUES('ME','ENG','Manufacturing Engineering');
INSERT INTO Major VALUES('RAA','ENG','Robotics and Automation');
INSERT INTO Major VALUES('AACE','ENG','Automation and Control Engineering');
INSERT INTO Major VALUES('EPSE','ENG','Electrical Power Systems Engineering');
INSERT INTO Major VALUES('ID','DES','Industrial design');
INSERT INTO Major VALUES('FD','DES','Fashion design');



--insertining students

DECLARE @id1 int
DECLARE @pass1 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Mariam',@birth_date = '11/10/2002' ,@email='mariamm@student.giu-uni.de', @phone_number='123',@first_name = 'Mariam', @last_name = 'RIZKALLAH', 
@major_code = 'SE', @address = 'TAHRIR SQ, KARSR EL EINY', @semester = 3, @gpa = 1.78, @user_id = @id1 output,@password= @pass1  output
--
DECLARE @id2 int
DECLARE @pass2 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Zeyad',@birth_date = '1/1/2002', @email='zeyadd@student.giu-uni.de', @phone_number='456',@first_name = 'Zeyad', @last_name = 'SHAFIK', 
@major_code = 'SE', @address = 'MANSOURA, a street in mansoura', @semester = 3, @gpa = 1.78, @user_id = @id2 output, @password = @pass2 output
--
DECLARE @id3 int
DECLARE @pass3 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Mina',@birth_date = '3/1/2002', @email='minaa@student.giu-uni.de', @phone_number='678',@first_name = 'Mina', @last_name = 'ATEF', 
@major_code = 'ITS', @address = 'SHERATON, a street in sheraton', @semester = 3, @gpa = 0.4, @user_id = @id3 output, @password = @pass3 output
--
DECLARE @id4 int
DECLARE @pass4 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Ali',@birth_date = '2/1/2002', @email='Alii@student.giu-uni.de', @phone_number='999', @first_name = 'Ali', @last_name = 'ZEIN', 
@major_code = 'ITS', @address = 'TAGMOE, a street in tagmoe', @semester = 3, @gpa = 0.7, @user_id = @id4 output, @password = @pass4 output
---------------

DECLARE @id5 int
DECLARE @pass5 varchar(10)
EXEC UserRegister @usertype='Student', @userName='joy',@birth_date = '1/1/2002', @email='joyyyy@student.giu-uni.de', @phone_number='999', @first_name = 'joy', @last_name = 'smith', 
@major_code = 'ID', @address = 'REHAB, a street in rehab', @semester = 5, @gpa = 1.45, @user_id = @id5 output, @password = @pass5 output



DECLARE @id6 int
DECLARE @pass6 varchar(10)
EXEC UserRegister @usertype='Student', @userName='josh',@birth_date = '1/10/2001', @email='josh@student.giu-uni.de', @phone_number='999', @first_name = 'JOSH', @last_name = 'sam', 
@major_code = 'RAA', @address = 'MASR EL GEIDA, a street in masr el gedida', @semester = 7, @gpa = 2.0, @user_id = @id6 output, @password = @pass6 output

DECLARE @id7 int
DECLARE @pass7 varchar(10)
EXEC UserRegister @usertype='Student', @userName='MONA',@birth_date = '1/10/2001', @email='monaliza@student.giu-uni.de', @phone_number='999', @first_name = 'mona', @last_name = 'liza', 
@major_code = 'ID', @address = 'Zamalek, a street in zamalek', @semester = 7, @gpa = 3.9, @user_id = @id7 output, @password = @pass7 output
---
--adding TAS
DECLARE @t1 int
DECLARE @t2 varchar(10)
EXEC UserRegister @usertype='TA', @userName='Leqaaa', @email='leqaa@giu-uni.de', @phone_number='13579', @user_id = @t1 output, @password = @t2 output

DECLARE @t3 int
DECLARE @t4 varchar(10)
EXEC UserRegister @usertype='TA', @userName='amaal', @email='amal@giu-uni.de', @phone_number='1352279', @user_id = @t3 output, @password = @t4 output

DECLARE @t5 int
DECLARE @t6 varchar(10)
EXEC UserRegister @usertype='TA', @userName='Radwa', @email='rado@giu-uni.de', @phone_number='1357599', @user_id = @t5 output, @password = @t6 output


-------------------------------
--adding company

DECLARE @c1 int
DECLARE @c2 varchar(10)
EXEC UserRegister @usertype='company', @userName='dell', @email='dell@company.com',@address = 'DELL-COMPANIES DISTRICT', @company_name='DELL FOR TECHNOLLOGY', @representative_name='dell',@representative_email='dell',@phone_number='13579', @user_id = @c1 output, @password = @c2 output


DECLARE @c3 int
DECLARE @c4 varchar(10)
EXEC UserRegister @usertype='company', @userName='siemens', @email='siemens@company.com',@address = 'SIEMENS-COMPANIES DISTRICT', @company_name='SIEMENS FOR ELECTRONICS', @representative_name='SIEMENS',@representative_email='SIEMENSREPRWSENTINTVE@COMPANY.COM',@phone_number='13579', @user_id = @c3 output, @password = @c4 output

DECLARE @c5 int
DECLARE @c6 varchar(10)
EXEC UserRegister @usertype='company', @userName='H&M', @email='h&m@company.com',@address = 'H&M-COMPANIES DISTRICT', @company_name='H&M FASHION INDUSTRY', @representative_name='H&M',@representative_email='H&M',@phone_number='13579', @user_id = @c5 output, @password = @c6 output
----
--adding employees

INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (224,'emp1','EMP1@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (224,'emp2','EMP2@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (224,'emp3','EMP3@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (225,'emp4','EMP4@SIEMENS.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (225,'emp5','EMP6@SIEMENS.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (225,'emp6','EMP8@SIEMENS.COM','ELECTRIC',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (225,'emp7','EMP9@SIEMSNS.COM','ELECTRIC',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (226,'emp8','EMP10@H&M.COM','FASHION',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (226,'emp9','EMP11@H&M.COM','FASHION',123); 
--@ComapnyID int, @email varchar(50), @name varchar(20), @phone_number varchar(20),
--@field varchar(25),@StaffID int OUTPUT,
DECLARE @e1 int
DECLARE @p1 varchar(10)
EXEC AddEmployee 225, 'dumb@coco.com', 'balawy', '8524555', 'security', @e1 output, @p1 output

------------------------------------------------------------------
--adding external examiner
DECLARE @ee1 int
DECLARE @ee2 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 1', @email='ee1@giu-uni.de',@phone_number =11200367, @user_id = @ee1 output, @password = @ee2 output

DECLARE @ee3 int
DECLARE @ee4 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 2', @email='ee2@giu-uni.de',@phone_number =1123567, @user_id = @ee3 output, @password = @ee4 output

DECLARE @ee5 int
DECLARE @ee6 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 3', @email='ee3@giu-uni.de',@phone_number =1122367, @user_id = @ee5 output, @password = @ee6 output
 
DECLARE @ee7 int
DECLARE @ee8 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 4', @email='ee4@giu-uni.de',@phone_number =1192367, @user_id = @ee7 output, @password = @ee8 output

-- adding coodinator

DECLARE @co1 int
DECLARE @co2 varchar(10)
EXEC UserRegister @usertype='coordinator', @userName='co1', @email='co1@giu-uni.de',@phone_number =1192367, @user_id = @co2 output, @password = @co2 output
DECLARE @co3 int
DECLARE @co4 varchar(10)
EXEC UserRegister @usertype='coordinator', @userName='co2', @email='co2@giu-uni.de',@phone_number =1192367, @user_id = @co3 output, @password = @co4 output

-----------------------------
--CREATING BACHELOR PROJECTS BY COMPANIES

EXEC CompanyCreateLocalProject 224, 'Cons1223', 'Building buildings', 'making alot of nonsense', 'AACE'
EXEC CompanyCreateLocalProject 225, 'spw101', 'SpeedWagon', 'habal ziad w mina', 'RAA'


-----------------------------
--CREATING BACHELOR PROJECTS BY Lecturers
/*
CREATE PROC LecturerCreateLocalProject
@Lecturer_id int, @proj_code varchar(10), @title varchar(50), 
@description varchar(200),
@major_code varchar(10)a
*/

EXEC LecturerCreateLocalProject 222, 'destF','destroy life', 'lecturers can create projects too!', 'ITS'




-----------------------
---Testing makepreferences USER STORY 3A
EXEC MakePreferencesLocalProject 239,'destF',1
---Testing ViewMyThesis USER STORY 3b
EXEC ViewMyThesis 237, 'Astrophysics thesis 1'
--TESTING 5B
EXEC SpecifyThesisDeadline '12/12/2022'

-- TESTING SubmitMyThesis
EXEC SubmitMyThesis 237, 'Astrophysics thesis 1', 'This thesis covers the topics quantum physics, mechanics bas'

EXEC SubmitMyThesis 239, 'design thesis 2', 'in this thesis batresem mn el wad van ko5'
----------------------------------------------------------------------------
--TESTING lecturerCreatesPR
EXEC LecCreatePR 221, 239, '05/10/2030', 'enta walad shater gedan'

EXEC ViewMyProgressReports 239, '05/10/2030'


-- @Lecturer_id int, @sid int, @date datetime, @lecturer_grade decimal(4,2)
EXEC LecGradePR 222, 239, '05/10/2030', 15

UPDATE Student SET Assigned_Project_code = 'destF' WHERE s_id = 239

EXEC ViewMyProgressReports 239, '05/10/2030'



EXEC LecGradedefense 219, 239, 'paris', 15

EXEC EEGradedefense 229, 239, 'paris', 30

EXEC ViewMyDefense 239

EXEC UpdateMyDefense 239, 'Hello bradar velkom to my totorial'

EXEC LecGradeThesis 219, 239, 'design thesis 2', 45

EXEC EEGradeThesis 229, 239, 'design thesis 2', 48.19

EXEC ViewMyThesis 239, 'design thesis 2'

EXEC LecGradePR 219, 239, '05/10/2030', 62

EXEC ViewMyBachelorProjectGrade 239


TRUNCATE TABLE Meeting

EXEC CreateMeeting 222, '9:00:00', '10:00:00', '09/12/2022', 'MiKo'
EXEC CreateMeeting 222, '10:00:01', '11:00:00', '09/12/2022', 'Assig'
EXEC CreateMeeting 222, '11:00:01', '12:00:00', '09/12/2022', '7el'
EXEC CreateMeeting 222, '10:15:00', '12:00:00', '10/12/2022', 'solo'

EXEC ViewMeetingLecturer 222


EXEC ViewEE





EXEC BookMeeting 237, 2
EXEC BookMeeting 237, 3

EXEC ViewNotBookedMeetings 239

EXEC ViewMeeting NULL, 237

EXEC StudentAddToDo 3, 'mawa3een w etba2'
EXEC StudentAddToDo 2, 'showak w sakakeen'
EXEC StudentAddToDo 2, 'antesh wagry'
EXEC LecturerAddToDo 3, 'zaker ll3eyal'
EXEC TAAddToDo 3, 'khalas nam'

DECLARE @syso bit, @userid int
EXEC UserLogin 'ansger.meroth@giu-uni.de', 'B5AF7B57FB', @syso output, @userid output


EXEC ViewProfile 223

EXEC ViewBachelorProjects null, 239

EXEC AssignTAs 231, 218, 'destF'

EXEC BookMeeting 239, 3

EXEC LecturerCreateLocalProject 219, 'db101', 'database', 'make a database for the uni', 'DS'
UPDATE Student SET Assigned_Project_code = 'db101' WHERE s_id = 237

DECLARE @staffid int, @pass varchar(10)
EXEC AddEmployee 226, 'employeeelawel@gmail.com', 'Micheal Jackson', '9651814815', 'Techno', @staffid output, @pass output


UPDATE Student SET Assigned_Project_code = 'spw101'  WHERE s_id = 236
-- @Company_id int, @sid int, @thesis_title varchar(50), @Company_grade Decimal(4,2)
EXEC CompanyGradeThesis 225, 236, 'ali thesis', 10

EXEC AssignEmployee 'spw101', 13, 225

EXEC LecturerCreateLocalProject 219, 'svl', 'savelife', 'life really isnt worth living', 'ITS'

EXEC RecommendEE 220, 'db101', 230

EXEC SuperviseIndustrial 217, 'spw101'


EXEC TACreatePR 241, 234, '03/10/2004', 'araff araff araff'

EXEC ViewUsers 'lecturer', null

EXEC ViewRecommendation 220

EXEC RecommendEE 220, 'svl', 227

EXEC AssignEE 231, 227, 'svl'


EXEC LecturerCreateLocalProject 222, 'proja1','enjoy life', 'lecturers eat potatoes!', 'ITS'
EXEC LecturerCreateLocalProject 222, 'proja2','enhance life', 'lecturers eat mangoes', 'RAA'
EXEC LecturerCreateLocalProject 222, 'proja3','suffer life', 'lecturers eat tomatoes', 'AM'
EXEC LecturerCreateLocalProject 222, 'proja4','eat life', 'lecturers eat Students', 'ME'

EXEC CompanyCreateLocalProject 224, 'proji1', 'mabna el S', 'beet nada gowa', 'AACE'
EXEC CompanyCreateLocalProject 225, 'proji2', 'mabna el m', 'beet slim gowa', 'RAA'
EXEC CompanyCreateLocalProject 224, 'proji3', 'mabna el u', 'beet el sol7efa', 'SE'
EXEC CompanyCreateLocalProject 225, 'proji4', 'mabna el g', 'beet el kalb', 'FD'



EXEC MakePreferencesLocalProject 233,'proja1',1 -- mariam
EXEC MakePreferencesLocalProject 234,'proja2',1 -- ziad 
EXEC MakePreferencesLocalProject 235,'proja1',1 -- mina
EXEC MakePreferencesLocalProject 238,'proji2',1
EXEC MakePreferencesLocalProject 233,'proji1',2
EXEC MakePreferencesLocalProject 234,'proja1',2
EXEC MakePreferencesLocalProject 235,'proja3',2
EXEC MakePreferencesLocalProject 238,'proja4',2


UPDATE Student SET Assigned_Project_code = NULL
EXEC AssignAllStudentsToLocalProject

EXEC ScheduleDefense 238, '11/11/2023', '00:00:00', 'meidan el ta7rir'

EXEC SubmitMyThesis 239, 'destroy life', 'Hello world first year'
EXEC ViewUsers @User_type = null,@User_id=null;
EXEC ViewUsers @User_type = ta,@User_id=218;
EXEC ViewUsers @User_type = ta,@User_id=null;
EXEC ViewUsers @User_type = null,@User_id=218;

DECLARE @staffid int
DECLARE @pass varchar(10)
EXEC AddEmployee 224, 'testingFinal@yahoo.com', '3okasha physics', '565622662', 'Physics', @staffid output, @pass output
--view

EXEC AssignEmployee 'proji2', 13, 225
EXEC EmployeeGradeThesis 13, 238, 'mabna el m', 30
EXEC CompanyGradeThesis 225, 238, 'mabna el m', 40
EXEC ViewMyThesis 238, 'mabna el m'

-- @Employee_id int, @sid int, @defense_location varchar(5), @Employee_grade Decimal(4,2)
EXEC EmployeeGradedefense 13, 238, 'meida', 70
EXEC CompanyGradedefense 225, 238, 'meida', 45
EXEC ViewMyDefense 238
EXEC EmployeeCreatePR 13, 238, '12/11/2022', 'Enta delwa2ty afshal progress report'

EXEC ScheduleDefense 239, '10/2/2021', '12:00:00', 'Giza'

-- @Company_id int, @sid int, @date datetime, @Company_grade decimal(4,2)
EXEC CompanyGradePR 225, 238, '12/11/2022', 90
EXEC ViewMyProgressReports 238, null

-- @Employee_id int, @sid int, @date datetime, @content varchar(1000)
EXEC AssignEmployee 'proji1', 12, 225
EXEC EmployeeCreatePR 12, 233, '10/01/2022', 'Test PR zzzzzzzz'
EXEC CompanyGradePR 225, 233, '10/01/2022', 65
EXEC EmployeeCreatePR 12, 233, '04/09/2050', 'Test PR222 zzzzzzzz'
EXEC CompanyGradePR 225, 233, '04/09/2050', 30
EXEC ViewMyProgressReports 233, '05/09/2050'



