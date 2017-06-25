/* How to insert into many to many table*/
 
 CREATE TABLE Students
 (
	Id int primary key identity,
	StudentName nvarchar(50)
)
GO

CREATE TABLE Courses
(
	Id int primary key identity,
	CourseName nvarchar(50)
)
GO

CREATE TABLE StudentCourses
(
	StudentID int not null foreign key references Students(Id),
	CourseId int not null foreign key references Courses(Id)
)
GO


CREATE PROCEDURE spInsertIntoStudentCourses
@StudentName nvarchar(50),
@CourseName nvarchar(50)
as
BEGIN
DECLARE @StudentId int
DECLARE @CourseId int

--Check to see if student is already in table
SELECT @StudentId = Id FROM Students where StudentName = @StudentName

if(@StudentId is null)
Begin
	INSERT INTO Students values(@StudentName)
	SELECT @StudentId = SCOPE_IDENTITY()
End

SELECT @CourseId = Id FROM Courses where CourseName = @CourseName

if(@CourseId is null)
Begin
	INSERT INTO Courses values(@CourseName)
	SELECT @CourseId = SCOPE_IDENTITY()
END

INSERT INTO StudentCourses values (@StudentId, @CourseId)
End

SELECT * FROM Students
SELECT * FROM Courses
SELECT * FROM StudentCourses

--Prevent Duplicates in StudentCourses
ALTER TABLE StudentCourses
ADD Constraint PK_StudentCourses
--Pk = Primary Key
Primary Key Clustered (StudentId, CourseId)


EXECUTE spInsertIntoStudentCourses 'Tom', 'C#'