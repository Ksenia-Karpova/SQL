/*
Отобразить количество привлечённых средств для новостных компаний США (данные из таблицы company). Отсортировать таблицу по убыванию значений в поле funding_total.
*/

SELECT funding_total
FROM company
WHERE category_code ='news'
AND country_code = 'USA'
ORDER BY (funding_total) DESC;

/*
Вывести на экран всю информацию о людях, у которых названия аккаунтов в поле network_username содержат подстроку 'money', а фамилия начинается на 'K'.
*/

SELECT *
FROM people
WHERE network_username LIKE '%money%'
AND last_name LIKE 'K%';

/*
Для каждой страны отобразить общую сумму привлечённых инвестиций, которые получили компании, зарегистрированные в этой стране. Страну, в которой зарегистрирована компания, можно определить по коду страны. Отсортировать данные по убыванию суммы.
*/

SELECT country_code,
SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY SUM(funding_total) DESC;

/*
Отобразить имя и фамилию всех сотрудников стартапов. Добавить поле с названием учебного заведения, которое окончил сотрудник, если эта информация известна.
*/

SELECT pep.first_name,
pep.last_name,
edu.instituition
FROM people AS pep
LEFT OUTER JOIN education AS edu ON pep.id = edu.person_id;

/*
Найти общую сумму сделок по покупке одних компаний другими в долларах. Отобрать сделки, которые осуществлялись только за наличные с 2011 по 2013 год включительно.
*/

SELECT SUM(price_amount)
FROM acquisition
WHERE CAST(acquired_at AS date) BETWEEN '2011-01-01' and '2013-12-31'
AND term_code = 'cash';

/*
Выяснить, в каких странах находятся фонды, которые чаще всего инвестируют в стартапы. Для каждой страны посчитать минимальное, максимальное и среднее число компаний, в которые инвестировали фонды этой страны, основанные с 2010 по 2012 год включительно. Исключить страны с фондами, у которых минимальное число компаний, получивших инвестиции, равно нулю. Выгрузить десять самых активных стран-инвесторов: отсортировать таблицу по среднему количеству компаний от большего к меньшему. Затем добавить сортировку по коду страны в лексикографическом порядке.
*/

SELECT country_code,
MIN(invested_companies),
MAX(invested_companies),
AVG(invested_companies)
FROM fund
WHERE CAST(founded_at AS date) BETWEEN '2010-01-01' AND '2012-12-31'
GROUP BY(country_code)
HAVING MIN(invested_companies) > 0
ORDER BY AVG(invested_companies) DESC, country_code
LIMIT 10;
