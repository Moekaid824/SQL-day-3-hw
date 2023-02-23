-- 1. List all customers who live in Texas (use 
-- JOINs) 
SELECT first_name, last_name
FROM customer
WHERE address_id IN (
    SELECT customer.address_id
    FROM customer
    INNER JOIN address
    ON customer.address_id = address.address_id
    WHERE district = 'Texas'
);
-- Answer= There are 5 total customers

-- 2. Get all payments above $6.99 with the Customer's Full Name 
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name, payment.amount 
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99;
-- Answer = There are 3661 customers that were above $6.99 (not to sure if I did it right...)

-- 3. Show all customers names who have made payments over $175(use subqueries) 
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);
-- Answer = There were 135 payments made

-- 4. List all customers that live in Nepal (use the city 
-- table) 
SELECT c.first_name, c.last_name
FROM customer c
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city = 'Nepal';
-- Answer = There are 0

-- 5. Which staff member had the most 
-- transactions? 
SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id) AS transactions 
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY transactions DESC;
-- Answer = Jon Stephens has the most being at 7304

-- 6. How many movies of each rating are 
-- there? 
SELECT rating, COUNT(*) AS movies
FROM film
GROUP BY rating;
-- Answer = There are 5 different ratings

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name 
FROM customer
WHERE customer.customer_id IN (
  SELECT payment.customer_id
  FROM payment
  WHERE payment.amount > 6.99
);
-- Answer = There are 597 customers in total

-- 8. Howmanyfreerentalsdidourstoresgive away?
SELECT COUNT(*) AS free_rentals
FROM rental
JOIN payment ON rental.rental_id = payment.payment_id
WHERE rental.rental_id = 0;
-- Answer = 0 rentals were given