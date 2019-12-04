CREATE PROCEDURE [dbo].[AddSampleGPSEvent]
@VehicleId varchar(50)
AS
DECLARE @EventDate as smalldatetime

SET @EventDate = GETDATE();

/* Insert a sample row based on an NYC MTA bus event */	
INSERT INTO [dbo].[GPSEvents]
           ([RecordedAtTime]
           ,[DirectionRef]
           ,[PublishedLineName]
           ,[OriginName]
           ,[OriginLat]
           ,[OriginLong]
           ,[DestinationName]
           ,[DestinationLat]
           ,[DestinationLong]
           ,[VehicleRef]
           ,[VehicleLocationLat]
           ,[VehicleLocationLong]
           ,[NextStopPointName]
           ,[ArrivalProximityText]
           ,[DistanceFromStop]
           ,[ExpectedArrivalTime]
           ,[ScheduledArrivalTime])
     VALUES
           (@EventDate
           ,DATEPART(s, @EventDate) % 2
           ,'B8'
           , '4 AV/95 ST'
           , 40.616104
           ,-74.031143
           ,'BROWNSVILLE ROCKAWAY AV'
           ,40.656048
           ,-73.907379
           ,@VehicleId
           ,40.63517
           ,-73.960803
           ,'FOSTER AV/E 18 ST'
           ,'approaching'
           ,76
           ,DATEADD(mi,(DATEPART(s, @EventDate) % 5), @EventDate)
           ,DATEADD(mi,(DATEPART(s, @EventDate) % 5), @EventDate) - DATEPART(s, @EventDate) % 2
		   )
RETURN 
