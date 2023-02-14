USE [Football]
GO
/****** Object:  Trigger [dbo].[tr_Player_Add]    Script Date: 14.02.2023 17:10:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[tr_Player_Add]
ON [dbo].[Player]
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