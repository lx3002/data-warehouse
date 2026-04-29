CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

BEGIN TRY

DECLARE @start_time DATETIME, @end_time DATETIME


SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info
from 'C:\Users\PC\Downloads\source_crm\cust_info.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT  'time taken to insert data into bronze.crm_cust_info' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds'


SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
from 'C:\Users\PC\Downloads\source_crm\prd_info.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();

PRINT 'TIME TAKEN TO LOAD DATA INTO BRONZE.CRM.PRD_INFO' + CAST(DATEDIFF(second, @start_time, @end_time) AS nvarchar) + 'seconds'


SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
from 'C:\Users\PC\Downloads\source_crm\sales_details.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT  'time taken to insert data into bronze.crm_sales_details: ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds'

SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12
from 'C:\Users\PC\Downloads\source_erp\CUST_AZ12.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT  'time taken to insert data into bronze.erp_cust_az12 ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds'

SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101
from 'C:\Users\PC\Downloads\source_erp\LOC_A101.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT  'time taken to insert data into bronze.erp_loc_a101 ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds'


SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\PC\Downloads\source_erp\PX_CAT_G1V2.csv'
with(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT  'time taken to insert data into bronze.erp_px_cat_g1v2 ' + CAST(DATEDIFF(second, @start_time, @end_time) as nvarchar) + 'seconds'

END TRY

BEGIN CATCH
PRINT 'Error occurred while loading data into bronze tables: ' + ERROR_MESSAGE();
PRINT 'ERROR_MESSAGE()'+ CAST(ERROR_NUMBER() AS NVARCHAR)
PRINT 'ERROR_MESSAGE()'+ CAST(ERROR_STATE() AS NVARCHAR)
END CATCH

END

