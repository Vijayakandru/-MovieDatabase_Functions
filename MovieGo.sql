CREATE TABLE Users([UserId] VARCHAR(50) PRIMARY KEY,[UserName] VARCHAR(50) NOT NULL,[Password] VARCHAR(50) NOT NULL,[Age] INT NOT NULL,[Gender] CHAR(1) CONSTRAINT gen_chk CHECK(Gender IN('M','F')),[EmailId] VARCHAR(50) UNIQUE,[PhoneNumber] NUMERIC(10) NOT NULL);

SELECT *FROM Users

INSERT INTO Users(UserId,UserName,[Password],Age,Gender,EmailId,PhoneNumber)VALUES('mary_potter','Mary Potter','Mary@123',25,'F','mary_p@gmail.com',9786543211),('jack_sparrow','Jack Sparrow','Spar!78jack',28,'M','jack_spa@yahoo.com',7865432102);


CREATE TABLE TheatreDetails([TheatreId] INT PRIMARY KEY IDENTITY(1,1),[TheatreName] VARCHAR(50) NOT NULL,[Location] VARCHAR(50) NOT NULL);

INSERT INTO TheatreDetails([TheatreName],[Location])VALUES('PVR','Pune'),('Inox','Delhi')

select *FROM TheatreDetails

CREATE TABLE ShowDetails([ShowId] INT PRIMARY KEY IDENTITY(1001,1),[TheatreId] INT CONSTRAINT tid_fk REFERENCES TheatreDetails(TheatreId),[ShowDate] DATE NOT NULL,[ShowTime] TIME NOT NULL,[MovieName] VARCHAR(20) NOT NULL,[TicketCost] DECIMAL(6,2) NOT NULL,[TicketAvailable] INT NOT NULL)

INSERT INTO ShowDetails(TheatreId,ShowDate,ShowTime,MovieName,TicketCost,TicketAvailable)values(2,'28-MAY-2018','14:30','Avengers',250.00,100),(2,'30-MAY-2018','17:30','Hit Man',200.00,150)

select *FROM ShowDetails

SELECT CONCAT('B',1001)



CREATE TABLE BookingDetails([ID] INT IDENTITY(1001,1),[BookingId] AS('B'+RIGHT(CAST(ID AS VARCHAR(5)),5)) PERSISTED,CONSTRAINT pk_bi PRIMARY KEY(BookingId ASC),[UserId] VARCHAR(50) CONSTRAINT uid_fk REFERENCES Users(UserId),[ShowId] INT CONSTRAINT sid_fk REFERENCES ShowDetails(ShowId),[NoOfTickets] INT NOT NULL,[TotalAmt] DECIMAL(6,2) NOT NULL)

--DROP TABLE BookingDetails

INSERT INTO BookingDetails(UserId,ShowId,NoOfTickets,TotalAmt)VALUES('jack_sparrow',1001,2,500.00),('mary_potter',1002,5,1000.00)

select *FROM BookingDetails


