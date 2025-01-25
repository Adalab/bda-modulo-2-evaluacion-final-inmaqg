USE sakila

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. 

SELECT DISTINCT title -- Distinct para que muestre valores únicos
FROM film; -- de la tabla film

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT *
FROM film;

SELECT title AS Titulo, rating AS Clasificacion -- Muéstrame el título y la clasificación
FROM film -- de la tabla film
WHERE rating = 'PG-13'; -- donde la clasificación sea igual a PG-13

/* 3. Encuentra el título y la descripción de todas las películas que contengan
la palabra "amazing" en su descripción. */

SELECT title AS Titulo, description AS Descripcion -- Muéstrame el título y descripción de las películas
FROM film -- de la tabla películas
WHERE description LIKE '%amazing%'; /* usamos LIKE para buscar valores con un patrón específico: que contenga 'amazing'
									    % representa cualquier cantidad de caracteres. Aquí que haya antes o después */
					
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. 
SELECT *
FROM film;

SELECT title AS Titulo
FROM film
WHERE length > '120'; /* Usamos WHERE para filtrar las filas de la tabla film para incluir solo las que duración > 120 */

/* 5. Encuentra los nombres de todos los actores, muestralos en una sola columna que
se llame nombre_actor y contenga nombre y apellido. */
SELECT CONCAT(first_name, ' ', last_name) AS Nombre_actor -- esto lo usamos para agrupar en una columna nombre y apellido
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT first_name AS Nombre, last_name AS apellido
FROM actor
WHERE last_name LIKE '%Gibson%';
-- ó
SELECT first_name AS Nombre, last_name AS apellido
FROM actor
WHERE last_name = 'Gibson';

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name AS Nombre, last_name AS Apellido
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no tengan clasificacion "R" ni "PG-13".
SELECT title AS Titulo, rating AS Clasificacion -- Muéstrame el título y la clasificación
FROM film -- de la tabla film
WHERE rating NOT IN ('R','PG-13'); -- donde la clasificación no sea

/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film
y muestra la clasificación junto con el recuento. */
SELECT rating AS Clasificacion, COUNT(film_id) AS Cantidad_total_peliculas
FROM film
GROUP BY rating; -- Agrupamos las películas por su clasificación para poder contarlas

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra
el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. */
SELECT *
FROM customer;

SELECT *
FROM rental; -- estas dos tablas tienen en común el customer_id

SELECT c.customer_id AS id_cliente, c.first_name AS Nombre_cliente, c.last_name AS Apellido_cliente, COUNT(r.rental_id) AS Cantidad_total_peliculas_alquiladas -- cuenta el nº de alquileres y ponle el nombre ´cantidad total'
FROM customer c -- de la tabla customer
INNER JOIN rental r -- hacemos inner join para que aparezcan solo los clientes que sí han alquilado. (el LEFT pone los null)
ON c.customer_id = r.customer_id
GROUP BY c.customer_id; -- agrupa todas las filas que pertenecen al mismo cliente

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la
categoría junto con el recuento de alquileres */

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT *
FROM inventory;

SELECT *
FROM rental;

SELECT c.name AS Categoria, COUNT(r.rental_id) AS Recuento_alquileres -- cuento el número de alquileres y lo llamo 'recuento_alquileres'
FROM category c -- Cojo la tabla category
INNER JOIN film_category fc -- y le digo únela a la tabla film_category. Se hace INNER JOIN?
ON c.category_id = fc.category_id -- a través de la columna catagory_id que está en ambas
INNER JOIN inventory i -- une a category la tabla inventory (cada paso construye sobre el anterior)
ON fc.film_id = i.film_id -- a film_category a través de film_id
INNER JOIN rental r -- une la tabla a category la tabla rental
ON i.inventory_id = r.inventory_id -- la unión se hace a través de inventory_id
GROUP BY c.name; -- agrupa los resultados por nombre de la categoría

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film
y muestra la clasificación junto con el promedio de duración. */
SELECT *
FROM film;

SELECT rating AS Clasificacion, AVG(length) AS Promedio_de_duracion
FROM film
GROUP BY rating
ORDER BY promedio_de_duracion DESC; -- Lo ordeno para que se aparezca ordenado

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT *
FROM actor;
SELECT *
FROM film_actor;
SELECT*
FROM film;

SELECT a.first_name AS Nombre, a.last_name AS Apellido, f.title AS Titulo_pelicula
FROM actor a
INNER JOIN film_actor fa -- únelo a la tabla film_actor
ON a.actor_id = fa.actor_id -- a través de la columna común actor_id 
INNER JOIN film f -- únelo a la tabla film
ON fa.film_id = f.film_id -- a través de la columna común film_id
WHERE f.title = 'Indian Love'; -- establezco la condición donde el título sea igual a 'Indian Love'

/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
SELECT title, description
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%'; /*-- filtra las filas donde la descripción
																contanga 'dog' o 'cat'*/

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT a.actor_id AS id_actor, a.first_name AS Nombre, a.last_name AS Apellido
FROM actor a
LEFT JOIN film_actor f -- usamos left join para incluir TODOS los actores, aunque no tengan registro en film_actor
ON a.actor_id = f.actor_id
WHERE f.actor_id IS NULL; -- la condición es que el actor_id no esté en film_actor

	-- > La respuesta es NO, todos los actores aparecen por lo menos en una peli

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT *
FROM film;

SELECT title AS Titulo, release_year AS Año_estreno
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM film_category;

SELECT f.title AS Titulo, c.name AS Categoria
FROM film f
INNER JOIN film_category fc -- une la tabla film_category a la tabla film...
ON f.film_id = fc.film_id -- usando film_id (común)
INNER JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT a.first_name AS Nombre, a.last_name AS Apellido, COUNT(f.film_id) AS Numero_peliculas
FROM actor a
INNER JOIN film_actor f
ON a.actor_id = f.actor_id
GROUP BY a.actor_id
HAVING COUNT(f.film_id) > 10;

/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor
a 2 horas en la tabla film.*/
SELECT *
FROM film;

SELECT title AS Titulo_pelicula, rating AS Clasificacion, length AS Duracion
FROM film
WHERE rating = 'R' AND length > '120';

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior
a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT *
FROM film;

SELECT c.name AS Categoria, AVG(f.length) AS Promedio_duracion
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor 
junto con la cantidad de películas en las que han actuado.*/
SELECT * 
FROM actor;

SELECT *
FROM film_actor;

SELECT a.first_name AS Nombre, a.last_name AS Apellido, COUNT(fa.film_id) AS Cantidad_peliculas
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY nombre
HAVING COUNT(fa.film_id) >= 5;

/* 22. Encuentra el título de todas las películas que fueron alquiladas durante más de 5 días.
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego
selecciona las películas correspondientes. Pista: Usamos DATEDIFF para calcular la diferencia
entre una fecha y otra, ej: DATEDIFF(fecha_inicial, fecha_final) */
SELECT *
FROM film;

SELECT *
FROM rental;

SELECT*
FROM inventory;
    
SELECT f.title AS Titulo
FROM film f
WHERE f.film_id IN ( -- el where aquí va a ser el mismo que..
	SELECT i.film_id -- el select de aquí. La columna es común pero de diferente tabla
	FROM rental r
    INNER JOIN inventory i
    ON r.inventory_id = i.inventory_id
	WHERE DATEDIFF(r.return_date, r.rental_date) > 5 -- aquí fecha de devolución para poder calcular la diferencia
    );

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la 
categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en 
películas de la categoría "Horror" y luego exclúyelos de la lista de actores. */


SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT a.first_name AS Nombre, a.last_name AS Apellido
FROM actor a
WHERE a.actor_id NOT IN ( -- que no sea de HORROR.
	SELECT fa.actor_id
	FROM film_actor fa
	INNER JOIN film_category fc
    ON fa.film_id = fc.film_id
	INNER JOIN category c
    ON fc.category_id = c.category_id
	WHERE c.name = 'Horror' -- Le pasamos la condición de que la categoría sea HORROR.
    );

/*BONUS

 24. BONUS: Encuentra el título de las películas que son comedias y tienen
 una duración mayor a 180 minutos en la tabla film con subconsultas.*/
 
SELECT*
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT f.title AS titulo_pelicula, length AS duracion
FROM film f
WHERE f.film_id IN (
	SELECT fc.film_id
    FROM film_category fc
    INNER JOIN category c -- y júntalo a la tabla categoría
    ON fc.category_id = c.category_id
    WHERE length > 180
    );

/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La 
consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que 
han actuado juntos. Pista: Podemos hacer un JOIN de una tabla consigo misma, poniendole un 
alias diferente. */


