USE [HSSportsDB]
GO

-- Step 1 Get All Dates
	WITH AllDates AS (
    SELECT PKIDDate, StandardDate
    FROM [DIM].[Date]
),
-- Step 2 Get all Products
AllProducts AS (
    SELECT DISTINCT ProdNumber
    FROM [fact].[[FACT]].[Sales Data]] ]
),
-- Step 3 Cross Join all Dates and Products
AllDatesProducts AS (
    SELECT d.PKIDDate, d.StandardDate, p.ProdNumber
    FROM AllDates d
    CROSS JOIN AllProducts p
)
-- Step 4 Show '0' if there are no sales of a product for a given day
SELECT 
    dp.StandardDate AS OrderDate,
    dp.ProdNumber,
    COALESCE(ft.Quantity, 0) AS Quantity,
    COALESCE(ft.TotalSale, 0) AS TotalSale
FROM 
    AllDatesProducts dp
LEFT JOIN 
    [fact].[[FACT]].[Sales Data]] ] ft
ON 
    dp.StandardDate = ft.OrderDate
    AND dp.ProdNumber = ft.ProdNumber
ORDER BY 
    dp.StandardDate, dp.ProdNumber;




	-- Step 1: Calculate the median Quantity and TotalSale for each product
WITH ProductMedians AS (
    SELECT
        ProdNumber,
        -- Calculate median Quantity
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Quantity) OVER (PARTITION BY ProdNumber) AS MedianQuantity,
        -- Calculate median TotalSale
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TotalSale) OVER (PARTITION BY ProdNumber) AS MedianTotalSale
    FROM [fact].[[FACT]].[Sales Data]] ]
	WHERE 		
	 ProdNumber = 'FT644'	
),

-- Step 2: Generate a list of all dates and products by cross joining products with the Date Dimension
ProductDateCombinations AS (
    SELECT
        p.ProdNumber,
        d.StandardDate AS OrderDate
    FROM 
        ( /* SELECT DISTINCT ProdNumber FROM [fact].[[FACT]].[Sales Data]] ] */  
		SELECT  ProdNumber FROM [fact].[[FACT]].[Sales Data]] ] WHERE ProdNumber = 'FT644'
		) p
    CROSS JOIN 
      [DIM].[Date]   d
	  		WHERE
	  p.ProdNumber = 'FT644'	
),

-- Step 3: Combine actual sales data with interpolated data
CompleteSalesData AS (
    SELECT
        pdc.ProdNumber,
        pdc.OrderDate,
        ISNULL(sf.Quantity, pm.MedianQuantity) AS Quantity,
        ISNULL(sf.TotalSale, pm.MedianTotalSale) AS TotalSale,
        CASE 
            WHEN sf.Quantity IS NULL THEN 'interpolated' 
            ELSE 'actual' 
        END AS DataStatus
    FROM 
        ProductDateCombinations pdc
    LEFT JOIN 
       [fact].[[FACT]].[Sales Data]] ]   sf ON pdc.ProdNumber = sf.ProdNumber AND pdc.OrderDate = sf.OrderDate
    LEFT JOIN 
        ProductMedians pm ON pdc.ProdNumber = pm.ProdNumber
    WHERE 
        pdc.OrderDate BETWEEN (SELECT MIN(StandardDate) FROM [DIM].[Date]   ) AND (SELECT MAX(StandardDate) FROM [DIM].[Date] )
)

-- Step 4: Select and order the data as requested
SELECT  
DISTINCT 
    ProdNumber,
    OrderDate,
    Quantity,
    TotalSale,
    DataStatus 
FROM 
    CompleteSalesData
	where ProdNumber = 'FT644'
ORDER BY OrderDate ASC; 
	

<div placeholder id="header" class="whs1">
 <p>&nbsp;</p>
</div>
<h1>Comparing Data Across Reports</h1>

<p>In any given time period, you may not have exactly the same data appear 
 in different reports on the same call. For example, Calls Offered is incremented 
 when a call gets offered to the router. However, other data fields are 
 not incremented until the call is complete. </p>

<p>For example, a call offered at 8:55 might not be done with an agent 
 until 9:05 so that the offered field would show up in the 8:30 half-hour 
 data, but one of the other fields, like Calls Handled, would not show 
 up until the 9:00 half-hour data. This means that the call data from different 
 reports might not match on a half-hour basis (depending on the type of 
 data gathered), but could match over a day's time (if no calls extend 
 across midnight). &nbsp;&nbsp;</p>

<div placeholder id="footer" class="whs1">&nbsp; 

<br><span 
 style="font-family: Verdana, sans-serif; font-size: 9pt;"><font size=1 style="font-size:9pt;">© 1999-2004 
 Cisco Systems, Inc.</font></span>&nbsp;</div>
<script type="text/javascript" language="javascript1.2">
<!--
if (window.writeIntopicBar)
	writeIntopicBar(0);
//-->
</script>
</body>

</html>
