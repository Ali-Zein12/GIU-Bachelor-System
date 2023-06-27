--drop database University_Bachelor;
--create database University_Bachelor;
--use University_Bachelor;


--User (user_id, Username, Password, Email, Role,phone_number)

CREATE TABLE Users(
user_id int PRIMARY KEY IDENTITY,--FROM USER STORIES 1A
Username varchar(20) UNIQUE,-------FROM USER STORIES 1A
Password varchar(10),--------------FROM USER STORIES 1A
Email  varchar(50) UNIQUE,---------FROM USER STORIES 1A
Role varchar(20),------------------FROM USER STORIES 1A
phone_number varchar(20)-----------FROM USER STORIES 1A
);

--Lecturer (Lecturer_id, Schedule) 
--Lecturer.Lecturer_id references User.user_id

CREATE TABLE Lecturer(
Lecturer_id int PRIMARY KEY FOREIGN KEY REFERENCES Users,
Schedule varchar(1000)---DECIDED THAT IT WILL BE SAME LENGTH AS CONTENT OF PR
);

--LecturerFields(Lecturer_id, field) 
--LecturerFields.Lecturer_id references Lecturer.user_id

CREATE TABLE LecturerFields(
Lecturer_id int REFERENCES Users,
field varchar(25),---DECIDED THAT IT WILL BE THE SAME LENGTH OF THE EMPLOYEE FIELD
PRIMARY KEY(Lecturer_id,field)
);

--Company(Company_id, Name, Representative_name, Representative_Email, Location) 
--Company.Company_id references User.user_id

CREATE TABLE Company(
Company_id int PRIMARY KEY FOREIGN KEY REFERENCES Users, 
CompanyName varchar(20),-----------FROM USER STORIES 1A
Representative_name varchar(20),---FROM USER STORIES 1A
Representative_Email varchar(50),--FROM USER STORIES 1A
CompanyLocation varchar(100),------FROM USER STORIES 1A//COMPANY LOCATION SAME AS ADDRESS
);

--Employee (Staff_id, Company_id, Username, Password, Email, Field, Phone)
--Employee.Company_id references Company.Company_id

CREATE TABLE Employee (
Staff_id int IDENTITY,
Company_id int REFERENCES Company,
PRIMARY KEY(Staff_id,Company_id),
Username varchar(20) UNIQUE,----FROM USER STORIES 4A
EmployeePassword varchar(10),---FROM USER STORIES 4A
Email varchar(50) UNIQUE,-------FROM USER STORIES 4A
Field varchar(25),--------------FROM USER STORIES 4A
Phone varchar(20)---------------FROM USER STORIES 4A
);

--External_Examiner(EE_id, Schedule)
--External_Examiner. EE_id references User. user_id

CREATE TABLE External_Examiner(
EE_id int PRIMARY KEY FOREIGN KEY REFERENCES Users,
Schedule varchar(1000)---DECIDED THAT IT WILL BE SAME LENGTH AS CONTENT OF PR
);

--Teaching_Assistant(TA_id, Schedule)
--Teaching_Assistant.TA_id references User.user_id

CREATE TABLE Teaching_Assistant(
TA_id int PRIMARY KEY FOREIGN KEY REFERENCES Users,
Schedule varchar(1000)---DECIDED THAT IT WILL BE SAME LENGTH AS CONTENT OF PR
);

--Coordinator(coordinator_id)
--Coordinator.coordinator_id references User. user_id
--7A2AK 3ALAYA

CREATE TABLE Coordinator(
coordinator_id int PRIMARY KEY FOREIGN KEY REFERENCES Users
);


--------->HAD TO DELAY STUDENT!!!!!
--------->HAD TO DELAY STUDENT!!!!!
--------->HAD TO DELAY STUDENT!!!!!


--Bachelor_Project(Code, Name, Submitted_Materials, Description)

CREATE TABLE Bachelor_Project(
Code varchar(10) PRIMARY KEY,-----FROM 4B 
Name varchar(50),------------------FROM 4B
Submitted_Materials varchar(1000),--SAME AS PDF IN 3C
Description varchar(200)------------FROM 4B
);

--BachelorSubmittedMaterials(Code, Material)

CREATE TABLE BachelorSubmittedMaterials(
Code varchar(10) PRIMARY KEY REFERENCES Bachelor_Project,
Material varchar(1000) --SAME AS PDF IN 3C
);

--Academic(Academic_code, L_id , TA_id, EE_id)


CREATE TABLE Academic(
Academic_code varchar(10) PRIMARY KEY REFERENCES Bachelor_Project,
L_id int REFERENCES Lecturer,
TA_id int REFERENCES Teaching_Assistant,
EE_id int REFERENCES External_Examiner
);

--Industrial(Industrial_code, C_id, L_id, E_id)

CREATE TABLE Industrial(
Industrial_code varchar(10) PRIMARY KEY REFERENCES Bachelor_Project,
C_id int REFERENCES Company,
L_id int REFERENCES Lecturer,
E_id int,
FOREIGN KEY(E_id,C_id) REFERENCES Employee
);

--Faculty(Faculty_Code, Name, Dean) 
--Faculty.Dean references Lecturer.Lecturer_id

CREATE TABLE Faculty(
Faculty_Code varchar(10) PRIMARY KEY,---FROM USER STORIES 1A
FacultyName varchar(50),------------------------DECIDED TAHT IT WILL BE THE SAME AS THESIS TITLE
Dean int FOREIGN KEY REFERENCES Lecturer
);

--Major (Major_Code, Faculty_code , Major_Name) 
--Major.Faculty_code references Faculty.Faculty_Code

CREATE TABLE Major(
Major_Code varchar(10) PRIMARY KEY,-----------------------FROM USER STORIES 1A
Faculty_code varchar(10) FOREIGN KEY REFERENCES Faculty,--FROM USER STORIES 1A
Major_Name varchar(50)------------------------------------DECIDED TAHT IT WILL BE THE SAME AS THESIS TITLE
);



/*Student(sid ,first_name, last_name, Major_code, Date_Of_Birth, Adress, Age, Semester, 
GPA, TotalBachelorGrade, ComulativeProgressReportGrade)
Student.sid references User.user_id
Student.Major_code references Major.Major_Code
Where : Student.Age = current date – Student.Date_Of_Birth, 
CPG = calculated(Average ProgressReprt.grade),
TotalBachelorGrade = calculated(0.3*Thesis.Total_grade+0.3*Defense.Total_grade+
0.4*ComulativeProgressReportGrade)*/

/*Student(sid ,first_name, last_name, Major_code, Date_Of_Birth, Adress, Age, Semester, 
GPA, TotalBachelorGrade, Assigned_Project_code)
*/

CREATE TABLE Student(
s_id int PRIMARY KEY FOREIGN KEY REFERENCES Users,--------FROM USER STORIES 1A
first_name varchar(20),--FROM USER STORIES 1A
last_name varchar(20),------------------------------------FROM USER STORIES 1A
Major_code varchar(10) FOREIGN KEY REFERENCES Major,------FROM USER STORIES 1A
Date_Of_Birth date,
Address varchar(100),-----------------------------FROM USER STORIES 1A
Age AS (YEAR(CURRENT_TIMESTAMP)) - YEAR(Date_Of_Birth),---FROM USER STORIES 1A
Semester int,
GPA decimal(3,2) CHECK (GPA between 0 AND 5),-------------FROM USER STORIES 1A
TotalBachelorGrade decimal(4,2) default 0,----------------FROM USER STORIES 3G
Assigned_Project_code varchar(10) REFERENCES Bachelor_Project
);



--Meeting (Meeting_ID, L_id, STime, ETime, Duration, Date, Meeting_Point)

CREATE TABLE Meeting (
Meeting_ID int IDENTITY PRIMARY KEY,--------------FROM USER STORIES 3I
L_id int REFERENCES Lecturer,
STime time,
ETime time,
Duration AS DATEDIFF(minute,STime,(ETime)),
Date date,
Meeting_Point varchar(5)-----------------FROM USER STORIES 5C
);

--MeetingToDoList(Meeting_ID, ToDoList)

CREATE TABLE MeetingToDoList(
Meeting_ID int REFERENCES Meeting ON DELETE CASCADE ON UPDATE CASCADE,
ToDoList varchar(200)
PRIMARY KEY(Meeting_ID,ToDoList)--SENT ON WHATSAPP GROUP 
);

--MeetingAttendents(Meeting_ID, Attendant_id)

CREATE TABLE MeetingAttendents(
Meeting_ID int REFERENCES Meeting ON DELETE CASCADE ON UPDATE CASCADE,
Attendant_id int REFERENCES Users
PRIMARY KEY(Meeting_ID,Attendant_id)
);

--Thesis(sid, Title, Deadline, PDF_doc, Total_grade)

CREATE TABLE Thesis(
sid int REFERENCES Student,
Title varchar(50) default 'NA',------FROM USER STORIES 3C
PRIMARY KEY(sid,Title),
Deadline datetime,------FROM USER STORIES 5B
PDF_doc varchar(1000),--FROM USER STORIES 3C
Total_grade decimal(4,2) default 0--SAME AS TOTAL BACHELOR GRADE IN 3G
);


--Defense(sid, Location, Content, Time, Date, Total_Grade)

CREATE TABLE Defense(
sid int REFERENCES Student,
Location varchar(5)-------FROM USER STOIES 9B
PRIMARY KEY(sid,Location),
Content varchar(1000),-------FROM USER STORIES 3F
Time time,
Date date,
Total_Grade decimal(4,2) default 0--SAME AS TOTAL BACHELOR GRADE IN 3G
);

----------------------------------------------------------------------

/*ProgressReport(sid, Date, Content, Grade, UpdatingUser_id, ComulativeProgressReportGrade) 
ProgressReport.sid references Student.sid
ProgressReport.UpdatingUser_id references User.user_id
Where : ProgressReport.Grade = Calculated(GradeAcademicPR.Lecturer_grade or 
GradeIndustrialPR.Company_grade),
ProgressReport.ComulativeProgressReportGrade = calculated(Average  ProgressReprt.grade)*/
Create table ProgressReport (
    sid int References Student,
    Date  datetime, --FROM USER STORIES 5 I
    Content varchar(1000),-------FROM USER STORIES 3F   
    UpdatingUser_id int references Users,
    PRIMARY KEY (sid,Date),
    Grade decimal(4,2) default 0,----FROM USER STORIES 5 I
    ComulativeProgressReportGrade decimal(4,2) default 0--//NOT MENTIONED ANYWHERE HOWEVER DECICDED TO BE THE SAME AS TH PR GRADE
);

--GradeIndustrialPR(C_id, sid, Date, Company_grade, Lecturer_grade)

Create table GradeIndustrialPR(
   C_id int references Company,
   sid int,
   Date datetime, --FROM USER STORIES 5 I
   Company_grade decimal(4,2), --FROM USER STORIES 4f
   Lecturer_grade decimal(4,2), --FROM USER STORIES 5I
   foreign key(sid,Date) references ProgressReport,
   Primary key(sid,Date)
);

--GradeAcademicPR(L_id, sid, Date, Lecturer_grade)
/*GradeAcademicPR.L_id references Lecturer.Lecturer_id
GradeAcademicPR.sid references ProgressReport.sid
GradeAcademicPR.Date references ProgressReport.Date*/

create table GradeAcademicPR(
L_id int references Lecturer, 
sid int,
Date datetime,--FROM USER STORIES 5 I
foreign key(sid,Date) references ProgressReport, 
Lecturer_grade decimal(4,2),--FROM USER STORIES 5I
Primary key(sid,Date)
);

/*GradeAcademicThesis(L_id, EE_id, sid, Title, EE_grade, Lecturer_grade)
GradeAcademicThesis.L_id references Lecturer.Lecturer_id
GradeAcademicThesis.EE_id references External_Examiner.EE_id
GradeAcademicThesis.sid references Thesis.sid
GradeAcademicThesis.Title references Thesis.Date*/

create table GradeAcademicThesis(
L_id int references Lecturer,
EE_id int references External_Examiner,
sid int,
Title varchar(50),--FROM USER STORIES 4D
EE_grade decimal(4,2),--FROM USER STORIES 7A
Lecturer_grade decimal(4,2),--FROM USER STORIES 5J
foreign key(sid,Title) references Thesis,
primary key(sid,Title)
);

/*GradeIndustrialThesis(C_id, E_id, sid, Title, Company_grade, Employee_grade) 
GradeIndustrialThesis.C_id references Company.Company_id 
GradeIndustrialThesis.E_id references Employee.Staff_id
GradeIndustrialThesis.sid references Thesis.sid */

Create Table GradeIndustrialThesis(
C_id int references Company,
E_id int,
FOREIGN KEY(E_id,C_id) REFERENCES Employee,
sid int,
Title varchar(50),--FROM USER STORIES 4D
Company_grade decimal(4,2),--FROM USER STORIES 4 D
Employee_grade decimal(4,2),--FROM USER STORIES 9 A
foreign key(sid,Title) references Thesis,
primary key(sid,Title)
);

-----------------------------------------------------------------------------

--GradeAcademicDefense(L_id, EE_id, sid, Location, EE_grade, Lecturer_grade)

CREATE TABLE GradeAcademicDefense(
L_id int REFERENCES Lecturer,
EE_id int REFERENCES External_Examiner,
sid int,
Location varchar(5),--FROM USER STORIES 5J
PRIMARY KEY(sid,Location),
FOREIGN KEY(sid,Location) REFERENCES Defense,
EE_grade decimal(4,2),--FROM USER STORIES 7B
Lecturer_grade decimal(4,2)--FROM USER STORIES 5I
);

--GradeIndustrialDefense(C_id, E_id, sid, Location, Company_grade, Employee_grade)

CREATE TABLE GradeIndustrialDefense(
C_id int REFERENCES Company,
E_id int,
FOREIGN KEY(E_id,C_id) REFERENCES Employee,
sid int,
Location varchar(5),--FROM USER STORIES 5J
PRIMARY KEY(sid,Location),
FOREIGN KEY(sid,Location) REFERENCES Defense,
Company_grade decimal(4,2),--FROM USER STORIES 4D
Employee_grade decimal(4,2)--FROM USER STORIES 9B
);

--LecturerRecommendEE(L_id, EE_id, PCode)

CREATE TABLE LecturerRecommendEE(
L_id int REFERENCES Lecturer,
EE_id int REFERENCES External_Examiner,
PCode varchar(10)REFERENCES Academic,--FROM USER STORIES 3 A
PRIMARY KEY(EE_id,PCode)
);

--StudentPreferences(sid, PCode, PreferenceNumber)

CREATE TABLE StudentPreferences(
sid int REFERENCES Student,
PCode varchar(10) REFERENCES Bachelor_Project,--FROM USER STORIES 3 A
PRIMARY KEY(sid,PCode),
PreferenceNumber int
);

--MajorHasBachelorProject(Major_code, Project_code)

CREATE TABLE MajorHasBachelorProject(
Major_code varchar(10) REFERENCES Major,--FROM USER STORIES 1 A
Project_code varchar(10) REFERENCES Bachelor_Project,--FROM USER STORIES 3 A
PRIMARY KEY(Major_code,Project_code)
);