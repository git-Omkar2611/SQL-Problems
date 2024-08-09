select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_CatalogMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc

select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_ContributorMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc

select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_ScheduleMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc

select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_ProgrammeMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc

select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_OVDMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc

select top 10 *, DATEDIFF(hour,  enddate,createdon) from 
 (
 SELECT  *, 
       Lag(createdon, 1) OVER(
       ORDER BY queue_id ASC) AS EndDate
FROM ONGO_MediaMetadataXML_Queue_ETL
where createdOn > DATEADD(day , -60 , GETDATE())
) as a order by 10 desc