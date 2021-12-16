CREATE PROCEDURE usp_BookTheTicket(@UserId varchar(50),@ShowId int,@NoOfTickets int) AS
BEGIN
	DECLARE @TotalAmt DECIMAL(6,2),@TicketCost DECIMAL(6,2)
BEGIN TRY
	IF NOT EXISTS(SELECT UserId From Users WHERE @UserId=UserId)
	BEGIN
		RETURN -1
	END
	IF NOT EXISTS(SELECT ShowId FROM ShowDetails WHERE @ShowId=ShowId)
	BEGIN
		RETURN -2
	END
	IF NOT EXISTS(SELECT NoOfTickets FROM BookingDetails WHERE @NoOfTickets<=NoOfTickets AND @ShowId=ShowId)
	BEGIN
		RETURN -4
	END
	IF @NoOfTickets>0
	BEGIN
		SELECT @TicketCost=TicketCost FROM ShowDetails WHERE @ShowId=ShowId
		SET @TicketCost=@NoOfTickets*@TicketCost
		INSERT INTO BookingDetails(UserId,ShowId,NoOfTickets,TotalAmt)VALUES(@UserId,@ShowId,@NoOfTickets,@TicketCost)
		return 1
	END
	ELSE
	BEGIN
		RETURN -3
	END
END TRY
BEGIN CATCH
	RETURN -99
END CATCH
END

EXEC usp_BookTheTicket 'jack_sparrow',1002,3

select *FROM BookingDetails
select *FROM ShowDetails
select *FROM TheatreDetails

ALTER FUNCTION ufn_GetMovieShowtimes(@MovieName varchar(20),@Location varchar(50))
RETURNS @MovieShowTimes TABLE(MovieName varchar(20),ShowDate date,ShowTime time(7),TicketCost decimal(6,2),TheatreName varchar(50))
AS
BEGIN
	INSERT @MovieShowTimes
	SELECT sd.MovieName,sd.ShowDate,sd.ShowTime,sd.TicketCost,td.TheatreName FROM TheatreDetails td JOIN ShowDetails sd ON td.TheatreId=sd.TheatreId AND @MovieName=MovieName
	RETURN
END

SELECT *FROM ufn_GetMovieShowtimes('Avengers','Pune')


CREATE FUNCTION ufn_BookedDetails(@BookingId varchar(5))
RETURNS @Details TABLE(BookingId varchar(5),UserName varchar(50),MovieName varchar(20),TheatreName varchar(50),ShowDate date,ShowTime time(7),NoOfTickets int,TotalAmt decimal(6,2))
AS
BEGIN
	INSERT INTO @Details
	SELECT bk.BookingId,u.UserName,sd.MovieName,td.TheatreName,sd.ShowDate,sd.ShowTime,bk.NoOfTickets,bk.TotalAmt FROM Users u 
	JOIN BookingDetails bk ON u.UserId=bk.UserId LEFT OUTER JOIN ShowDetails sd ON bk.ShowId=sd.ShowId JOIN 
	TheatreDetails td ON sd.TheatreId=td.TheatreId AND @BookingId=BookingId
	RETURN
END

SELECT *FROM BookingDetails
SELECT *FROM TheatreDetails
SELECT *FROM ufn_BookedDetails('B1003')



