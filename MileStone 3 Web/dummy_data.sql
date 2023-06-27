
use University_Bachelor;
--CREATING DUMMY DATA FOR TESRING PURPOSES
USE University_Bachelor;

DECLARE @out1 int
DECLARE @out2 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drCAROLINE', @email='caroline.sabty@giu-uni.de', @phone_number='13579', @user_id = @out1 output, @password = @out2 output

DECLARE @out3 int 
DECLARE @out4 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drNADA', @email='nada.hamed@giu-uni.de', @phone_number='13579', @user_id = @out3 output, @password = @out4 output

DECLARE @out5 int
DECLARE @out6 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drALIA', @email='alia.elbolock@giu-uni.de', @phone_number='13579', @user_id = @out5 output, @password = @out6 output

DECLARE @out7 int
DECLARE @out8 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drMustfa', @email='mustafa.elagmy@giu-uni.de', @phone_number='13579', @user_id = @out7 output, @password = @out8 output
---creating deans!!!!
--cs dean
DECLARE @out11 int
DECLARE @out12 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drKLAUS', @email='klaus.baer.abdennahder@giu-uni.de', @phone_number='13579', @user_id = @out11 output, @password = @out12 output
--engineering dean
DECLARE @out13 int
DECLARE @out14 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drASGAR', @email='ansger.meroth@giu-uni.de', @phone_number='13579', @user_id = @out13 output, @password = @out14 output
--design dean
DECLARE @out15 int
DECLARE @out16 varchar(10)
EXEC UserRegister @usertype='lecturer', @userName='drKatrin', @email='katrin.hinz@giu-uni.de', @phone_number='13579', @user_id = @out15 output, @password = @out16 output


INSERT INTO Faculty  VALUES ('Informatics&ComputerScience',5);
INSERT INTO Faculty  VALUES ('Engineering',6);
INSERT INTO Faculty  VALUES ('Design',7);


INSERT INTO Major VALUES(1,'Data science');
INSERT INTO Major VALUES(1,'Software Engineering');
INSERT INTO Major VALUES(1,'IT Security')
INSERT INTO Major VALUES(1,'Media Informatics')
INSERT INTO Major VALUES(2,'Automotive Mechatronics');
INSERT INTO Major VALUES(2,'Manufacturing Engineering');
INSERT INTO Major VALUES(2,'Robotics and Automation');
INSERT INTO Major VALUES(2,'Automation and Control Engineering');
INSERT INTO Major VALUES(2,'Electrical Power Systems Engineering');
INSERT INTO Major VALUES(3,'Industrial design');
INSERT INTO Major VALUES(3,'Fashion design');



--insertining students

DECLARE @id1 int
DECLARE @pass1 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Mariam',@birth_date = '11/10/2002' ,@email='mariamm@student.giu-uni.de', @phone_number='123',@first_name = 'Mariam', @last_name = 'RIZKALLAH', 
@major_code = 1, @address = 'TAHRIR SQ, KARSR EL EINY', @semester = 3, @gpa = 1.78, @user_id = @id1 output,@password= @pass1  output
--
DECLARE @id2 int
DECLARE @pass2 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Zeyad',@birth_date = '1/1/2002', @email='zeyadd@student.giu-uni.de', @phone_number='456',@first_name = 'Zeyad', @last_name = 'SHAFIK', 
@major_code = 1, @address = 'MANSOURA, a street in mansoura', @semester = 3, @gpa = 1.0, @user_id = @id2 output, @password = @pass2 output
--
DECLARE @id3 int
DECLARE @pass3 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Mina',@birth_date = '3/1/2002', @email='minaa@student.giu-uni.de', @phone_number='678',@first_name = 'Mina', @last_name = 'ATEF', 
@major_code = 1, @address = 'SHERATON, a street in sheraton', @semester = 3, @gpa = 0.7, @user_id = @id3 output, @password = @pass3 output
--
DECLARE @id4 int
DECLARE @pass4 varchar(10)
EXEC UserRegister @usertype='Student', @userName='Ali',@birth_date = '2/1/2002', @email='Alii@student.giu-uni.de', @phone_number='999', @first_name = 'Ali', @last_name = 'ZEIN', 
@major_code = 1, @address = 'TAGMOE, a street in tagmoe', @semester = 3, @gpa = 0.72, @user_id = @id4 output, @password = @pass4 output
---------------

DECLARE @id5 int
DECLARE @pass5 varchar(10)
EXEC UserRegister @usertype='Student', @userName='joy',@birth_date = '1/1/2002', @email='joyyyy@student.giu-uni.de', @phone_number='999', @first_name = 'joy', @last_name = 'smith', 
@major_code = 7, @address = 'REHAB, a street in rehab', @semester = 5, @gpa = 1.45, @user_id = @id5 output, @password = @pass5 output



DECLARE @id6 int
DECLARE @pass6 varchar(10)
EXEC UserRegister @usertype='Student', @userName='josh',@birth_date = '1/10/2001', @email='josh@student.giu-uni.de', @phone_number='999', @first_name = 'JOSH', @last_name = 'sam', 
@major_code = 9, @address = 'MASR EL GEIDA, a street in masr el gedida', @semester = 7, @gpa = 2.0, @user_id = @id6 output, @password = @pass6 output

DECLARE @id7 int
DECLARE @pass7 varchar(10)
EXEC UserRegister @usertype='Student', @userName='MONA',@birth_date = '1/10/2001', @email='monaliza@student.giu-uni.de', @phone_number='999', @first_name = 'mona', @last_name = 'liza', 
@major_code = 10, @address = 'Zamalek, a street in zamalek', @semester = 7, @gpa = 3.9, @user_id = @id7 output, @password = @pass7 output
---
--adding TAS
DECLARE @t1 int
DECLARE @t2 varchar(10)
EXEC UserRegister @usertype='TA', @userName='Leqaaa', @email='leqaa@giu-uni.de', @phone_number='13579', @user_id = @t1 output, @password = @t2 output

DECLARE @t3 int
DECLARE @t4 varchar(10)
EXEC UserRegister @usertype='ta', @userName='amal', @email='amal@giu-uni.de', @phone_number='13579', @user_id = @t3 output, @password = @t4 output

DECLARE @t5 int
DECLARE @t6 varchar(10)
EXEC UserRegister @usertype='ta', @userName='radwa', @email='radwa@giu-uni.de', @phone_number='13579', @user_id = @t5 output, @password = @t6 output
------
--adding companies
DECLARE @c1 int
DECLARE @c2 varchar(10)
EXEC UserRegister @usertype='company', @userName='dell', @email='dell@company.com',@address = 'DELL-COMPANIES DISTRICT', @company_name='DELL FOR TECHNOLLOGY', @representative_name='dell',@representative_email='dell',@phone_number='13579', @user_id = @c1 output, @password = @c2 output


DECLARE @c3 int
DECLARE @c4 varchar(10)
EXEC UserRegister @usertype='company', @userName='siemens', @email='siemens@company.com',@address = 'SIEMENS-COMPANIES DISTRICT', @company_name='SIEMENS FOR ELECTRONICS', @representative_name='SIEMENS',@representative_email='SIEMENSREPRWSENTINTVE@COMPANY.COM',@phone_number='13579', @user_id = @c3 output, @password = @c4 output

DECLARE @c5 int
DECLARE @c6 varchar(10)
EXEC UserRegister @usertype='company', @userName='H&M', @email='h&m@company.com',@address = 'H&M-COMPANIES DISTRICT', @company_name='H&M FASHION INDUSTRY', @representative_name='H&M',@representative_email='H&M',@phone_number='13579', @user_id = @c5 output, @password = @c6 output
----
--adding employees

INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (18,'emp1','EMP1@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (18,'emp2','EMP2@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (18,'emp3','EMP3@DELL.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (19,'emp4','EMP4@SIEMENS.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (19,'emp5','EMP6@SIEMENS.COM','TECH',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (19,'emp6','EMP8@SIEMENS.COM','ELECTRIC',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (19,'emp7','EMP9@SIEMSNS.COM','ELECTRIC',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (20,'emp8','EMP10@H&M.COM','FASHION',123); 
INSERT INTO Employee (Company_id,Username,Email,Field,Phone)VALUES (20,'emp9','EMP11@H&M.COM','FASHION',123); 

----


----
--adding external examiner
DECLARE @ee1 int
DECLARE @ee2 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 1', @email='ee1@giu-uni.de',@phone_number =11200367, @user_id = @ee1 output, @password = @ee2 output

DECLARE @ee3 int
DECLARE @ee4 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 2', @email='ee2@giu-uni.de',@phone_number =1123567, @user_id = @ee3 output, @password = @ee4 output

DECLARE @ee5 int
DECLARE @ee6 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 3', @email='ee3@giu-uni.de',@phone_number =1122367, @user_id = @ee5 output, @password = @ee6 output

DECLARE @ee7 int
DECLARE @ee8 varchar(10)
EXEC UserRegister @usertype='ee', @userName='External 4', @email='ee4@giu-uni.de',@phone_number =1192367, @user_id = @ee7 output, @password = @ee8 output

-- adding coodinator

DECLARE @co1 int
DECLARE @co2 varchar(10)
EXEC UserRegister @usertype='coordinator', @userName='co1', @email='co1@giu-uni.de',@phone_number =1192367, @user_id = @co2 output, @password = @co2 output
DECLARE @co3 int
DECLARE @co4 varchar(10)
EXEC UserRegister @usertype='coordinator', @userName='co2', @email='co2@giu-uni.de',@phone_number =1192367, @user_id = @co3 output, @password = @co4 output

-----------------------------
