USE [HSSportsDB]
GO

sp_help '[STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates]'

SELECT TOP 10 * FROM [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates];

select  min(TotalSale  ) as min_value,
       max(TotalSale) as max_value,
        avg(TotalSale) as avg_value,
        stdev(TotalSale) as stdev_value,
        var(TotalSale) as var_value 
from [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_duplicates]  salesdata

select  min(TotalSale  ) as min_value,
       max(TotalSale) as max_value,
        avg(TotalSale) as avg_value,
        stdev(TotalSale) as stdev_value,
        var(TotalSale) as var_value 
from [STAGING].[vw_H+ Sport FACT sales data_145843_CSV_NOduplicates]  salesdata




