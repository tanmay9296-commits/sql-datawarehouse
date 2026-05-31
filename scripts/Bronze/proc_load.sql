EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE	@start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	Set @batch_start_time = GETDATE();
	BEGIN TRY
			PRINT '============================================================================'
			PRINT 'Loading bronze layer';
			PRINT '============================================================================'

			PRINT '-----------------------------------------------------------------------------'
			PRINT 'Loading crm tables';
			PRINT '-----------------------------------------------------------------------------'

			set @start_time = GETDATE();	
			PRINT '>>Truncating table: crm_cust_info '
			TRUNCATE TABLE bronze.crm_cust_info;

			PRINT '>> Inserting data into: crm_cust_info '
			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
			WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';


			PRINT '>>Truncating table: crm_prd_info '
			TRUNCATE TABLE bronze.crm_prd_info;

			PRINT '>>Inserting data into: crm_prd_info '
			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
			WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';


			SET @end_time = GETDATE();	
			PRINT '>>Truncating table: crm_sales_details '
			TRUNCATE TABLE bronze.crm_sales_details;

			PRINT '>>Inserting data into: crm_sales_details '
			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
			WITH( 
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';


	
			PRINT '-----------------------------------------------------------------------------'
			PRINT 'Loading erp tables';
			PRINT '-----------------------------------------------------------------------------'
			SET @end_time = GETDATE();
			PRINT '>>Truncating table: erp_cust_az12 '
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT '>>Inserting data into: erp_cust_az12 '
			BULK INSERT bronze.erp_cust_az12 
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';


			SET @end_time = GETDATE();
			PRINT '>>Truncating table: erp_loc_a101 '
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT '>>Inserting data into: erp_loc_a101 '
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';


			SET @start_time  = GETDATE();
			PRINT '>>Truncating table: erp_pxat_g1v2 '
			TRUNCATE TABLE bronze.erp_pxat_g1v2;

			PRINT '>>Inserting data into: erp_pxat_g1v2 '
			BULK INSERT bronze.erp_pxat_g1v2
			FROM 'C:\Tanmay\Protfolio\SQL\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT '>> load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
			PRINT '-----------';

		SET @batch_end_time = GETDATE();	
		PRINT '--------------------------------------------------------------------------------------'
		PRINT '>> TOTAL LOAD DURATION:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds';
		PRINT '--------------------------------------------------------------------------------------'
	END TRY
	BEGIN CATCH
		PRINT '=========================================================================='
		PRINT 'ERROR OCCURED IN THE LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================================================';

	END CATCH
END
