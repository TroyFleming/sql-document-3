-- 1) List all customers who live in Texas (use JOINs)
select first_name, last_name, address, address.district, address.address_id
from customer
left join address
on address.address_id = customer.address_id
where district = 'Texas';

-- 2) Get all payments above $6.99 with the customer's full name
select customer.customer_id, concat(first_name, ' ', last_name) as full_name, payment.amount 
from customer
left join payment
on customer.customer_id = payment.customer_id
where amount > 6.99
order by amount asc;

-- 3) Show all customers names who have made payments over $175 (use subqueries)
select concat(first_name, ' ', last_name) as customer_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 175
);

-- 4) List all customers that live in Nepal (use city table)
select concat(first_name, ' ', last_name) as customer_name, address, country.country
from customer
inner join address
on customer.address_id = address.address_id
inner join city
on address.address_id = city.city_id
inner join country
on city.country_id = country.country_id
where country in (
	select country
	from country
	where country = 'Nepal'
);

-- 5) Which staff member had the most transactions?
select concat(first_name, ' ', last_name) as staff_member, count(rental.rental_id)
from staff
inner join rental
on rental.staff_id = staff.staff_id
group by staff.staff_id
limit 1;

-- 6) How many movies of each rating are there?
select rating, count(rating) as num_of_movies
from film
group by rating;

-- 7) Show all customers who have made a single payment above $8.99 (use subqueries)
select concat(first_name, ' ', last_name)
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 8.99
	group by customer_id
	having count(amount) = 1
);

-- 8) How many free rentals did our stores give away?
select count(rental_id)
from payment
where amount <= 0;