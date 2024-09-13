update pizza
set preis = preis + 0.5
where preis <= 7;

update pizza
set preis = preis + 0.3
where preis > 7;

SELECT * FROM pizzeria.pizza;