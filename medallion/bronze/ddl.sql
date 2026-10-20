/*
===============================================================================
Bronze Layer DDL
===============================================================================
Brief introduction:
    This script creates the raw bronze tables used to store source data for the
    Zomato warehouse analytics project. It drops existing bronze tables first so
    the schema can be recreated cleanly.
===============================================================================
*/

-- Drop existing table if it already exists before recreating it.
IF OBJECT_ID('bronze.order_items', 'U') IS NOT NULL
    DROP TABLE bronze.order_items;
GO

-- Raw order item records from source data.
CREATE TABLE bronze.order_items(
order_item_id INT,
order_id INT,
r_id INT,
f_id VARCHAR(20),
price DECIMAL(10,2),
quantity INT,
line_amount DECIMAL(10,2)
);
GO
--------------------------------------------------------
-- Drop and recreate orders table.
IF OBJECT_ID('bronze.orders', 'U') IS NOT NULL
    DROP TABLE bronze.orders;
GO

-- Order-level fact data captured from the source system.
CREATE TABLE bronze.orders (
    order_id            INT,
    order_timestamp     DATETIME2(0),
    order_date          DATE,
    user_id             INT,
    r_id                INT,
    restaurant_city     VARCHAR(100),
    cuisine             VARCHAR(200),
    items_count         INT,
    sales_qty           INT,
    subtotal            DECIMAL(12,2),
    discount            DECIMAL(12,2),
    delivery_fee        DECIMAL(12,2),
    gst                 DECIMAL(12,2),
    sales_amount        DECIMAL(12,2),
    currency            VARCHAR(10),
    payment_method      VARCHAR(30),
    order_status        VARCHAR(30),
    customer_rating     DECIMAL(3,1),
    delivery_time_min   DECIMAL(6,1)
);

-----------------------------------------------------
-- Drop and recreate reviews table.
IF OBJECT_ID('bronze.reviews', 'U') IS NOT NULL
    DROP TABLE bronze.reviews;
GO

-- Customer review details linked to orders.
CREATE TABLE bronze.reviews (
    review_id       INT,
    order_id        INT,
    user_id         INT,
    restaurant_id   INT,
    rating          DECIMAL(2,1),
    comment         VARCHAR(MAX),
    review_date     DATE
);
----------------------------------------------------------

-- Drop and recreate menu table.
IF OBJECT_ID('bronze.menu', 'U') IS NOT NULL
    DROP TABLE bronze.menu;
GO

-- Raw menu catalog imported from source.
CREATE TABLE bronze.menu (
    source_row_id VARCHAR(50),
    menu_id       VARCHAR(20),
    r_id          VARCHAR(50),
    f_id          VARCHAR(20),
    cuisine       VARCHAR(200),
    price         VARCHAR(100)
);
------------------------------------------------------------

-- Drop and recreate users table.
IF OBJECT_ID('bronze.users', 'U') IS NOT NULL
    DROP TABLE bronze.users;
GO

-- User profile data as ingested from source.
CREATE TABLE bronze.users (
    source_row_id INT,
    user_id                      INT,
    name                         VARCHAR(150),
    email                        VARCHAR(255),
    password                     VARCHAR(255),
    age                          INT,
    gender                       VARCHAR(30),
    marital_status               VARCHAR(50),
    occupation                   VARCHAR(100),
    monthly_income               VARCHAR(50),
    educational_qualifications   VARCHAR(100),
    family_size                  INT
);
-----------------------------------------------------
-- Drop and recreate restaurants table.
IF OBJECT_ID('bronze.restaurants', 'U') IS NOT NULL
    DROP TABLE bronze.restaurants;
GO

-- Restaurant metadata from source systems.
CREATE TABLE bronze.restaurants (
    source_row_id   VARCHAR(50),
    r_id            VARCHAR(50),
    restaurant_name VARCHAR(200),
    city            VARCHAR(100),
    rating          VARCHAR(50),
    rating_count    VARCHAR(50),
    cost            VARCHAR(50),
    cuisine         VARCHAR(300),
    lic_no          VARCHAR(50),
    restaurant_link VARCHAR(500),
    address         VARCHAR(1000),
    menu_path       VARCHAR(100)
);
-------------------------------------------------------
-- Drop and recreate food items table.
IF OBJECT_ID('bronze.food_items', 'U') IS NOT NULL
    DROP TABLE bronze.food_items;
GO

-- Food item reference data loaded from source.
CREATE TABLE bronze.food_items (
    source_row_id INT,
    f_id            VARCHAR(20),
    item            VARCHAR(300),
    veg_or_non_veg  VARCHAR(20)
);
--------------------------------------------------------
