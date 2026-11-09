/* =========================================================
   DBI202 - EV Charging Station Answer SQL
========================================================= */
--drop database EVChargingDB
Create database EVChargingDB
use EVChargingDB
 CREATE TABLE Users(
     UserID INT IDENTITY(1,1) PRIMARY KEY,
     FullName NVARCHAR(100) NOT NULL,
     PhoneNumber VARCHAR(20) NOT NULL
 );
 INSERT INTO [Users](FullName, PhoneNumber) VALUES
 (N'Nguyen Van A', '0901111111'),
 (N'Tran Thi B', '0902222222'),
 (N'Le Van C', '0903333333');
 
CREATE TABLE Connector (
    ConnectorID INT IDENTITY(1,1) PRIMARY KEY,
	Description varchar(500),
    ConnectorName VARCHAR(30) NOT NULL UNIQUE,
    CONSTRAINT CK_Connector_Name
        CHECK (ConnectorName IN ('Type2', 'CCS2', 'CHAdeMO'))
);
CREATE TABLE Station (
    StationID INT IDENTITY(1,1) PRIMARY KEY,
    StationCode VARCHAR(50) NOT NULL UNIQUE,
	ConnectorID int not null,
    Type VARCHAR(20) NOT NULL DEFAULT 'NormalCharge',
    Status VARCHAR(20) NOT NULL DEFAULT 'Available',
    PricePerKwh DECIMAL(12,2) NOT NULL,
	CONSTRAINT CK_Station_Type
        CHECK (Type IN ('FastCharge', 'NormalCharge')),
    CONSTRAINT CK_Station_Status
        CHECK (Status IN ('Not Available', 'Available', 'Maintenance')),
    CONSTRAINT CK_Station_Price
        CHECK (PricePerKwh > 0),
	CONSTRAINT FK_StationConnector_Connector
        FOREIGN KEY (ConnectorID) REFERENCES Connector(ConnectorID)
);
INSERT INTO Connector(ConnectorName) VALUES
('Type2'), ('CCS2'), ('CHAdeMO');
INSERT INTO Station(ConnectorID, StationCode, Type, Status, PricePerKwh) VALUES
(1,'EV-FAST-HANOI-01', 'FastCharge', 'Available', 3850),
(1,'EV-NORMAL-DN-01', 'NormalCharge', 'Available', 3200),
(1,'EV-FAST-HCM-01', 'FastCharge', 'Maintenance', 3900);

--The answer to question 2 is here:
CREATE TABLE ChargingSession (
    SessionID      INT IDENTITY(1,1) PRIMARY KEY,
    UserID         INT NOT NULL,
    StationID      INT NOT NULL,
    StartTime      DATETIME NOT NULL DEFAULT GETDATE(),
    EndTime        DATETIME NULL,
    EnergyEstimate DECIMAL(10,2) NOT NULL DEFAULT 0,
    TotalCost      DECIMAL(12,2) NOT NULL DEFAULT 0,
    Status         VARCHAR(20) NOT NULL DEFAULT 'Charging',

    CONSTRAINT FK_ChargingSession_User
        FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_ChargingSession_Station
        FOREIGN KEY (StationID) REFERENCES Station(StationID),

    CONSTRAINT CK_ChargingSession_Status
        CHECK (Status IN ('Pending', 'Charging', 'Cancel', 'Completed')),
    CONSTRAINT CK_ChargingSession_Energy
        CHECK (EnergyEstimate >= 0),
    CONSTRAINT CK_ChargingSession_Cost
        CHECK (TotalCost >= 0),
    CONSTRAINT CK_ChargingSession_Time
        CHECK (EndTime IS NULL OR EndTime >= StartTime)
);
go

INSERT INTO ChargingSession (UserID, StationID, StartTime, EndTime, EnergyEstimate, TotalCost, Status) VALUES
(1, 1, '2026-11-01 08:00', '2026-11-01 09:00', 20.00, 77000, 'Completed'),
(2, 2, '2026-11-02 14:30', '2026-11-02 16:00', 15.00, 48000, 'Completed'),
(3, 1, '2026-11-03 10:00', NULL, 0, 0, 'Charging'),
(1, 2, '2026-11-04 09:00', NULL, 0, 0, 'Pending');
go
--End question 2


--The answer to question 3 is here:
create procedure Sp_CreateChargingSession
	@UserID int,
	@StationID int,
	@StartTime datetime = null
as
begin
	set nocount on;

	declare @Msg nvarchar(500);

	if @UserID is null or @StationID is null
	begin
		raiserror(N'UseID or StationID must not be null',16,1);
		return;
	end

	if not exists (select 1 from Users where @UserID = UserID)
	begin
		raiserror(N'User does not exist',16,1);
		return;
	end

	if not exists (select 1 from Station where @StationID = StationID)
	begin
		raiserror(N'Station does not exist',16,1);
		return;
	end

	if not exists (select 1 from Station 
					where @StationID = StationID and Status = N'Available')
	begin
		raiserror(N'Charging Station is not available',16,1);
	end

	if @StartTime is null
	 set @StartTime = GETDATE();

	begin try
		insert into ChargingSession(UserID,StationID,StartTime,EndTime,EnergyEstimate,TotalCost,Status)
		values (@UserID,@StationID,@StartTime,null, 0,0, 'Charging')

		print N'Charging session created successfully';
	end try
	begin catch
		set @Msg = N'Insert failed : ' + ERROR_MESSAGE();
		raiserror(@Msg,16,1);
	end catch
end;
go
--End question 3


--The answer to question 4 is here:
create trigger Trg_CalculateSessionCost
on ChargingSession
after update
as
begin
	set nocount on;

	if not UPDATE(EnergyEstimate)
		return;
	if exists (select 1 from inserted where EnergyEstimate <=0)
	begin
		raiserror(N'Energy estimate must be greater than 0, update cancel',16,1);
		rollback transaction;
		return;
	end

	update cs
	set cs.EndTime = ISNULL(cs.EndTime, GETDATE()),
		cs.Status = 'Completed',
		cs.TotalCost = i.EnergyEstimate * s.PricePerKwh
	from ChargingSession cs
	inner join inserted i on cs.SessionID = i.SessionID
	inner join Station s on cs.StationID = s.StationID;
end
go
--End question 4


--The answer to question 5 is here:
CREATE VIEW vw_ChargingHistory
AS
SELECT  u.UserID,
        u.FullName,
        u.PhoneNumber,
        s.StationCode,
        s.Type,
        cs.StartTime,
        cs.EndTime,
        cs.EnergyEstimate,
        cs.TotalCost,
        cs.Status
FROM ChargingSession cs
INNER JOIN Users   u ON cs.UserID    = u.UserID
INNER JOIN Station s ON cs.StationID = s.StationID;
GO
--End question 5