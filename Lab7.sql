--EX1
--How we can store large-object types:
--blob: binary large object and collection of binary data  
--clob: character large object – collection of character data 

-- Ex2 
create role accountant
create role adminstrator
create role support
create user Boss
create user admin
grant accountant to adminstrator
grant support to accountant
grant accountant to boss;
grant adminstrator to admin
grant accountant to admin
revoke boss from accountant

-- Ex5
-- 1
create unique index  test11 on accounts(account_id)
-- 2
create index test22 on accounts
    (user_defined,balance);

-- EX6
begin transaction
update accounts
set balance = a.balance + 100.00
from accounts a, transactions t
where a.account_id = t.dst_account
savepoint s1
update accounts
set balance = a.balance - 100.00
from accounts a, transactions t
where a.account_id = t.src_account and a.balance - 100 > a.limit
commit;
rollback;
