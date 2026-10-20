/*
    Silver Layer Transformation Script
    ---------------------------------
    This script loads cleaned and standardized data from the bronze layer into the silver layer.

    Purpose:
    - Convert raw source values into consistent, analytics-ready formats.
    - Clean invalid values, remove noise, and normalize text for reporting.
    - Preserve business keys and essential attributes needed for downstream marts.
    - Prepare the silver data model for dimension and fact analysis.

    Notes:
    - These INSERT statements are designed to move curated datasets from bronze to silver.
    - Data quality checks are applied inline to filter malformed or unusable records.
    - The logic is intentionally simple and transparent so it can be maintained easily.
*/

-- ============================================================
-- Silver layer data load: food items
-- ============================================================
-- Load cleaned food catalog records into silver.food_items.
-- The transformation removes junk characters and invalid item names,
-- while ensuring only meaningful food labels are retained.
INSERT INTO silver.food_items (
    f_id,
    item,
    food_category
)
SELECT
    f_id,
    LTRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(item, '''', ''),
                '#', ''),
            '%', ''),
        '&', '')
    ) AS item,
    CASE
        WHEN UPPER(TRIM(REPLACE(REPLACE(veg_or_non_veg, CHAR(13), ''), CHAR(10), '')))
             IN ('VEG', 'NON-VEG')
        THEN UPPER(TRIM(REPLACE(REPLACE(veg_or_non_veg, CHAR(13), ''), CHAR(10), '')))
        ELSE 'Unknown'
    END AS food_category
FROM bronze.food_items
WHERE item IS NOT NULL
  AND TRIM(item) <> ''
  AND item NOT LIKE '#NAME?%'
  AND TRY_CAST(item AS INT) IS NULL
  AND item NOT LIKE 'R[0-9]%'
  AND item NOT LIKE '%[0-9]';

--------------------------------------------------------

-- ============================================================
-- Silver layer data load: menu
-- ============================================================
-- Load menu data after removing unwanted formatting characters from price fields.
-- This table supports menu pricing and cuisine analysis.
INSERT INTO silver.menu (
    menu_id,
    r_id,
    f_id,
    cuisine,
    price
)
SELECT
    menu_id,
    r_id,
    f_id,
    cuisine,
    CAST(REPLACE(price, CHAR(13), '') AS DECIMAL(10,2))
FROM bronze.menu
WHERE price IS NOT NULL
  AND price NOT LIKE '%FOR TWO%';

----------------------------------------------------------------------------- 

-- ============================================================
-- Silver layer data load: order items
-- ============================================================
-- Load item-level order detail into the silver fact table.
-- Line amount is calculated as price * quantity to support revenue analysis.
INSERT INTO silver.order_items (
    order_item_id,
    order_id,
    r_id,
    f_id,
    price,
    quantity,
    line_amount
)
SELECT
    order_item_id,
    order_id,
    r_id,
    f_id,
    price,
    quantity,
    price * quantity
FROM bronze.order_items
WHERE price != 0;

--------------------------------------------------

-- ============================================================
-- Silver layer data load: orders
-- ============================================================
-- Load cleaned transaction-level order data into the order fact table.
-- This captures customer order details, payment methods, discounts, and fulfillment metrics.
INSERT INTO silver.orders (
    order_id,
    order_timestamp,
    order_date,
    user_id,
    r_id,
    restaurant_city,
    cuisine,
    items_count,
    sales_qty,
    subtotal,
    discount,
    delivery_fee,
    gst,
    sales_amount,
    currency,
    payment_method,
    order_status,
    customer_rating,
    delivery_time_min
)
SELECT
    order_id,
    order_timestamp,
    order_date,
    user_id,
    r_id,
    restaurant_city,
    cuisine,
    items_count,
    sales_qty,
    subtotal,
    discount,
    delivery_fee,
    gst,
    sales_amount,
    currency,
    payment_method,
    order_status,
    customer_rating,
    delivery_time_min
FROM bronze.orders;

-----------------------------------------

-- ============================================================
-- Silver layer data load: restaurants
-- ============================================================
-- Load restaurant master data after cleaning ratings and formatting strings.
-- Invalid or placeholder records are filtered to ensure only valid restaurant records are kept.
INSERT INTO silver.restaurants (
    r_id,
    restaurant_name,
    city,
    rating,
    rating_count,
    cost,
    cuisine,
    lic_no,
    restaurant_link,
    address,
    menu_path
)
SELECT
    CAST(r_id AS INT),
    TRIM(restaurant_name),
    TRIM(city),
    CASE
      WHEN TRIM(rating) IN ('-', '', 'N/A') THEN NULL
      ELSE TRY_CAST(rating AS DECIMAL(3,1))
    END AS rating,
    TRIM(rating_count),
    CAST(REPLACE(cost, '? ', '') AS DECIMAL(10,2)),
    TRIM(cuisine),
    lic_no,
    restaurant_link,
    UPPER(TRIM(address)),
    menu_path
FROM bronze.restaurants
WHERE restaurant_name IS NOT NULL
  AND lic_no IS NOT NULL
  AND UPPER(TRIM(lic_no)) <> 'LICENSE';

------------------------------------------------

-- ============================================================
-- Silver layer data load: reviews
-- ============================================================
-- Load review records while trimming unnecessary whitespace in comment text.
-- This supports customer experience and rating analysis.
INSERT INTO silver.reviews (
    review_id,
    order_id,
    user_id,
    restaurant_id,
    rating,
    comment,
    review_date
)
SELECT
    review_id,
    order_id,
    user_id,
    restaurant_id,
    rating,
    TRIM(comment),
    review_date
FROM bronze.reviews;

--------------------------------------------------

-- ============================================================
-- Silver layer data load: users
-- ============================================================
-- Load customer profile data into the silver user dimension.
-- Basic string trimming is applied to standardize names, emails, and other text fields.
INSERT INTO silver.users (
    user_id,
    name,
    email,
    password,
    age,
    gender,
    marital_status,
    occupation,
    monthly_income,
    educational_qualifications,
    family_size
)
SELECT
    user_id,
    TRIM(name),
    TRIM(email),
    TRIM(password),
    age,
    TRIM(gender),
    TRIM(marital_status),
    TRIM(occupation),
    TRIM(monthly_income),
    TRIM(educational_qualifications),
    family_size
FROM bronze.users;

--------------------------------------------------------------

/*
    Summary:
    This silver layer script consolidates cleaned, business-ready data from bronze into the curated
    analytical tables used for reporting, exploratory analysis, and downstream modeling.
*/
