create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

--1
--a
SELECT * FROM dealer INNER JOIN client ON dealer.id = client.dealer_id;
--b
SELECT dealer.name,client.name,city,sell.id,date,amount FROM dealer INNER JOIN client ON client.dealer_id=dealer.id INNER JOIN sell ON client.id = sell.client_id;
--c
SELECT * FROM dealer INNER JOIN client ON dealer.id = client.dealer_id WHERE dealer.location = client.city;
--d
SELECT sell.id,sell.amount,client.name,client.city FROM client INNER JOIN sell ON client.id = sell.client_id AND amount BETWEEN 100 AND 500;
--e
SELECT * FROM dealer LEFT JOIN client ON dealer.id = client.dealer_id;
--f
SELECT client.name,client.city, dealer.name , dealer.charge FROM dealer INNER JOIN client ON dealer.id = client.dealer_id;
--g
SELECT client.name,client.city, dealer.name , dealer.charge FROM dealer INNER JOIN client ON dealer.id = client.dealer_id where dealer.charge > 0.12;
--h
SELECT client.name,client.city,sell.id ,sell.date,sell.amount, dealer.name , dealer.charge FROM dealer INNER JOIN client ON dealer.id = client.dealer_id INNER JOIN sell ON client.id = sell.client_id;
--i
SELECT client.name,dealer.name, sell.id ,sell.amount FROM dealer INNER JOIN client ON dealer.id = client.dealer_id INNER JOIN sell ON client.id = sell.client_id WHERE amount > 2000;

--2
--a
CREATE VIEW a_unique(number) AS
    SELECT COUNT(DISTINCT client.id)
    FROM client;
CREATE VIEW a_purchases(date,average_amount,total_amount) AS
    SELECT date,AVG(amount),SUM(amount)
    FROM sell
    GROUP BY date
    ORDER BY date;
--b
CREATE VIEW b AS
    SELECT * FROM (SELECT * FROM a_purchases ORDER BY total_amount DESC ) AS s LIMIT 5;
--c
CREATE VIEW c(dealer_name,number_of_sales,average_amount,total_amount) AS
    SELECT dealer.name,COUNT(sell.id),AVG(amount),SUM(amount)
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY dealer.id;
--d
CREATE VIEW d(location,dealers_earn) AS
    SELECT location,SUM(charge*amount)
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;
--e
CREATE VIEW e(location,sal_number_of_sales,sal_average_amount,sal_total_amount) AS
    SELECT location,COUNT(sell.id),AVG(amount),SUM(amount)
    FROM dealer INNER JOIN sell ON dealer.id=sell.dealer_id
    GROUP BY location;
--f
CREATE VIEW f(city,exp_number_of_sales,exp_average_amount,exp_total_amount) AS
    SELECT city,COUNT(sell.id),AVG(amount),SUM(amount)
    FROM client INNER JOIN sell ON client.id=sell.client_id
    GROUP BY city;
--g
CREATE VIEW g AS
    SELECT * FROM e INNER JOIN f ON e.location = f.city WHERE f.exp_total_amount>e.sal_total_amount;