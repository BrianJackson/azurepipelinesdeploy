CREATE TABLE [dbo].[GPSEvents]
(
	[Id] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [RecordedAtTime] SMALLDATETIME NULL, 
    [DirectionRef] SMALLINT NULL, 
    [PublishedLineName] VARCHAR(20) NULL, 
    [OriginName] VARCHAR(100) NULL, 
    [OriginLat] DECIMAL(10, 6) NULL, 
    [OriginLong] DECIMAL(10, 6) NULL, 
    [DestinationName] VARCHAR(100) NULL, 
    [DestinationLat] DECIMAL(10, 6) NULL, 
    [DestinationLong] DECIMAL(10, 6) NULL, 
    [VehicleRef] VARCHAR(100) NULL, 
    [VehicleLocationLat] DECIMAL(10, 6) NULL, 
    [VehicleLocationLong] DECIMAL(10, 6) NULL, 
    [NextStopPointName] VARCHAR(100) NULL, 
    [ArrivalProximityText] VARCHAR(100) NULL, 
    [DistanceFromStop] NCHAR(10) NULL, 
    [ExpectedArrivalTime] SMALLDATETIME NULL, 
    [ScheduledArrivalTime] SMALLDATETIME NULL
)

GO
EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = N'0 outbound, 1 inbound',
    @level0type = N'SCHEMA',
    @level0name = N'dbo',
    @level1type = N'TABLE',
    @level1name = N'GPSEvents',
    @level2type = N'COLUMN',
    @level2name = N'DirectionRef'