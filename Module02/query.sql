--Вычисляем сумму продаж (total sales)
SELECT
	ROUND (SUM (sales),2) AS total_sales
FROM
	public.orders;

--Вычисляем сумму прибыли (total profit)	
SELECT
	ROUND (SUM (profit),2) AS total_profit
FROM
	public.orders;

--Вычисляем коэффициент прибыли (profit ratio)
SELECT
	EXTRACT (YEAR FROM order_date) AS YEAR,
	ROUND (SUM (profit) / SUM (sales) *100, 2) AS profit_ratio
FROM
	public.orders
GROUP BY
	year
ORDER BY
	year;
	
--Вычисляем прибыль на заказ (profit per order)
SELECT
	EXTRACT (YEAR FROM order_date) AS YEAR,
	ROUND (SUM (profit) / SUM (quantity), 2) AS profit_per_order
FROM
	public.orders
GROUP BY
	year
ORDER BY
	year;
	
--Вычисляем количество продаж на одного клиента (seles per customer)
SELECT
	EXTRACT (YEAR FROM order_date) AS YEAR,
	ROUND (AVG (quantity), 2) AS sales_per_customer
FROM
	public.orders
GROUP BY
	year
ORDER BY
	year;
	
--Вычисляем среднюю скидку по регионам
SELECT
		region,
		EXTRACT (YEAR FROM order_date) AS YEAR,
		AVG (discount) AS avg_discount
	FROM
		public.orders
	GROUP BY
		YEAR,
		region
	ORDER BY
		region;
		
--Вычисляем ежемесячные продажи по сегментам (Monthly Sales by Segment)
	SELECT
		ROUND (SUM (sales),2) AS sales_by_segment,
		segment,
		EXTRACT (year FROM order_date) AS year,
		EXTRACT (month FROM order_date) AS month
	FROM
		public.orders
	GROUP BY
		year,
		month,
		segment
	ORDER BY
		segment,
		year,
		month;

--Вычисляем ежемесячные продажи по категориям товара (Monthly Sales by Product Category)
SELECT
		ROUND (SUM (sales),2) AS sales_by_category,
		category,
		EXTRACT (year FROM order_date) AS year,
		EXTRACT (month FROM order_date) AS month
	FROM
		public.orders
	GROUP BY
		year,
		month,
		category
	ORDER BY
		category,
		year,
		month;
		
--Вычисляем продажи по категориям товара за всё время (Sales by Product Category over time)
SELECT
		ROUND (SUM (sales),2) AS sales_by_category,
		category
	FROM
		public.orders
	GROUP BY
		category
	ORDER BY
		category;
		
--Вычисляем продажи и прибыль по покупателям (Sales and Profit by Customer)
SELECT
	customer_name,
	ROUND (SUM (sales),2) AS sales_by_customer,
	ROUND (SUM (profit),2) AS profit_by_customer
FROM
	public.orders
GROUP BY
	customer_name
ORDER BY
	customer_name;
	
--Вычисляем рейтинг покупателей (Customer Ranking)
SELECT
	customer_name,
	ROUND (SUM (sales),2) AS sales_by_customer,
	ROUND (SUM (profit),2) AS profit_by_customer,
	DENSE_RANK () OVER (ORDER BY ROUND (SUM (profit),2) DESC) AS customer_ranking
FROM
	public.orders
GROUP BY
	customer_name;
	
--Вычисляем продажи по регионам (Sales per region)
SELECT
	ROUND (SUM (sales),2) AS sales_per_region,
	region
FROM
	public.orders
GROUP BY
	region;
