/*
1. Find out the number of documentaries with deleted scenes.
*/
SELECT count(*) FROM film 
JOIN film_category AS fc ON fc.film_id = film.film_id
JOIN category AS c ON c.category_id = fc.category_id
WHERE c.name = 'Documentary' AND film.special_features LIKE '%Deleted Scenes%';


/*
2. Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
*/

SELECT count(distinct film.film_id)
FROM film , category,film_category,inventory,rental,staff,store
WHERE film.film_id = film_category.film_id
AND film_category.category_id = category.category_id
AND store.store_id = staff.store_id
AND staff.staff_id = rental.staff_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
AND category.name = 'Sci-Fi'
AND store.store_id = (SELECT store.store_id from store JOIN staff ON store.store_id = staff.store_id 
                       WHERE staff.first_name = 'Jon' AND staff.last_name = 'Stephens');




/*
3. Find out the total sales from Animation movies.
*/
SELECT total_sales AS TotalSales
FROM sales_by_film_category 
WHERE category = 'Animation';

SELECT SUM(payment.amount) AS TotalSales FROM category 
JOIN film_category AS fc ON fc.category_id = category.category_id 
JOIN film On film.film_id = fc.film_id
JOIN inventory AS inv ON inv.film_id = film.film_id
JOIN rental ON inv.inventory_id = rental.inventory_id 
JOIN payment ON rental.rental_id = payment.rental_id
WHERE category.name = 'Animation';

    
/*
4. Find out the top 3 rented category of movies  by “PATRICIA JOHNSON”.
*/

SELECT DISTINCT category.name
FROM customer,rental,inventory,film,film_category,category
WHERE customer.customer_id = rental.customer_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
AND film.film_id = film_category.film_id
AND film_category.category_id = category.category_id
AND customer.first_name = 'PATRICIA'
AND customer.last_name = 'JOHNSON'
LIMIT 3;
    



/*
5. Find out the number of R rated movies rented by “SUSAN WILSON”.
*/


SELECT count(film.film_id)
FROM customer,rental,inventory,film
WHERE customer.customer_id = rental.customer_id
AND rental.inventory_id = inventory.inventory_id
AND inventory.film_id = film.film_id
AND customer.first_name = 'SUSAN'
AND customer.last_name = 'WILSON'
AND film.rating = 'R';
    
SELECT count(*) AS R_rated_movies_rented_by_SusanWilson from film
JOIN inventory AS inv ON inv.film_id=film.film_id
JOIN rental ON rental.inventory_id = inv.inventory_id
JOIN customer AS cu ON cu.customer_id=rental.customer_id 
WHERE film.rating = 'R' AND concat(cu.first_name,' ',cu.last_name)='SUSAN WILSON';


