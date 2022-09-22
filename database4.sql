CREATE DATABASE database4

USE database4

CREATE TABLE `product_type`(
    id_type INT (11) auto_increment primary key,
    name_type VARCHAR (255)  not NULL,
    create_at TIMESTAMP default current_timestamp(),
    updated_at TIMESTAMP default current_timestamp on update current_timestamp()
);

CREATE TABLE `merk`(
    id_merk INT (11) auto_increment primary key,
    name_merk VARCHAR (255)  not NULL,
    create_at TIMESTAMP default current_timestamp(),
    updated_at TIMESTAMP default current_timestamp on update current_timestamp()
);

CREATE TABLE `product`(
    id_product INT (11) auto_increment primary key,
    type_product INT (11),
    merk INT (11),
    code VARCHAR (50) not NULL,
    name VARCHAR (100) not NULL,
    status smallint,
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp(),
    constraint fk_product_type foreign key (type_product) references product_type(id_type) on delete cascade,
    constraint fk_product_merk foreign key (merk) references merk(id_merk) on delete cascade
);

CREATE TABLE `product_description`(
    id INT (11),
    descrision TEXT not NULL ,
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp(),
    constraint fk_product_description_product foreign key (id) references product(id_product) on delete cascade,
    primary key (id)
);

CREATE TABLE `user`(
    id_user INT (11) auto_increment primary key,
    name VARCHAR (255) not NULL,
    status smallint not NULL,
    dob datetime not NULL,
    gender char (1),
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp()
);

CREATE TABLE `payment_method`(
    id_payment INT (11) auto_increment primary key,
    name VARCHAR (255) not NULL,
    status smallint not NULL,
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp()
);

CREATE TABLE `transaction`(
    id_transaction INT (11) auto_increment primary key,
    user INT (11),
    payment INT (11),
    status VARCHAR (10) not NULL,
    total_qty INT (11) not NULL,
    total_price bigint not NULL,
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp(),
    constraint fk_transaction_user foreign key (user) references user(id_user) on delete cascade,
    constraint fk_transaction_payment foreign key (payment) references payment_method(id_payment) on delete cascade
);

CREATE TABLE `detail_transaction`(
    transaction INT (11),
    product INT (11),
    status VARCHAR (10) not NULL,
    qty INT (11) not NULL,
    price bigint not NULL,
    create_at TIMESTAMP default current_timestamp(),
    update_at TIMESTAMP default current_timestamp on update current_timestamp(),
    constraint fk_detail_transaction foreign key (transaction) references transaction(id_transaction) on delete cascade,
    constraint fk_detail_transaction_product foreign key (product) references product(id_product) on delete cascade,
    primary key (transaction,product)
);

INSERT INTO transaction(user,payment,status,total_qty,total_price) VALUES
(1,1,1,3,230000),
(2,3,1,3,265000),
(4,1,1,3,325000),
(1,1,1,3,120000),
(2,1,1,3,290000),
(4,3,1,4,260000),
(1,3,1,4,205000),
(2,3,1,3,180000),
(4,1,1,3,325000)

INSERT INTO detail_transaction(transaction,product,status,qty,price) VALUES
(1,1,1,1,50000),
(1,2,1,1,30000),
(1,3,1,1,150000),
(2,3,1,1,150000),
(2,5,1,1,40000),
(2,8,1,1,75000),
(3,7,1,1,100000),
(3,8,1,1,75000),
(3,6,1,1,150000),
(4,5,1,1,40000),
(4,2,1,1,30000),
(4,1,1,1,50000),
(5,7,1,1,100000),
(5,3,1,1,150000),
(5,5,1,1,40000),
(6,4,1,1,70000),
(6,5,1,1,40000),
(6,6,1,1,150000),
(7,8,1,1,75000),
(7,2,1,1,30000),
(7,7,1,1,100000),
(8,1,1,1,50000),
(8,2,1,1,30000),
(8,7,1,1,100000),
(9,6,1,1,150000),
(9,7,1,1,100000),
(9,8,1,1,75000)



select *
from transaction where user = 1
union
select *
from transaction where user = 2

select sum (total_price) as total
from transaction
where user = 1

select count(transaction) as total_tr_type2
from detail_transaction
where product = 3 or product = 4 or product = 5

select ty.name_type,p.code,p.name
from product p
join product_type ty on ty.id_type = p.type_product


select u.name,p.name,dt.qty, dt.price
from transaction tr
join detail_transaction dt on tr.id_transaction = dt.transaction
join user u on tr.user = u.id_user
join product p on p.id_product = dt.product


select * 
from product where not exists 
    (
    select * from detail_transaction
    where product = product.id_product
)

