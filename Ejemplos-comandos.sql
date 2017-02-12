	/*
    USE sakila;
    */
    
    /*-----------------------SELECT Y WHERE----------------------------*/
    
    /*
    SELECT first_name, last_name
    FROM customer
    WHERE store_id = 1
		  OR 
          store_id = 2;
    */
    
    /*
    SELECT * 
    FROM customer
    WHERE active = 0 
		  AND 
          store_id = 1;
		
	*/
    
    /*
    SELECT *
    FROM payment
    WHERE amount
		  BETWEEN
				0.99
                AND 
                1.99
    */
    
    /*
    SELECT *
    FROM payment
    WHERE payment_date 
		  BETWEEN
		    '2005-05-28'
			AND 
            '2005-06-15'
	*/
    
    /*-------------------ORDER BY--------------------*/
    
    /*
    SELECT *
	FROM customer
	WHERE store_id = 1 
		  OR
		  store_id = 2
	ORDER BY store_id, first_name
	*/
    
    /*------------------FUNCIONES DE AGREGADO Y GROUP BY-------------------*/
    /*
      FUNCIONES DE AGREGADO
      -AVG
      -SUM
      -MAX
      -MIN
      -COUNT
      
	  Para usar las funciones de agregado necesitamos dos campos uno para agrupar los campos y el otro para hacer el calculo.
      
      *HAVING reemplaza a WHERE en las consultas de agrupacion.
    */
    
    /*
    SELECT rating, sum(replacement_cost) as TOTAL 
    FROM film
    GROUP BY rating
    ORDER BY TOTAL;
    */
    
    /*
    SELECT rating, 	avg(replacement_cost) as PROMEDIO 
    FROM film
    GROUP BY rating
    HAVING rating = "G" 
		  OR 
		  rating = "NC-17"
    ORDER BY PROMEDIO;
    */
    
    /*
    SELECT country_id, 	count(city) as CIUDAD 
    FROM city
    GROUP BY country_id
    ORDER BY CIUDAD ;
    */
    
    /*
    SELECT payment_id, 	max(amount) as MAXIMO 
    FROM payment
    GROUP BY payment_id
    ORDER BY payment_id, MAXIMO;
    */
    
    /*
    SELECT payment_id, 	min(amount) as MINIMO 
    FROM payment
    GROUP BY payment_id
    ORDER BY payment_id, MINIMO;
    */
    
    /*------------------CONSULTAS CALCULO----------------------*/
    
    /*
	  FUNCIONES DE CALCULO COMUNES
      Now()
      Datediff()
      Date_format()
      Concat()
    */
    
    USE northwind;
    
    /*Consulta para incrementar el 14% al precio
      el precio con iva tendra 2 decimales
	*/
    
    /*
    SELECT category, product_code, product_name, list_price, ROUND(list_price*1.14,2) AS PRECIO_IVA
    FROM products
    GROUP BY category
    ORDER BY category, product_name;
    */
    
    /*Consulta con descuento de $3
    */
    
    /*
    SELECT category, product_code, product_name, list_price, list_price-3 AS PRECIO_CON_DESCUENTO
    FROM products
    GROUP BY category
    ORDER BY category, product_name;
    */
    
    /*Consulta con fecha actual*/
    
    /*
	SELECT order_id, invoice_date, DATE_FORMAT(NOW(),'%d-%m-%y') AS FECHA_ACTUAL, DATEDIFF(NOW(), invoice_date) AS DIFERENCIA_DIAS
    FROM invoices
    ORDER BY order_id;
    */
    
    /*Consulta para agrupar cadenas de caracteres*/
    /*
    SELECT id, company, CONCAT(first_name, ' ',last_name) AS NOMBRE
    FROM customers
    ORDER BY id, company;
    */
    
    /*------------CONSULTAS MULTITABLAS------------*/
    /*
	  Union Externa
      -Union
		Deben tener los mismos campos
        Y deben ser del mismo tipo o compatibles
        Los registros repetidos muestra una sola vez
        
        CONSULTA 1 UNION CONSULTA 2
      -Union All
		Deben tener los mismos campos
        Y deben ser del mismo tipo o compatibles
        Muestra todos los registros repetidos
        
        CONSULTA 1 UNION ALL CONSULTA 2
      -Except
      -Intersect
      -Minus
      
      Union Interna
      -Inner join
		Devuelve la informacion que comparten ambas tablas relacionadas
      -Left join
        Devuelve la informacion que comparten ambaas tablas y la informacion de la tabla de la izquierda
      -Right join
		Devuelve la informacion que comparten ambaas tablas y la informacion de la tabla de la derecha
    */
    
    /*CONSULTA INNER JOIN*/
    
    /*
    SELECT * 
    FROM employees
	INNER JOIN
		orders
		ON employees.id = orders.employee_id
	WHERE employees.city = "Seattle"
	ORDER BY employees.id, orders.id
    */
    
    /*CONSULTA LEFT JOIN*/
    
    /*
	   Se usa IS NULL para mostrar los cmapos nulos
    */
    
    /*
    SELECT * 
    FROM employees
	LEFT JOIN
		orders
		ON employees.id = orders.employee_id
	WHERE employees.city = "Seattle"
		  AND 
          orders.id IS NULL
	ORDER BY employees.id, orders.id
    */
    
    /*---------SUBCONSULTAS---------*/
    /*
	  SUBCONSULTAS
      -SUBCONSULTA ESCALONADA
       Se devuelve un solo resgistro
      -SUBCONSULTA DE LISTA
       Esta consulta devuelve una lista de registros
       
      COMPARADORES
      -LIKE
	   Comparacion de cadena de caracteres
      -<,>,<=,>=,<>
      -BETWEEN
       Intervalos
      -IN estan
      -ANY 
       Cualquiera
      -ALL
       Todos
    */
    
    /*
    SELECT product_code, product_name, list_price
    FROM products
    WHERE list_price > 
						(SELECT ROUND(AVG(list_price),2) AS PRECIO_PROMEDIO
						 FROM products);
	*/
    
    /*
    SELECT *
    FROM products
    WHERE products.list_price > ALL 
							(SELECT list_price 
							 FROM products
							 WHERE category = "Beverages");
	*/
    
    /*
    SELECT id, order_date, ship_name
    FROM orders
    WHERE id in (SELECT order_id
				 FROM invoices
                 WHERE invoice_date 
									BETWEEN '2006-03-00' 
											AND 
                                            '2006-03-31');
	*/
    
    /*---------------CONSULTAS DE ACCION------------------*/
    
    /*
      -update
       Para actualizar los datos de un campo
	  -select into
       Para copiar unos registros en una tabla nueva
	  -delete 
	   Para eliminar registros
	  -distinct
       Para no mostrar filas con datos repeditos, se usa un campo para evaluar
      -distinctrow
       Para no mostrar filas repetidas, se usa toda la fila para evaluar
    */
    
    /*
    UPDATE products
    SET list_price = list_price + 10
    WHERE category = "Oil";
    */
    
    /*
    CREATE TABLE products_oil
    SELECT *
    FROM products
    WHERE category = "Oil";
    
    ------Access--------
    SELECT *
    INTO products_oil
    FROM products
    WHERE category = "Oil"
    */
    
    /*
    DELETE 
    FROM products
    WHERE category = 'Soups'
          AND
          list_price BETWEEN	1.9
								AND 
								9.7;
                                
	DELETE 
    FROM products
    WHERE id = 99;
	*/
    
    /*
    SELECT DISTINCT products.*, inventory_transactions.product_id
    FROM products
    LEFT JOIN inventory_transactions
		ON products.id = inventory_transactions.product_id
	WHERE inventory_transactions.product_id is null;
    
    SELECT DISTINCT products.*, inventory_transactions.product_id
    FROM products
    LEFT JOIN inventory_transactions
		ON products.id = inventory_transactions.product_id
	WHERE inventory_transactions.product_id is null;
    */
    
    
    /*
    
    Copia unos registros en una nueva tabla
    
    CREATE TABLE customers_quito
    SELECT * 
    FROM customers
    WHERE job_title = 'Owner';
    
    Para anexar datos de otra tabla
    -Se debe incluir los campos claves y los campos requeridos
	-INSERT INTO customes (campos) SELECT campos
    
    INSERT INTO customers
    SELECT * 
    FROM customers_quito;
    */
    
    /*----------CONSULTAS DE REFERENCIAS CRUZADAS--------------*/
    
    /*
	  Las consultas de referencias cruzadas son muy parecidas a las tablas dinamicas de excel,
      poseen zona de las columnas, zona de las filas y la zona de los totales
    */
    
    select * from products;
    
    SELECT product_code, 
			SUM(if(category = 'Beverages', standard_cost, null)) AS Beverages,
            SUM(if(category = 'Candy', standard_cost, null)) AS Candy,
            SUM(if(category = 'Cereal', standard_cost, null)) AS Cereal,
            SUM(if(category = 'Condiments', standard_cost, null)) AS Condiments
    FROM products
    GROUP BY product_code
    