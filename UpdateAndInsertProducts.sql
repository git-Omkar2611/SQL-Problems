CREATE or alter Procedure UpdateAndInsertProducts
AS
BEGIN
	
	BEGIN TRY
		SET NOCOUNT ON
		BEGIN TRAN

			INSERT INTO ProductDetails(Product_ID,Product_Name,Price,last_updated_date)
			select pr.Product_ID,pr.Product_Name,pr.Price,pr.effective_date from ProductDetails_RAW pr
			LEFT JOIN ProductDetails p
			ON pr.Product_ID = p.Product_ID 
			WHERE p.Product_ID is NULL

			create table #temp(Product_ID INT,Product_Name varchar(max),Price bigint,effective_date datetime)

			INSERT INTO #temp
			select t.Product_ID,t.Product_Name,t.Price,t.effective_date from (
			select * , ROW_NUMBER() over (partition by product_id order by product_key desc) as rn from ProductDetails_RAW) t where t.rn = 1
			
			UPDATE P
			SET p.Product_Name = pr.Product_Name , p.Price = pr.Price , p.last_updated_date = pr.effective_date
			from ProductDetails p 
			INNER JOIN #temp pr
			on p.Product_ID = pr.Product_ID
			WHERE p.Product_Name != pr.Product_Name OR p.Price != pr.Price 

		COMMIT TRAN

	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH


END
