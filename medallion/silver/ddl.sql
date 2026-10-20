
IF OBJECT_ID('silver.food_items','U') IS NOT NULL
       DROP TABLE silver.food_items;
GO

CREATE TABLE silver.food_items(
  f_id NVARCHAR(20),
  item NVARCHAR(200),
  food_category NVARCHAR(10)
  )
 ----------------------------------------------------
IF OBJECT_ID('silver.menu','U') IS NOT NULL
       DROP TABLE silver.menu;
GO


  CREATE TABLE silver.menu (
  menu_id NVARCHAR(15),
  r_id INT ,
  f_id NVARCHAR(20),
  cuisine VARCHAR(100),
  price DECIMAL(10,2)
  )

---------------------------------------------------

IF OBJECT_ID('silver.order_items','U') IS NOT NULL
       DROP TABLE silver.order_items;
GO

CREATE TABLE silver.order_items (
  order_item_id INT ,
  order_id INT,
  r_id INT,
  f_id VARCHAR(20),
  price DECIMAL(10,2),
  quantity INT,
  line_amount DECIMAL(10,2)
  )

  ---------------------------------------------------------
  IF OBJECT_ID('silver.orders','U') IS NOT NULL
       DROP TABLE silver.orders;
GO

CREATE TABLE silver.orders (
     order_id INT,
     order_timestamp DATETIME2,
     order_date DATE,
     user_id INT,
     r_id INT,
     restaurant_city VARCHAR(100),
     cuisine VARCHAR(200),
     items_count INT,
     sales_qty INT,
     subtotal DECIMAL(12,2),
     discount DECIMAl(12,2),
     delivery_fee DECIMAL(12,2),
     gst DECIMAL(12,2),
     sales_amount DECIMAL(12,2),
     currency VARCHAR(10),
     payment_method VARCHAR(30),
     order_status VARCHAR(30),
     customer_rating DECIMAL(12,2),
     delivery_time_min DECIMAL(12,2)
     )
-------------------------------------------------------------
 IF OBJECT_ID('silver.restaurants','U') IS NOT NULL
       DROP TABLE silver.restaurants;
GO

CREATE TABLE silver.restaurants (
    r_id INT,
    restaurant_name VARCHAR(200),
    city VARCHAR(100),
    rating DECIMAL(3,1),
    rating_count VARCHAR(50),
    cost DECIMAL(10,2),
    cuisine VARCHAR(200),
    lic_no VARCHAR(50),
    restaurant_link VARCHAR(500),
    address VARCHAR(1000),
    menu_path VARCHAR(100)
    )
---------------------------------
 IF OBJECT_ID('silver.reviews','U') IS NOT NULL
       DROP TABLE silver.reviews;
GO

CREATE TABLE silver.reviews (
    review_id INT,
    order_id INT,
    user_id INT,
    restaurant_id INT,
    rating DECIMAL(3,1),
    comment VARCHAR(MAX),
    review_date DATE )
---------------------------------------------------------
IF OBJECT_ID('silver.users','U') IS NOT NULL
       DROP TABLE silver.users;
GO

CREATE TABLE silver.users(
    user_id INT,
    name VARCHAR(50),
    email VARCHAR(200),
    password VARCHAR(20),
    age INT,
    gender VARCHAR(15),
    marital_status VARCHAR(20),
    occupation VARCHAR(30),
    monthly_income VARCHAR(50),
    educational_qualifications VARCHAR(100),
    family_size INT
    )
-------------------------------------------
