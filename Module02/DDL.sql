-- *************** SqlDBM: PostgreSQL ****************;
-- ***************************************************;

-- ************************************** calendar
DROP TABLE IF EXISTS calendar
CREATE TABLE calendar
(
 order_date date NOT NULL,
 ship_date  date NOT NULL,
 year       int4range NOT NULL,
 quarter    varchar(5) NOT NULL,
 month      int4range NOT NULL,
 week       int4range NOT NULL,
 week_day   int4range NOT NULL,
 CONSTRAINT PK_43 PRIMARY KEY ( order_date, ship_date )
);

-- ************************************** customer_dim
DROP TABLE IF EXISTS customer_dim
CREATE TABLE customer_dim
(
 customer_dim_id serial NOT NULL,
 customer_name   varchar(22) NOT NULL,
 segment         varchar(11) NOT NULL,
 customer_id     varchar(10) NOT NULL,
 CONSTRAINT PK_39 PRIMARY KEY ( customer_dim_id )
);

-- ************************************** geo_dim

DROP TABLE IF EXISTS geo_dim
CREATE TABLE geo_dim
(
 geo_dim_id  serial NOT NULL,
 country     varchar(13) NOT NULL,
 city        varchar(17) NOT NULL,
 "state"       varchar(20) NOT NULL,
 region      varchar(7) NOT NULL,
 postal_code int4range NOT NULL,
 CONSTRAINT PK_29 PRIMARY KEY ( geo_dim_id )
);

-- ************************************** product_dim

DROP TABLE IF EXISTS product_dim 
CREATE TABLE product_dim
(
 prod_dim_id  serial NOT NULL,
 category     varchar(20) NOT NULL,
 subcategory  varchar(20) NOT NULL,
 product_name varchar(127) NOT NULL,
 product_id   varchar(20) NOT NULL,
 CONSTRAINT PK_16 PRIMARY KEY ( prod_dim_id )
);

-- ************************************** ship_dim

DROP TABLE IF EXISTS ship_dim
CREATE TABLE ship_dim
(
 ship_dim_id serial NOT NULL,
 ship_mode   varchar(14) NOT NULL,
 CONSTRAINT PK_86 PRIMARY KEY ( ship_dim_id )
);

-- ************************************** sales_fact

DROP TABLE IF EXISTS sales_fact
CREATE TABLE sales_fact
(
 row_id          int4range NOT NULL,
 order_date      date NOT NULL,
 geo_dim_id      serial NOT NULL,
 customer_dim_id serial NOT NULL,
 prod_dim_id     serial NOT NULL,
 ship_date       date NOT NULL,
 sales           numeric(9,4) NOT NULL,
 quantity        int4range NOT NULL,
 discount        numeric(4,2) NOT NULL,
 profit          numeric(21,16) NOT NULL,
 ship_dim_id     serial NOT NULL,
 order_id        date NOT NULL,
 CONSTRAINT PK_81 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_59 FOREIGN KEY ( order_date, ship_date ) REFERENCES calendar ( order_date, ship_date ),
 CONSTRAINT FK_63 FOREIGN KEY ( prod_dim_id ) REFERENCES product_dim ( prod_dim_id ),
 CONSTRAINT FK_66 FOREIGN KEY ( ship_dim_id ) REFERENCES ship_dim ( ship_dim_id ),
 CONSTRAINT FK_69 FOREIGN KEY ( customer_dim_id ) REFERENCES customer_dim ( customer_dim_id ),
 CONSTRAINT FK_72 FOREIGN KEY ( geo_dim_id ) REFERENCES geo_dim ( geo_dim_id )
);

CREATE INDEX FK_62 ON sales_fact
(
 order_date,
 ship_date
);

CREATE INDEX FK_65 ON sales_fact
(
 prod_dim_id
);

CREATE INDEX FK_68 ON sales_fact
(
 ship_dim_id
);

CREATE INDEX FK_71 ON sales_fact
(
 customer_dim_id
);

CREATE INDEX FK_74 ON sales_fact
(
 geo_dim_id
);

