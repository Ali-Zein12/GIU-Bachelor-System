--1 a) 
/* 
a) Register to the website with a unique email, along with the needed information. Choose which type
of user you will be using @usertype (Students, Companies, Lecturers, Teaching assistants, External
examiners, Coordinators, and External supervisors)
Signature:
Name: UserRegister
Input: @usertype varchar(20), @userName varchar(20), @email varchar(50), @first_name varchar(20),
@last_name varchar(20), @birth_date datetime, @GPA decimal(3,2), @semester int, @address var-
char(100), @faculty_code varchar(10), @major_code varchar(10), @company_name varchar(20),
@representative_name varchar(20), @representative_email varchar(50), @phone_number varchar(20),
@country_of_residence varchar(20).
Output: user_id int, password varchar(10)
*/
CREATE PROC UserRegister
@usertype varchar(20), @userName varchar(20), @email varchar(50), @first_name varchar(20)=null,
@last_name varchar(20)=null, @birth_date datetime=null, @GPA decimal(3,2)=null, @semester int=null, @address varchar(100)=null,
@faculty_code varchar(10)=null, @major_code varchar(10)=null, @company_name varchar(20)=null,
@representative_name varchar(20)=null, @representative_email varchar(50)=null, @phone_number varchar(20)=null,
@country_of_residence varchar(20)=null, @user_id int OUTPUT, @password varchar(10) OUTPUT
AS

-- Just changing alphabetic characters to lowercase so that it's easier to check on them.
SET @usertype = lower(@usertype);
SET @password =  CONVERT(varchar(10),LEFT(REPLACE(NEWID(),'-',''),10))
if exists(select * from Users where username like @username) or exists(select * from Users where email like @email)
    print 'username and email must be unique';
else
begin
    INSERT INTO Users(Username,Password,Email,Role,phone_number) values (@userName,@password,@email,@usertype,@phone_number)
    
    SELECT @user_id = user_id FROM Users  WHERE Username = @userName
    if @usertype like 'student' or @usertype like 'students'
    begin
        if @first_name is null or @last_name is null or @birth_date is null or @major_code is null or @address is null or @semester is null or @GPA is null
            print 'Student data is insufficient'
        else
            insert into Student(s_id, first_name,last_name,Major_code,Date_Of_Birth,Address,Semester,GPA) values (@user_id, @first_name,@last_name,@major_code,@birth_date,@address,@semester,@GPA);
            INSERT INTO Thesis (sid, Title) VALUES (@user_id, 'NOT ASSIGNED')
    end

    else if @usertype like 'company' or @usertype like 'companies'
    begin
         if (@company_name is null or @representative_name is null or @representative_email is null or @address is null)
            print 'Inputs are insufficient for a company insert';
         else
            -- we treated the address as the company location
            INSERT INTO Company (Company_id,CompanyName, Representative_name, Representative_Email, CompanyLocation) VALUES (@user_id, @company_name, @representative_name, @representative_email, @address); 
    end
    else if @usertype like 'lecturer' or @usertype like 'lecturers'
        INSERT INTO Lecturer (Lecturer_id) VALUES (@user_id)
    else if @usertype like 'teaching Assistant' or @usertype like 'teaching Assistants' or @usertype like 'ta' or @usertype like 'tas'
        INSERT INTO Teaching_Assistant(TA_id) VALUES (@user_id)
    else if @usertype like 'external examiner' or @usertype like 'external examiners' or @usertype like 'ee' or @usertype like 'ees'
        INSERT INTO External_Examiner(EE_id) VALUES (@user_id)
    else if @usertype like 'coordinator' or @usertype like 'coordinators'
        INSERT INTO Coordinator(coordinator_id) VALUES (@user_id)  
    else
        PRINT 'usertype does not exist --> method UserRegister'
end
print @user_id
print @password
GO



--2 a) 
GO
CREATE PROC UserLogin
@email varchar(50),
@password varchar(10),
@success bit OUTPUT, @user_id int OUTPUT
AS
DECLARE @Save_id AS INT
if (not exists( SELECT * FROM Users WHERE Email = @email))
BEGIN
    PRINT 'This email does not exist'
    SET @success = 0
    SET @user_id = -1
END
Else
BEGIN
    SET @user_id = (SELECT user_id FROM Users WHERE Email = @email)
    if(not exists( SELECT * FROM Users WHERE Email = @email and Password = @password))
    begin
        SET @success = 0
        PRINT 'Incorrect password'
    end
    else
        BEGIN
        SET @success = 1
        PRINT 'Login was successful!'
        END
END
PRINT @user_id
PRINT @success
GO


--2 b)
GO
CREATE PROC ViewProfile
@user_id int
AS
if(not exists(SELECT * FROM Users u WHERE u.user_id = @user_id))
    PRINT 'Incorrect user id'
ELSE
    BEGIN
        if(exists(SELECT * FROM Student s WHERE s.s_id = @user_id))
            SELECT * FROM Users u INNER JOIN Student s ON u.user_id = s.s_id WHERE u.user_id = @user_id
        else if(exists(SELECT * FROM Teaching_Assistant ta WHERE ta.TA_id = @user_id))
            SELECT * FROM Users u INNER JOIN Teaching_Assistant ta ON u.user_id = ta.TA_id WHERE u.user_id = @user_id
        else if(exists(SELECT * FROM Lecturer l WHERE l.Lecturer_id = @user_id))
            SELECT * FROM Users u INNER JOIN Lecturer l ON u.user_id = l.Lecturer_id WHERE u.user_id = @user_id
        else if(exists(SELECT * FROM Coordinator c WHERE c.coordinator_id = @user_id))
            SELECT * FROM Users u INNER JOIN Coordinator c ON u.user_id = c.coordinator_id WHERE u.user_id = @user_id
        else if(exists(SELECT * FROM External_Examiner ee WHERE ee.EE_id = @user_id))
            SELECT * FROM Users u INNER JOIN External_Examiner ee ON u.user_id = ee.EE_id WHERE u.user_id = @user_id
        else if(exists(SELECT * FROM Company co WHERE co.Company_id = @user_id))
            SELECT * FROM Users u INNER JOIN Company co ON u.user_id = co.Company_id WHERE u.user_id = @user_id
    END
GO



--2 c)

GO
CREATE PROC ViewBachelorProjects
@ProjectType varchar(20), @User_id int
AS
DECLARE @role varchar(50)
IF (@ProjectType IS NULL)
    BEGIN
        IF(@User_id IS NULL)
            BEGIN
                ((SELECT * FROM Bachelor_Project bp INNER JOIN Academic a ON bp.Code = a.Academic_code) UNION
                (SELECT * FROM Bachelor_Project bp INNER JOIN Industrial I ON bp.Code = I.Industrial_code))
            END
        ELSE 
            BEGIN
                IF(NOT EXISTS(SELECT * FROM Users u WHERE u.user_id = @User_id))
                    PRINT 'Invalid user id'
                ELSE
                    BEGIN
                        SELECT @role = u.Role  FROM Users u WHERE u.user_id = @User_id
                        SET @role = lower(@role);
                        IF(@role LIKE 'lecturer')
                            SELECT * FROM Bachelor_Project bp WHERE bp.Code IN((SELECT a.Academic_code FROM Academic a WHERE a.L_id = @User_id) UNION
                            ( SELECT i.Industrial_code FROM Industrial i WHERE i.L_id = @User_id))
                        ELSE IF(@role LIKE 'teaching assistant')
                            SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT a.Academic_code FROM Academic a WHERE a.TA_id = @User_id)
                        ELSE IF(@role LIKE 'external examiner')
                            SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT a.Academic_code FROM Academic a WHERE a.EE_id = @User_id)
                        ELSE IF(@role LIKE 'company')
                            SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT i.Industrial_code FROM Industrial i WHERE i.C_id = @User_id)
                        ELSE IF(@role LIKE 'student')
                            SELECT * FROM Student s INNER JOIN Bachelor_Project bp ON s.Assigned_Project_code = bp.Code WHERE s.s_id = @User_id
                    END
            END
    END
    ELSE
        BEGIN
            IF(@ProjectType LIKE 'academic')
                BEGIN
                    IF(@User_id IS NULL)
                        SELECT * FROM Bachelor_Project bp INNER JOIN Academic a ON bp.Code = a.Academic_code
                    SELECT @role = u.Role  FROM Users u WHERE u.user_id = @User_id
                    SET @role = lower(@role);
                    IF(@role LIKE 'lecturer')
                        SELECT * FROM Bachelor_Project bp WHERE bp.Code IN((SELECT a.Academic_code FROM Academic a WHERE a.L_id = @User_id))
                    ELSE IF(@role LIKE 'teaching assistant')
                        SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT a.Academic_code FROM Academic a WHERE a.TA_id = @User_id)
                    ELSE IF(@role LIKE 'external examiner')
                        SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT a.Academic_code FROM Academic a WHERE a.EE_id = @User_id)
                    ELSE IF(@role LIKE 'student')
                        SELECT * FROM Bachelor_Project bp INNER JOIN Student s ON s.Assigned_Project_code = bp.Code 
                        INNER JOIN Academic a ON bp.Code = a.Academic_code WHERE s.s_id = @User_id
                    ELSE IF(@role LIKE 'company')
                        PRINT 'Cannot get academic bachelor projects for Companies'
                END
            ELSE IF(@ProjectType LIKE 'industrial')
                BEGIN
                    IF(@User_id IS NULL)
                        SELECT * FROM Bachelor_Project bp INNER JOIN Industrial i ON bp.Code = i.Industrial_code
                    SELECT @role = u.Role  FROM Users u WHERE u.user_id = @User_id
                    SET @role = lower(@role);
                    IF(@role LIKE 'lecturer')
                        SELECT * FROM Bachelor_Project bp WHERE bp.Code IN((SELECT i.Industrial_code FROM Industrial i WHERE i.L_id = @User_id))
                    ELSE IF(@role LIKE 'teaching assistant' OR @role LIKE 'external examiner')
                        PRINT ('Cannot get Industrial bachelor projects for teaching assistants or external examiners')
                    ELSE IF(@role LIKE 'student')
                        SELECT * FROM Bachelor_Project bp INNER JOIN Student s ON s.Assigned_Project_code = bp.Code 
                        INNER JOIN Industrial i ON bp.Code = i.Industrial_code WHERE s.s_id = @User_id
                    ELSE IF(@role LIKE 'company')
                        SELECT * FROM Bachelor_Project bp WHERE bp.Code IN(SELECT i.Industrial_code FROM Industrial i WHERE i.C_id = @User_id)
                END
        END
GO


--3 a)
CREATE PROC MakePreferencesLocalProject
@sid int,@bachelor_code varchar(10), @preference_number int
AS
if(exists(select * from Student where @sid = s_id) and exists(select * from Bachelor_Project where @bachelor_code = Code))
begin
INSERT INTO StudentPreferences(sid, PCode, PreferenceNumber) values (@sid,@bachelor_code,@preference_number)
PRINT 'Preference added successfully'
end
else
    if(not exists(select * from Student where @sid = s_id))
        PRINT 'This student ID does not exist'
    else
        PRINT 'This Bachelor Project ID does not exist'
GO




--3 b)
CREATE PROC ViewMyThesis
@sid int, @title varchar(50)
AS
DECLARE @grade1 decimal(5,2), @grade2 decimal(5,2)
SET @grade1=0
SET @grade2=0
if(exists(select * from Thesis where @sid = sid and @title = Title))
begin
    if(exists(select * from GradeAcademicThesis where @sid = sid and @title = Title and EE_grade is not null and Lecturer_grade is not null))
        select @grade1=EE_grade,@grade2=Lecturer_grade from GradeAcademicThesis where title = @title and @sid = sid
    else if(exists(select * from GradeIndustrialThesis where @sid = sid and @title = Title and Company_grade is not null and Employee_grade is not null))
        select @grade1=Company_grade,@grade2=Employee_grade from GradeIndustrialThesis where title = @title and @sid = sid
    UPDATE Thesis

    SET Total_grade = (@grade1+@grade2)/2
    where sid = @sid and Title = @title
    select * FROM Thesis WHERE sid = @sid and Title=@title
end
else
    if(not exists(select * from Student where @sid = s_id))
        PRINT 'This student ID does not exist'
    else
        PRINT 'This thesis title does not exist'
GO




--3 c)
CREATE PROC SubmitMyThesis
@sid int, @title varchar(50), @PDF_Document varchar(1000)
AS
if(exists(select * from Student where @sid = s_id))
begin
if(exists(select * FROM Thesis WHERE @sid = sid AND @title = Title))
begin
UPDATE Thesis
SET PDF_doc = @PDF_Document WHERE sid = @sid AND Title = @title;
end
else
    PRINT 'This thesis title does not exist'
end
else
    PRINT 'This student ID does not exist'

GO



--3 d)
CREATE PROC ViewMyProgressReports
@sid int, @date datetime
AS
DECLARE @grade2 decimal(4,2)
SET @grade2=0
if(exists(select * from Student where @sid = s_id))
    begin
        if(exists(select * from GradeAcademicPR where @sid = sid and @date = Date and Lecturer_grade is not null))
        select @grade2=Lecturer_grade from GradeAcademicPR where Date = @date and @sid = sid
    else if(exists(select * from GradeIndustrialPR where @sid = sid and Date = @date and Company_grade is not null))
        select @grade2=Company_grade from GradeIndustrialPR where Date = @date and @sid = sid
    UPDATE ProgressReport
    SET Grade = @grade2
    where sid = @sid and Date = @date
    UPDATE ProgressReport SET ComulativeProgressReportGrade = (SELECT AVG(Grade) FROM ProgressReport WHERE sid = @sid)
    WHERE sid = @sid
    if(exists(select * from ProgressReport where sid = @sid and Date = @date))
        select * from ProgressReport where sid = @sid and Date = @date
    else
        begin
            PRINT 'A Progress report of this specific date does not exist'
            select * from ProgressReport where sid = @sid order by Date desc;
        end
    end
else
    PRINT 'This student ID does not exist'
GO



--3 e)
CREATE PROC ViewMyDefense
@sid int
AS
DECLARE @grade1 decimal(5,2), @grade2 decimal(5,2)
SET @grade1=0
SET @grade2=0
if(exists(select * from Student where @sid = s_id))
begin
    if(exists(select * from Defense where @sid = sid))
    begin
        if(exists(select * from GradeAcademicDefense where @sid = sid and EE_grade is not null and Lecturer_grade is not null))
            select @grade1=EE_grade,@grade2=Lecturer_grade from GradeAcademicDefense where @sid = sid
        else if(exists(select * from GradeIndustrialDefense where @sid = sid and Company_grade is not null and Employee_grade is not null))
            select @grade1=Company_grade,@grade2=Employee_grade from GradeIndustrialDefense where @sid = sid
        UPDATE Defense
        SET Total_grade = (@grade1+@grade2)/2
        where sid = @sid
        select * FROM Defense WHERE sid = @sid
    end
    else
    PRINT 'This student has no Defense'
end
else
    PRINT 'This student ID does not exist'

GO




--3 f) im really dissapointed in you Mina ^_^
CREATE PROC UpdateMyDefense
@sid int, @defense_content varchar(1000)
AS
if(exists(select * from Student where @sid = s_id))
begin
    UPDATE Defense
    SET Content = @defense_content where sid = @sid
end
else
    PRINT 'This student ID does not exist'

GO



--3 g)
CREATE PROC ViewMyBachelorProjectGrade
@sid int
AS
DECLARE @grade1 decimal(5,2), @grade2 decimal(5,2), @grade3 decimal(5,2)
SET @grade1=0
SET @grade2=0
SET @grade3=0
if(exists(select * from Student where @sid = s_id))
begin
    SET @grade1 = (select Total_grade from Thesis where sid = @sid)
    SET @grade2 = (select Total_grade from Defense where sid = @sid)
    SET @grade3 = (select ComulativeProgressReportGrade from ProgressReport where sid = @sid)
    if(@grade1<>0 and @grade2<>0 and @grade3<>0)
    begin
        UPDATE Student
        SET TotalBachelorGrade = (0.3*@grade1)+(0.3*@grade2)+(0.4*@grade3) WHERE s_id = @sid
        select TotalBachelorGrade from Student where s_id = @sid
    end
    else
        select null as TotalBachelorGrade
end
else
    PRINT 'This student ID does not exist'
GO



--3 h)
CREATE PROC ViewNotBookedMeetings
@sid int
AS
DECLARE @supervisorid varchar(20)
SET @supervisorid = null
if(exists(select * from Student where @sid = s_id))
begin
    SET @supervisorid = (select a.L_id from Student s inner join Bachelor_Project b on s.s_id = @sid and s.Assigned_Project_code = b.Code inner join Academic a on b.Code = a.Academic_code)
    if(@supervisorid is null)
        SET @supervisorid = (select i.L_id from Student s inner join Bachelor_Project b on s.s_id = @sid and s.Assigned_Project_code = b.Code inner join Industrial i on b.Code = i.L_id)
    select * 
    FROM Meeting m1
    Where Meeting_ID in ((select Meeting_ID from Meeting where L_id = @supervisorid) except (select distinct Meeting_ID from MeetingAttendents where Attendant_id in (select s_id from Student)))
end
else
    PRINT 'This student ID does not exist'
GO


--3 i)
CREATE PROC BookMeeting
@sid int, @meeting_id int
AS
DECLARE @supervisorid int
SET @supervisorid = null
DECLARE @TAid int
SET @TAid = null
if(exists(select * from Student where @sid = s_id))
begin
    if(exists(select * from Meeting where @meeting_id = Meeting_ID))
    begin
        SET  @TAid = (SELECT a.TA_id FROM Student s INNER JOIN Academic a ON a.Academic_code = s.Assigned_Project_code WHERE s.s_id = @sid)
        IF(@TAid IS NOT NULL)
            INSERT INTO MeetingAttendents VALUES (@meeting_id, @TAid)
        SET @supervisorid = (select a.L_id from Student s inner join Bachelor_Project b on s.s_id = @sid and s.Assigned_Project_code = b.Code inner join Academic a on b.Code = a.Academic_code)
        if(@supervisorid is null)
            SET @supervisorid = (select i.L_id from Student s inner join Bachelor_Project b on s.s_id = @sid and s.Assigned_Project_code = b.Code inner join Industrial i on b.Code = i.L_id)
        if @meeting_id in ((select Meeting_ID from Meeting where L_id = @supervisorid) except (select distinct Meeting_ID from MeetingAttendents where Attendant_id in (select s_id from Student)))
            INSERT INTO MeetingAttendents(Meeting_ID,Attendant_id) values (@meeting_id,@sid)
        else
            PRINT 'You can not book this meeting, either because it is already booked or it does not belong to your supervisor'
    end
    else
        PRINT 'This meeting ID does not exist'
end
else
    PRINT 'This student ID does not exist'
GO



--3 j)
CREATE PROC ViewMeeting
@meeting_id int, @sid int
AS
if(exists(select * from Student where @sid = s_id))
begin
    if(exists(select * from Meeting where @meeting_id = Meeting_ID))
    begin
        select m.* from Meeting m inner join MeetingAttendents ma on m.Meeting_ID = ma.Meeting_ID where ma.Meeting_ID = @meeting_id and ma.Attendant_id = @sid
        select mtdl.* FROM MeetingToDoList mtdl where mtdl.Meeting_ID = @meeting_id
    end
    else
    begin
        select m.* from Meeting m inner join MeetingAttendents ma on m.Meeting_ID = ma.Meeting_ID where ma.Attendant_id = @sid
        select mtdl.* FROM MeetingToDoList mtdl inner join MeetingAttendents ma on mtdl.Meeting_ID = ma.Meeting_ID where ma.Attendant_id = @sid
    end
end
else
    PRINT 'This student ID does not exist'

GO




--3 k)
CREATE PROC StudentAddToDo
@meeting_id int, @to_do_list varchar(200)
AS
if(exists(select * from Meeting where @meeting_id = Meeting_ID))
begin
   IF(EXISTS(SELECT * FROM MeetingToDoList WHERE Meeting_ID = @meeting_id AND ToDoList = @to_do_list))
        PRINT'This item is on the to do list of the meeting' 
   ELSE
        INSERT INTO MeetingToDoList(Meeting_ID,ToDoList) values(@meeting_id,@to_do_list)
end
else
    PRINT 'This meeting ID does not exist'
GO

--4 a)
GO
CREATE PROC AddEmployee
@ComapnyID int, @email varchar(50), @name varchar(20), @phone_number varchar(20),
@field varchar(25),@StaffID int OUTPUT,
@password varchar(10) OUTPUT 
AS
SET @password =  CONVERT(varchar(10),LEFT(REPLACE(NEWID(),'-',''),10))
IF @name IS NULL or @email IS NULL or
    @ComapnyID IS NULL or 
    @phone_number IS NULL or @field IS NULL
    PRINT 'One of the inputs is null'
ELSE
    BEGIN
      INSERT INTO Employee (Company_id,Email,Username,Phone,Field, EmployeePassword) values(@ComapnyID,@email,@name,@phone_number,@field, @password)
      SET @StaffID = (SELECT MAX(Staff_id) FROM Employee )
      SET @ComapnyID =(SELECT Employee.Company_id FROM Employee WHERE @StaffID = Staff_id)
      SELECT e.Company_id, e.Staff_id, e.EmployeePassword  FROM Employee e WHERE e.Staff_id = @StaffID AND e.Company_id = @ComapnyID
    END
GO      

       
--4 b)
GO
CREATE PROC CompanyCreateLocalProject 
@company_id int, @proj_code varchar(10), @title varchar(50), @description varchar(200),
@major_code  varchar(10)=null
AS
        if @proj_code is null or @description is null or @title IS NULL OR @major_code IS NULL
            print 'Insufficant data '
        else 
        BEGIN
                
            INSERT INTO Bachelor_Project(Code,Description,Name) VALUES(@proj_code,@description,@title)
            INSERT INTO Industrial(Industrial_code,C_id) values(@proj_code,@company_id)
            INSERT INTO MajorHasBachelorProject(Project_code,Major_code) values(@proj_code,@major_code)
            
        END
GO


--4 c) 
GO
CREATE PROC AssignEmployee
@bachelor_code varchar(10), @staff_id int, @Company_id int
AS
IF(@bachelor_code IS NULL OR @staff_id IS NULL OR @Company_id IS NULL)
    PRINT ('One of the inputs to the procedure AssignEmployee is null.')
ELSE IF(NOT EXISTS(SELECT * FROM Bachelor_Project WHERE Code = @bachelor_code))
    PRINT ('Invalid bachelor projectc code')
ELSE IF(NOT EXISTS(SELECT * FROM Company WHERE Company_id = @Company_id))
    PRINT ('Invalid company id')
ELSE IF(NOT EXISTS(SELECT * FROM Industrial WHERE Industrial_code = @bachelor_code))
    PRINT ('This project is not an industrial one to assign an employee to it.')
ELSE IF(NOT EXISTS(SELECT * FROM Employee WHERE Staff_id = @staff_id AND Company_id = @Company_id))
    PRINT ('This employee does not belong to this company')
ELSE
    BEGIN
        UPDATE Industrial SET E_id = @staff_id, C_id = @Company_id WHERE Industrial_code = @bachelor_code
        SELECT * FROM Bachelor_Project bp INNER JOIN Industrial i ON bp.Code = i.Industrial_code WHERE E_id = @staff_id AND @Company_id = @Company_id AND bp.Code = @bachelor_code
    END
GO
    

 --4 d)
GO
CREATE PROC CompanyGradeThesis
@Company_id int, @sid int, @thesis_title varchar(50), @Company_grade Decimal(4,2)
AS
IF( @Company_id IS NULL OR @sid IS NULL OR @thesis_title IS NULL OR @Company_grade IS NULL )
    PRINT 'ONE OF THE INPUTS IS NULL HEHE'

ELSE
    BEGIN
        DECLARE @compid int
        SELECT @compid = i.C_id FROM Student s INNER JOIN Industrial i ON s.Assigned_Project_code = i.Industrial_code AND s.s_id = @sid
        IF(@compid <> @Company_id)
            PRINT 'This company is not assigned to this project'
        ELSE
            BEGIN
                IF (exists( SELECT * from GradeIndustrialThesis T
                        WHERE T.sid =@sid AND Title = @thesis_title))
                        BEGIN
                            update GradeIndustrialThesis 
                            SET Company_grade=@Company_grade, C_id = @Company_id
                                WHERE sid=@sid
                        END
                    ELSE
                        INSERT INTO GradeIndustrialThesis (sid, Title, C_id, Company_grade) VALUES (@sid, @thesis_title, @Company_id, @Company_grade)
            END
    END
GO
     /*CREATE PROC EEGradeThesis @EE_id int, @sid int, @thesis_title varchar(50), @EE_grade Decimal(4,2) AS
     IF exists(SELECT a.EE_id,a.sid,a.Title 
     FROM GradeAcademicThesis a 
     WHERE a.EE_id= @EE_id AND a.sid=@sid AND a.Title =@thesis_title) BEGIN 
     UPDATE GradeAcademicThesis 
     SET EE_grade=@EE_grade 	
     WHERE EE_id= @EE_id AND sid=@sid AND Title =@thesis_title END ELSE PRINT 'invalid External examiner id , student id or Thesis title' GO*/

--4 e)
GO
CREATE PROC CompanyGradedefense
@Company_id int, @sid int, @defense_location varchar(5), @Company_grade Decimal(4,2)
AS
IF (@Company_id IS NULL OR @sid IS NULL OR @defense_location IS NULL OR @Company_grade IS NULL)
PRINT 'ONE OF THE INPUTS IS NULL NOT HEHE' 
IF EXISTS( SELECT D.C_id,D.Location,D.sid FROM GradeIndustrialDefense D
WHERE D.Location =@defense_location AND D.sid =@sid)
    UPDATE GradeIndustrialDefense 
    SET Company_grade=@Company_grade, C_id = @Company_id
    WHERE SID=@sid AND Location=@defense_location
ELSE 
    INSERT INTO GradeIndustrialDefense (sid, Location, C_id, Company_grade) VALUES (@sid, @defense_location, @Company_id, @Company_grade)
    GO

--4-f) JUST FINISH THIS
GO
CREATE PROC CompanyGradePR
        @Company_id int, @sid int, @date datetime, @Company_grade decimal(4,2)
AS
IF (@Company_id IS NULL OR @sid IS NULL OR @date IS NULL OR @Company_grade IS NULL)
    PRINT 'ONE OF THE INPUTS IS NULL'
ELSE IF exists( select * from Student S inner join Bachelor_Project BP 
ON S.Assigned_Project_code= BP.Code INNER JOIN Industrial I ON I.Industrial_code=BP.Code)
    BEGIN
        IF EXISTS( SELECT * FROM GradeIndustrialPR P
        WHERE P.C_id =@Company_id AND P.sid =@sid AND P.Date = @date )
             BEGIN
                 update GradeIndustrialPR 
             SET Company_grade=@Company_grade
                    WHERE C_id=@Company_id AND sid = @sid AND Date = @date
                    END 
                    END
                    ELSE
                    PRINT
                    'Company does not have student with industrial bachelor project or wrong inputs'
            GO

--5 a)
GO 
CREATE PROC LecturerCreateLocalProject
@Lecturer_id int, @proj_code varchar(10), @title varchar(50), 
@description varchar(200),
@major_code varchar(10)
AS
IF (@Lecturer_id IS NULL OR @proj_code IS NULL OR @title IS NULL OR @major_code IS NULL)
PRINT 'ONE OF THE KEY INPUTS IS NULL :('
 --STILL NOT SURE ABOUT NAME = TITLE WINKYFACE
  INSERT INTO Bachelor_Project(Code,Description,Name) VALUES(@proj_code,@description,@title)
  INSERT INTO Academic (Academic_code,L_id) VALUES(@proj_code,@Lecturer_id)
  INSERT INTO MajorHasBachelorProject(Project_code,Major_code) VALUES(@proj_code,@major_code)
GO
 

 --5 b) 
 GO
 CREATE PROC SpecifyThesisDeadline
  @deadline datetime
 AS
 IF (@deadline IS NULL)
 PRINT 'YOU DIDNT INSERT A DEADLINE :('
 ELSE
   BEGIN
     UPDATE Thesis SET Deadline = @deadline
   END
 GO

 --5 c)
GO
CREATE PROC CreateMeeting
@Lecturer_id int, @start_time time, @end_time time, @date datetime, @meeting_point
varchar(5)
AS
IF(@Lecturer_id IS NULL OR @start_time IS NULL OR @end_time IS NULL OR @date IS NULL OR @meeting_point IS NULL OR @start_time >= @end_time)
    PRINT 'One of the inputs are null OR invalid start time.'
ELSE
    BEGIN
        IF(EXISTS( SELECT * FROM Meeting m WHERE Date = @date AND L_id = @Lecturer_id AND ((@start_time between STime and ETime) OR @end_time between STime and ETime)))
            PRINT 'HEY SIR / madaam! you could not Create all these meetings together. CHILL YASTA/YA 7AGA'
        ELSE
            BEGIN
                INSERT INTO Meeting (L_id,STime,ETime,Date,Meeting_Point)VALUES(@Lecturer_id,@start_time,@end_time,@date,@meeting_point)
                INSERT INTO MeetingAttendents VALUES ((SELECT m.Meeting_ID FROM Meeting m WHERE m.L_id = @Lecturer_id AND m.STime = @start_time AND m.ETime = @end_time AND m.Meeting_Point = @meeting_point), @Lecturer_id)
            END
    END
GO

--5 d)
GO
CREATE PROC LecturerAddToDo
@meeting_id int, @to_do_list varchar(200)
AS
IF(@meeting_id IS NULL OR @to_do_list IS NULL )
PRINT 'ONE OF THE INPUTS IS NULL'
ELSE
    BEGIN
        IF(EXISTS(SELECT * FROM MeetingToDoList WHERE Meeting_ID = @meeting_id AND ToDoList = @to_do_list))
            PRINT'This item is on the to do list of the meeting' 
        ELSE IF EXISTS ( SELECT * FROM Lecturer L INNER JOIN Meeting M ON L.Lecturer_id = M.L_id)
                INSERT INTO MeetingToDoList(Meeting_ID,ToDoList) VALUES(@meeting_id,@to_do_list)
        ELSE 
            PRINT 'LECTURER DOSENT HAVE A MEETING'
    END

GO



--5 e) //Ali
GO
CREATE PROC ViewMeetingLecturer
 @Lecturer_id int, @meeting_id int = null
 AS
 IF (@Lecturer_id is null)
    PRINT ('Lecturer ID must be passed as a parameter to the procedure ViewMeetingLecturer')
ELSE
    BEGIN
        IF (NOT EXISTS( SELECT * FROM Lecturer l WHERE l.Lecturer_id = @Lecturer_id))
            PRINT ('Invalid Lecturer ID')
        ELSE 
            BEGIN
                IF(@meeting_id is null)
                    SELECT * FROM Meeting m WHERE m.L_id = @Lecturer_id ORDER BY m.Date ASC
                ELSE 
                    BEGIN
                        IF(NOT EXISTS(SELECT * FROM Meeting m WHERE m.Meeting_ID = @meeting_id))
                            PRINT ('Invalid Meeting ID')
                        ELSE
                            SELECT * FROM Meeting m WHERE m.L_id = @Lecturer_id and m.Meeting_ID = @meeting_id
                    END
            END
    END
GO



--5 f) //Ali
GO
CREATE PROC ViewEE
AS
SELECT * FROM External_Examiner ee WHERE ee.EE_id IN (SELECT EE_id FROM External_Examiner EXCEPT (SELECT EE_id FROM LecturerRecommendEE))
GO



--5 g)  //Ali
GO
CREATE PROC RecommendEE
@Lecturer_id int, @proj_code varchar(10), @EE_id int
AS
IF(@Lecturer_id IS NULL OR @proj_code IS NULL OR @EE_id IS NULL)
    PRINT('Some of the inputs to the RecommendEE procedure are null')
ELSE
    BEGIN
        IF(NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id))
            PRINT ('Incorrect Lecturer ID')
        ELSE IF(NOT EXISTS(SELECT * FROM External_Examiner WHERE EE_id = @EE_id))
            PRINT ('Incorrect External Examiner ID')
        ELSE IF(NOT EXISTS(SELECT * FROM Bachelor_Project WHERE Code = @proj_code))
            PRINT ('Incorrect Project code')
        ELSE IF(NOT EXISTS(SELECT * FROM Academic WHERE Academic_code = @proj_code))
            PRINT ('Bachelor project must be academic to recommend an External Examiner on')
        ELSE
            INSERT INTO LecturerRecommendEE (L_id, EE_id, PCode) VALUES (@Lecturer_id, @EE_id, @proj_code)
    END
GO



--5 h) SOMETHING IS WEIRD THAT THE COORDINATOR HAS NOTHING TO DO WITH ASSIGNING THE Lecturer //Ali
GO
CREATE PROC SuperviseIndustrial
@Lecturer_id int, @proj_code varchar(10)
AS 
IF(@Lecturer_id IS NULL OR @proj_code IS NULL)
    PRINT('Some of the parameters are null for the procedure SuperviseIndustrial')
ELSE
    BEGIN
        IF(NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id))
            PRINT('Invalid Lecturer ID')
        ELSE IF(NOT EXISTS(SELECT * FROM Bachelor_Project WHERE Code = @proj_code))
            PRINT('Invalid Project code')
        ELSE IF(NOT EXISTS(SELECT * FROM Industrial WHERE Industrial_code = @proj_code))
            PRINT('This project is not an industrial one')
        ELSE
            UPDATE Industrial SET L_id = @Lecturer_id WHERE Industrial_code = @proj_code
    END
GO



--5 i)  //Ali
GO
CREATE PROC LecGradeThesis
@Lecturer_id int, @sid int, @thesis_title varchar(50), @Lecturer_grade Decimal(4,2)
AS
IF(@Lecturer_id IS NULL OR @sid IS NULL OR @thesis_title IS NULL OR @Lecturer_grade IS NULL)
    PRINT('Invalid input to the method LecGradeThesis')
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id))
            PRINT 'Invalid Lecturer'
        ELSE IF (NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
            PRINT 'Invalid Lecturer'
        ElSE IF (NOT EXISTS(SELECT * FROM Thesis WHERE Title = @thesis_title))
            PRINT 'Invalid Thesis Title'
        ELSE
            IF(EXISTS(SELECT * FROM GradeAcademicThesis WHERE sid = @sid AND Title = @thesis_title))
                UPDATE GradeAcademicThesis SET L_id = @Lecturer_id, Lecturer_grade = @Lecturer_grade  -- if an external examiner already started grading the thesis
            ELSE
                INSERT INTO GradeAcademicThesis (sid, Title, L_id, Lecturer_grade) VALUES (@sid, @thesis_title, @Lecturer_id, @Lecturer_grade)
    END
GO



--5 j)  //Ali
GO
CREATE PROC LecGradedefense
@Lecturer_id int, @sid int, @defense_location varchar(5), @Lecturer_grade Decimal(4,2)
AS
IF(@Lecturer_id IS NULL OR @sid IS NULL OR @defense_location IS NULL OR @Lecturer_grade IS NULL)
    PRINT('Invalid input to the method LecGradedefense')
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id))
            PRINT 'Invalid Lecturer'
        ELSE IF (NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
            PRINT 'Invalid Student'
        ELSE
            IF(EXISTS(SELECT * FROM GradeAcademicDefense WHERE sid = @sid AND Location = @defense_location))
                UPDATE GradeAcademicDefense SET L_id = @Lecturer_id, Lecturer_grade = @Lecturer_grade -- if an external examiner already started grading the defense
            ELSE
                INSERT INTO GradeAcademicDefense(sid, Location, L_id, Lecturer_grade) VALUES (@sid, @defense_location, @Lecturer_id, @Lecturer_grade)
   END
GO



--5 k)  //Ali
GO
CREATE PROC LecCreatePR
@Lecturer_id int, @sid int, @date datetime, @content varchar(1000)
AS
IF(@Lecturer_id IS NULL OR @sid IS NULL OR @date IS NULL OR @content IS NULL)
    PRINT('Invalid input to the method LecCreatePR')
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @Lecturer_id))
            PRINT 'Invalid Lecturer'
        ELSE IF (NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
            PRINT 'Invalid Student'
        ELSE
            INSERT INTO ProgressReport (sid, Date, Content, UpdatingUser_id) VALUES (@sid, @date, @content, @Lecturer_id)
    END
GO



--5 l) a little tricky  //Ali
GO
CREATE PROC LecGradePR
@Lecturer_id int, @sid int, @date datetime, @lecturer_grade decimal(4,2)
AS
-- sid -> student -> assigned bachelor -> academic
DECLARE @code varchar(50)
SELECT @code = Assigned_Project_code FROM Student WHERE s_id = @sid
IF(NOT EXISTS(SELECT * FROM Bachelor_Project WHERE Code = @code))
    PRINT 'Invalid bachelor project'
ELSE IF(NOT EXISTS(SELECT * FROM Academic WHERE Academic_code = @code))
    PRINT 'Lecturer can only grade progress reports belongling to academic bachelor projects only'
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM GradeAcademicPR WHERE sid = @sid AND Date = @date))
            INSERT INTO GradeAcademicPR (L_id, sid, Date, Lecturer_grade) VALUES (@Lecturer_id, @sid, @date, @lecturer_grade)
        ELSE
            UPDATE GradeAcademicPR SET L_id = @Lecturer_id, Lecturer_grade = @lecturer_grade
        UPDATE ProgressReport SET Grade = @lecturer_grade WHERE sid = @sid AND Date = @date
        UPDATE ProgressReport SET ComulativeProgressReportGrade = (SELECT AVG(Grade) FROM ProgressReport WHERE sid = @sid) WHERE sid = @sid -- not sure
    END
GO



--6 a) just like 5 k)  //Ali
GO
CREATE PROC TACreatePR
@TA_id int, @sid int, @date datetime, @content varchar(1000)
AS
IF(@TA_id IS NULL OR @sid IS NULL OR @date IS NULL OR @content IS NULL)
    PRINT('Invalid input to the method LecCreatePR')
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM Teaching_Assistant WHERE TA_id = @TA_id))
            PRINT 'Invalid TA'
        ELSE IF (NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
            PRINT 'Invalid Student'
        ELSE
            INSERT INTO ProgressReport (sid, Date, Content, UpdatingUser_id) VALUES (@sid, @date, @content, @TA_id)
    END
GO



--6 b) anyone can use it not just the TA....  //Ali
GO
CREATE PROC TAAddToDo
@meeting_id int, @to_do_list varchar(200)
AS
IF(@meeting_id IS NULL OR @to_do_list IS NULL)
    PRINT('Invalid input to the method TAAddToDo')
ELSE
    BEGIN
        IF(NOT EXISTS(SELECT * FROM Meeting WHERE Meeting_ID = @meeting_id))
            PRINT 'Invalid meeting id'
        ELSE
            INSERT INTO MeetingToDoList (Meeting_ID, ToDoList) VALUES (@meeting_id, @to_do_list)
    END
GO




--7)a
--External examiner grades only the Academic Thesis
-- wil add dummy data to test later
GO
CREATE PROC EEGradeThesis
@EE_id int, @sid int, @thesis_title varchar(50), @EE_grade Decimal(4,2)
AS
IF exists(SELECT a.EE_id,a.sid,a.Title
          FROM GradeAcademicThesis a
          WHERE a.sid=@sid AND a.Title =@thesis_title)
   BEGIN
    UPDATE  GradeAcademicThesis 
    SET EE_grade=@EE_grade, EE_id = @EE_id
    WHERE sid=@sid AND Title =@thesis_title
   END
ELSE
PRINT 'invalid External examiner id , student id or Thesis title'
GO


--7)b)
GO 
CREATE PROC EEGradedefense
@EE_id int, @sid int, @defense_location varchar(5), @EE_grade Decimal(4,2)
AS
IF exists(SELECT *
          FROM GradeAcademicDefense AD
          WHERE  AD.sid=@sid AND AD.Location=@defense_location)
        UPDATE GradeAcademicDefense
        SET GradeAcademicDefense.EE_grade = @EE_grade, EE_id = @EE_id
        WHERE GradeAcademicDefense.sid=@sid AND GradeAcademicDefense.Location=@defense_location
ELSE
PRINT 'Invalid External Examiner id ,student id or location'
GO



--8 a)
GO
CREATE PROC ViewUsers
@User_type varchar(20), @User_id int
AS
SET @User_type = lower(@User_type);

IF(@User_id IS NULL)
  BEGIN
    IF(@User_type is NULL)
        SELECT * FROM Users
    ELSE
        BEGIN
            IF  @User_type LIKE 'lecturer' OR  @User_type LIKE 'lecturers'
                SELECT * FROM Users INNER JOIN Lecturer ON Users.user_id= Lecturer.Lecturer_id 
            IF  @User_type LIKE  'teaching Assistant' or @User_type like 'teaching Assistants' or @User_type like 'ta' or @User_type like 'tas'
                SELECT * FROM Users INNER JOIN Teaching_Assistant ON Users.user_id= Teaching_Assistant.TA_id 

            IF  @User_type LIKE 'external examiner' or @User_type like 'external examiners' or @User_type like 'ee' or @User_type like 'ees'
                SELECT * FROM Users INNER JOIN External_Examiner ON Users.user_id= External_Examiner.EE_id

            IF  @User_type LIKE 'coordinator' or @User_type like 'coordinators'
                    SELECT * FROM Users INNER JOIN Coordinator ON Users.user_id= Coordinator.coordinator_id

            IF  @User_type LIKE 'student' or @User_type like 'students'
                SELECT * FROM Users INNER JOIN  Student ON Users.user_id= Student.s_id
        END
    END
ELSE
    BEGIN
        IF(NOT EXISTS(SELECT * FROM Users WHERE user_id = @User_id))
            PRINT 'Invalid user id'
        ELSE
            EXEC ViewProfile @User_id
    END
GO


        
/*
if(@User_id IS NULL AND @User_type IS NULL)
    SELECT * FROM Users
else if(@User_id IS NOT NULL)
    BEGIN 
        IF(NOT EXISTS(SELECT * FROM Users WHERE user_id = @User_id))
            PRINT 'Invalid user id'
        ELSE
            SELECT * FROM Users WHERE user_id = @User_id
    END
ELSE if  @User_id is null AND Exists(SELECT *FROM Users u  WHERE  u.Role=@User_type)    
   BEGIN
       IF  @User_type LIKE 'lecturer' OR  @User_type LIKE 'lecturers'
         SELECT * FROM Users INNER JOIN Lecturer ON Users.user_id= Lecturer.Lecturer_id 
       IF  @User_type LIKE  'teaching Assistant' or @User_type like 'teaching Assistants' or @User_type like 'ta' or @User_type like 'tas'
            SELECT * FROM Users INNER JOIN Teaching_Assistant ON Users.user_id= Teaching_Assistant.TA_id 

       IF  @User_type LIKE 'external examiner' or @User_type like 'external examiners' or @User_type like 'ee' or @User_type like 'ees'
          SELECT * FROM Users INNER JOIN External_Examiner ON Users.user_id= External_Examiner.EE_id

       IF  @User_type LIKE 'coordinator' or @User_type like 'coordinators'
             SELECT * FROM Users INNER JOIN Coordinator ON Users.user_id= Coordinator.coordinator_id

       IF  @User_type LIKE 'student' or @User_type like 'students'
          SELECT * FROM Users INNER JOIN  Student ON Users.user_id= Student.s_id
   End
ELSE IF exists(SELECT * FROM Users u WHERE (u.Role=@User_type AND u.user_id = @User_id ))
    BEGIN
        if(not exists(SELECT * FROM Users u WHERE (u.Role=@User_type AND u.user_id = @User_id )))
            PRINT 'Invalid role or id'
        Declare @helper int
        EXEC ViewProfile @helper= @User_id
    END
    */


--8 b)

GO
CREATE PROC AssignAllStudentsToLocalProject
AS
DECLARE @totalNumOfStudents int;
DECLARE @studentid int;
DECLARE @curStudentPref varchar(50);

CREATE TABLE #Temp
(
id int IDENTITY,
sid INT,
GPA DECIMAL (3, 2),
Pcode VARCHAR (10),
PreferenceNumber int
)

INSERT INTO #Temp
SELECT sid, GPA, PCode, PreferenceNumber
FROM StudentPreferences inner join Student ON sid = s_id ORDER BY GPA ASC,PreferenceNumber ASC

DECLARE CUR_TEST CURSOR FAST_FORWARD FOR
SELECT sid FROM #Temp

OPEN CUR_TEST
FETCH NEXT FROM CUR_TEST INTO @studentid

SET @totalNumOfStudents = (select count(s_id) FROM Student)

WHILE @@FETCH_STATUS = 0
BEGIN
   SET @curStudentPref = (select top 1 PCode from #Temp where sid = @studentid ORDER BY GPA ASC,PreferenceNumber ASC)
   if (NOT EXISTS (select * from Student WHERE Assigned_Project_code = @curStudentPref))
   begin
       UPDATE Student
       SET Assigned_Project_code = @curStudentPref where s_id = @studentid
       DELETE FROM #Temp WHERE sid = @studentid
       DELETE FROM #Temp WHERE PCode = @curStudentPref
   end

   FETCH NEXT FROM CUR_TEST INTO @studentid
END

CLOSE CUR_TEST
DEALLOCATE CUR_TEST

SELECT s_id INTO #Temp2
FROM Student WHERE Assigned_Project_code is null

DECLARE CUR_TEST CURSOR FAST_FORWARD FOR
SELECT s_id FROM #Temp2

OPEN CUR_TEST
FETCH NEXT FROM CUR_TEST INTO @studentid

DECLARE @NotAssigned varchar(50)
while @@FETCH_STATUS = 0
BEGIN
    SET @NotAssigned = (select top 1 Code FROM Bachelor_Project where NOT EXISTS(select * from Student WHERE Assigned_Project_code = Code))
    UPDATE Student
    SET  Assigned_Project_code = @NotAssigned WHERE s_id = @studentid
    FETCH NEXT FROM CUR_TEST INTO @studentid
END

UPDATE Thesis
SET Title = Name
FROM   Bachelor_Project bp INNER JOIN Student s ON bp.Code = s.Assigned_Project_code
WHERE  Thesis.sid = s.s_id

DROP TABLE #Temp
CLOSE CUR_TEST
DEALLOCATE CUR_TEST

GO



--8 c)
GO
CREATE PROC AssignTAs
@coordinator_id int, @TA_id int, @proj_code varchar(10)
AS
IF @coordinator_id IS NULL OR @TA_id IS NULL OR @proj_code IS NULL
PRINT 'Missing some data'
ELSE IF EXISTS (SELECT * FROM Coordinator WHERE @coordinator_id=Coordinator.coordinator_id)
UPDATE Academic SET Academic_code = @proj_code ,TA_id = @TA_id
GO



--8 d) 
GO
CREATE PROC ViewRecommendation
@lecture_id int
AS
IF(@lecture_id IS NULL)
    PRINT 'Lecturer id is null is ViewRecommendation'
ELSE IF(NOT EXISTS(SELECT * FROM Lecturer WHERE Lecturer_id = @lecture_id))
    PRINT 'Lecturer id is invalid'
ELSE
    SELECT *
    FROM LecturerRecommendEE
    WHERE LecturerRecommendEE.L_id= @lecture_id
GO



--8 e) GradeAcademicDefense / thesis DON'T HAVE THE ATTRIBUTE ACADEMIC CODE!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--REQUIRES INNER JOIN

GO
CREATE PROC AssignEE
@coordinator_id int, @EE_id int, @proj_code varchar(10)
AS
IF(@coordinator_id IS NULL OR @EE_id IS NULL OR @proj_code IS NULL)
    PRINT 'One of the inputs to the procedure AssignEE are null'
ELSE IF(NOT EXISTS(SELECT * FROM Users WHERE Role = 'coordinator' AND user_id = @coordinator_id))
    PRINT 'Invalid coordinator'
ELSE
    UPDATE Academic
    set EE_id =@EE_id
    where Academic_code= @proj_code AND EXISTS (SELECT * FROM LecturerRecommendEE WHERE @EE_id =EE_id AND PCode= @proj_code)
GO




--8 f)
GO
CREATE PROC ScheduleDefense
@sid int, @date datetime, @time time, @location varchar(5)
AS
IF @sid IS NULL OR @location IS NULL
    PRINT 'MISSING CRUCIAL DATA'
ELSE IF(NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
    PRINT 'Invalid student'
ELSE
    IF(NOT EXISTS(SELECT * FROM Defense WHERE sid = @sid AND Location = @location))
        INSERT INTO Defense (sid, Location, Time, Date) VALUES(@sid,@location,@time, @date)
    ELSE
        UPDATE Defense SET Date = @date, Time = @time WHERE sid = @sid AND Location = @location
GO



--9 a)
GO 
CREATE PROC EmployeeGradeThesis
@Employee_id int, @sid int, @thesis_title varchar(50), @Employee_grade Decimal(4,2)
AS
IF(@Employee_id IS NULL OR @sid IS NULL OR @thesis_title IS NULL OR @Employee_grade IS NULL)
    PRINT 'One of the parameters to the procedure EmployeeGradeThesis was not supplied'
ELSE IF(NOT EXISTS(SELECT * FROM Employee WHERE Staff_id = @Employee_id))
    PRINT 'Invalid Employee in procedure EmployeeGradeThesis'
ELSE IF(NOT EXISTS(SELECT * FROM Student WHERE s_id = @sid))
    PRINT 'Invalid Student in procedure EmployeeGradeThesis'
ELSE IF(NOT EXISTS(SELECT * FROM Thesis WHERE Title = @thesis_title))
    PRINT 'Invalid Student in procedure EmployeeGradeThesis'
ELSE
    BEGIN
        DECLARE @bachelorcode varchar(10)
        SET @bachelorcode = (SELECT Assigned_Project_code FROM Student WHERE s_id = @sid)
        IF(EXISTS(SELECT * FROM Industrial WHERE Industrial_code = @bachelorcode AND E_id = @Employee_id))
            BEGIN
                IF(EXISTS(SELECT * FROM GradeIndustrialThesis WHERE sid=@sid AND Title like @thesis_title))
                    UPDATE GradeIndustrialThesis SET Employee_grade= @Employee_grade, E_id = @Employee_id
                    WHERE sid=@sid AND Title like @thesis_title
                ELSE
                    INSERT INTO GradeIndustrialThesis (sid, Title, E_id, Employee_grade) VALUES (@sid, @thesis_title, @Employee_id, @Employee_grade)
            END
        ELSE
            PRINT 'This Employee is not assigned to this project. Thus, he cannot grade it.'
    END
GO


--9 b)
GO
CREATE PROC EmployeeGradedefense 
@Employee_id int, @sid int, @defense_location varchar(5), @Employee_grade Decimal(4,2)
AS
IF(@Employee_id IS NULL OR @sid IS NULL OR @defense_location IS NULL OR @Employee_grade IS NULL)
    PRINT('Invalid input to the method EmployeeGradedefense')
ELSE
    BEGIN
        IF (NOT EXISTS(SELECT * FROM Employee  e WHERE e.Staff_id = @Employee_id))
            PRINT 'Invalid Employee'
        ELSE IF (NOT EXISTS(SELECT * FROM Student s WHERE s.s_id = @sid))
            PRINT 'Invalid Student'
        ElSE IF (NOT EXISTS(SELECT * FROM Defense WHERE Location = @defense_location AND sid = @sid))
            PRINT 'Invalid Defense'
        ELSE
            IF(EXISTS(SELECT * FROM GradeIndustrialDefense WHERE sid = @sid AND Location = @defense_location))
                UPDATE GradeIndustrialDefense SET E_id = @Employee_id, Employee_grade = @Employee_grade -- if an external examiner already started grading the defense
            ELSE
                INSERT INTO GradeIndustrialDefense(E_id,sid,Location, Employee_grade) VALUES (@Employee_id,@sid,@defense_location,@Employee_grade)
   END
GO



--9 c)
GO
CREATE PROC EmployeeCreatePR
@Employee_id int, @sid int, @date datetime, @content varchar(1000)
AS
IF(@Employee_id IS NULL OR @sid IS NULL OR @date IS NULL OR @content IS NULL)
    PRINT 'One of the inputs to the procedure EmployeeCreatePR is NULL'
ELSE IF EXISTS( SELECT * FROM Industrial I INNER JOIN Student S ON S.Assigned_Project_code =I.Industrial_code INNER JOIN 
Employee E ON E.Staff_id = I.E_id WHERE I.E_id = @Employee_id)
    INSERT INTO ProgressReport(sid,Date,Content) VALUES (@sid,@date,@content)
ELSE
    PRINT 'STUDENT IS NOT INDUSTRIAL OR EMPLOYEE IS NOT ASSIGNED TO THIS PROJECT'
GO