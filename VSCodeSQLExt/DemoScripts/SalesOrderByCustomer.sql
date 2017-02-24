SELECT
    [soh].[SalesOrderId]
    , [soh].[OrderDate]
    , [soh].[CustomerId]
    , c.[FirstName] [CustomerFirstName]
    , c.[LastName] [CustomerLastName]
    , [soh].[TotalDue]
FROM [SalesLT].[SalesOrderHeader] soh
INNER JOIN [SalesLT].[Customer] c
    ON c.[CustomerId] = [soh].[CustomerId]
WHERE [soh].[CustomerID] = 29736 --30025