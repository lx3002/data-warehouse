SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

INSERT INTO silver.crm_cust_info(
cst_id,
cst_key,
cst_first_name,
cst_last_name,
cst_gender,
cst_marital_status,
cst_create_date
)


SELECT 
cst_id,
cst_key,
TRIM(cst_first_name) AS cst_first_name,
TRIM(cst_last_name) AS cst_last_name ,
CASE WHEN UPPER(TRIM(cst_gender)) = 'M' THEN 'MALE'
     WHEN UPPER(TRIM(cst_gender)) = 'F' THEN 'FEMALE'
     ELSE 'N/A'
END cst_gender,
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'MARRIED'
     WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'SINGLE'
     ELSE 'N/A'
END cst_marital_status,
cst_create_date

 
FROM(

SELECT
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC ) AS flat_page
FROM bronze.crm_cust_info
WHERE cst_id is not null)t
WHERE flat_page = 1
