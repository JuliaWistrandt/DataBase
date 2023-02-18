CREATE DATABASE Football;

USE Football;

CREATE TABLE Team (
teamID INT PRIMARY KEY IDENTITY(1,1),
name NVARCHAR(50) NOT NULL,
rate INT NOT NULL
);

CREATE TABLE Player (
playerID INT PRIMARY KEY IDENTITY(1,1),
--//creating lastname and name-length controll 
firstName NVARCHAR(20) NOT NULL CHECK(LEN(firstName) >= 2 AND LEN(firstName)<=10), 
lastName NVARCHAR(20) NOT NULL CHECK (LEN(lastName) >= 2 AND LEN(lastName) <= 15), 
Age INT NOT NULL,
Ace INT NOT NULL,
Salary INT NOT NULL,
TeamID INT,
--// avoiding doubles in combination of name+lastname 
CONSTRAINT UQ_FirstName_LastName UNIQUE (firstName,lastName),
FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);


CREATE TABLE Coach(
coachID INT PRIMARY KEY IDENTITY(1,1),
firstName NVARCHAR(20) NOT NULL CHECK (LEN(firstName) >= 2 AND LEN(firstName)<=10),
lastName NVARCHAR(20) NOT NULL CHECK (LEN(lastName) >= 2 AND LEN(lastName) <= 15),
CONSTRAINT UQ_Coach_FirstName_LastName UNIQUE (firstName,lastName)
);


CREATE TRIGGER tr_Player_Add
ON Player
AFTER INSERT
AS
	BEGIN
		SET NOCOUNT ON;

		UPDATE p
		SET p.Salary = t.Rate * (p.Age / 10)
		FROM inserted i
		JOIN PLAYER p ON i.playerID = p.playerID
		JOIN Team t ON i.TeamID = t.teamID;
	END;

	SELECT * FROM Player

	--// checking trigger - salary should be 1000 * (20/10) = 2.
	INSERT INTO Player(	
	firstName,
	lastName,
	Age,
	Salary,
	TeamID
	)
	VALUES (
    'Gilbert',
    'Johsson',
    40,
	5000,
    1 
	);

	DELETE FROM Player WHERE playerID = 17;
	DELETE FROM Player WHERE playerID = 16;
	DELETE FROM Player WHERE playerID = 14;
	
	SELECT * FROM Player

	CREATE PROCEDURE sp_CountmPlayerLaborCost(@teamID INT)
	AS
	BEGIN
		SET NOCOUNT ON;

		SELECT SUM(p.Salary) AS TotalPlayerLaborCost
		FROM Player p
		JOIN Team t ON p.TeamID = t.teamID
		WHERE t.teamID = @teamID;
	END;