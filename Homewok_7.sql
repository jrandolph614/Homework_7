Use  sakila;
#1a 
select first_name, last_name from actor;
#1b
select actor_id, concat(first_name, " ", last_name) as actor_name from actor;
#2a
select * from actor
where first_name = "Joe";
#2b
select * from actor
where last_name like "%G%"
and last_name like "%E%"
and last_name like "%N%";
#2c
select last_name, first_name from actor
where last_name like "%L%"
and last_name like "%I%";
#2d
select country_id, country from country
where country in ("Afghanistan", "Bangladesh", "China");
#3a
alter table actor 
add column description blob;
#3b
alter table actor drop description;
#4a
select count(last_name), last_name
from actor 
group by last_name asc;
#4b
select count(last_name), last_name
from actor 
group by last_name
having count(last_name) > 1
;
#4c
select * from actor
where first_name = "GROUCHO";

update actor
set First_name= "HARPO"
where actor_id = 172;

select * from actor
where first_name = "Harpo";
#4d
update actor
set First_name= "GROUCHO"
where actor_id = 172;
#5a
Show Create table address;
#6a;
select staff.first_name, staff.last_name, address.address, address.district, address.city_id, address.postal_code
From staff
inner join address on 
address.address_id= staff.address_id;
#6b;
select * from payment;
select * from staff;
select staff.first_name, staff.last_name, sum(payment.amount) as total_payment
from staff left join payment on staff.staff_id = payment.staff_id
group by staff.first_name;
#6c
select * from film_actor;
select * from film;
select film.title, count(film_actor.actor_id) as number_of_actors
from film_actor inner join film on film.film_id = film_actor.film_id
group by film.title; 
#6d
select film.title, count(inventory.film_id)
from inventory 
inner join film on film.film_id = inventory.film_id
group by film.title
having film.title = "Hunchback Impossible";
#6e
select * from payment;
select * from customer;
select customer.first_name, customer.last_name, sum(payment.amount) as "Total Amount Paid"
from payment 
inner join customer on customer.customer_id= payment.customer_id
group by customer.first_name;
#7a
select title from film
where language_id in
	( select language_id
    from language 
    where language_id = 1) and title like "k%"
or  title like "Q%";
#7b
select first_name, last_name
from actor 
where actor_id in 
( 	select actor_id 
	from film_actor
    where film_id in (
		select film_id
        from film 
        where title = "Alone Trip"));
 #7c   
select first_name, last_name, email
from customer 
where address_id 
in ( 
	select address_id
	from address
    where city_id 
    in(
		select city_id
        from city 
        where country_id
        in(
			select country_id
            from country
            where country= "Canada"
			)
		)
	);


select * from customer;
select * from address;
select * from city;
select * from country;
#7d
select *from film;
select * from film_category;
select * from category;

select title 
from film 
where film_id 
in( 
	select film_id
    from film_category
    where category_id 
    in(
		select category_id
        from category 
        where name = "family"
    )
    
);
#7e
SELECT film.title , COUNT(film.title) as "Number of Rentals"
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(film.title) DESC;
#7f
select * from store;
select * from staff;
select * from rental;
select * from payment;


select store.store_id, sum(payment.amount) as "Total Revenue"
from store 
left join staff on store.store_id= staff.store_id
left join rental on staff.staff_id= rental.staff_id
left join payment on rental.rental_id =payment.rental_id
group by store.store_id;
#7g
select * from store;
select * from address;
select * from city;
select * from country;

select store.store_id, address.address, city.city, country.country
from store
left join address on address.address_id = store.address_id
left join city on city.city_id = address.city_id
left join country on country.country_id = city.country_id
group by store.store_id;
#7h
select * from category; 
select * from film_category;
select * from inventory;
select * from payment;
select * from rental;

select category.name, sum(payment.amount) as "Total Revanue"
from category
left join film_category on film_category.category_id = category.category_id
left join inventory on inventory.film_id = film_category.film_id
left join rental on rental.inventory_id = inventory.inventory_id
left join payment on payment.rental_id = rental.rental_id
group by category.name
order by sum(payment.amount) desc;
#8a
create view Top_Five_Genres as (
select category.name, sum(payment.amount) as "Total Revanue"
from category
left join film_category on film_category.category_id = category.category_id
left join inventory on inventory.film_id = film_category.film_id
left join rental on rental.inventory_id = inventory.inventory_id
left join payment on payment.rental_id = rental.rental_id
group by category.name
order by sum(payment.amount) desc);
#8b
Select * from Top_Five_Genres;
#8c
Drop View Top_Five_Genres;