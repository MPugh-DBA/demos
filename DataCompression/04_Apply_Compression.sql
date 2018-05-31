USE [AdventureWorks2016]

--Apply compression to the Clustered Index
ALTER TABLE [Sales].[SalesOrderDetail] REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = ROW)

--Apply compression to the NC Index
ALTER INDEX [IX_SalesOrderDetail_ProductID] 
ON [Sales].[SalesOrderDetail] REBUILD PARTITION = ALL 
WITH (DATA_COMPRESSION = ROW)
