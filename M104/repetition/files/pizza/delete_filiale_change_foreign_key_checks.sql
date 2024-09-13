set foreign_key_checks = 0;

delete from filiale
where name = 'Grotto Maria';

set foreign_key_checks = 1;

SELECT * FROM pizzeria.filiale;