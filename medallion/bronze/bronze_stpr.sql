CREATE OR ALTER PROCEDURE bronze.bronze_stpr AS
BEGIN
PRINT '======================';
PRINT ' LOADING BRONZE LAYER';
PRINT '======================';
    TRUNCATE TABLE bronze.order_items;
    BULK INSERT bronze.order_items
    FROM 'C:\Users\PK\Downloads\zomato-data\data\order_items.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );
    ---------------------------------------------------------------
    TRUNCATE TABLE bronze.orders;
    BULK INSERT bronze.orders
    FROM 'C:\Users\PK\Downloads\zomato-data\data\orders.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );
    -----------------------------------------------------------------
    TRUNCATE TABLE bronze.reviews;
    BULK INSERT bronze.reviews
    FROM 'C:\Users\PK\Downloads\zomato-data\data\reviews.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK
    );
    ---------------------------------------------------------------
    TRUNCATE TABLE bronze.menu;
    BULK INSERT bronze.menu
    FROM 'C:\Users\PK\Downloads\zomato-data\data\menu.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK,
        CODEPAGE = '65001'
    );
    ----------------------------------------------------------------
    TRUNCATE TABLE bronze.users;
    BULK INSERT bronze.users
    FROM 'C:\Users\PK\Downloads\zomato-data\data\users.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK,
        CODEPAGE = '65001'
    );
    ------------------------------------------------------------------
    TRUNCATE TABLE bronze.restaurants;
    BULK INSERT bronze.restaurants
    FROM 'C:\Users\PK\Downloads\zomato-data\data\restaurant.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK,
        CODEPAGE = '65001'
    );
    ----------------------------------------------------------------
    TRUNCATE TABLE bronze.food_items;
    BULK INSERT bronze.food_items
    FROM 'C:\Users\PK\Downloads\zomato-data\data\food.csv'
    WITH (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '0x0a',
        TABLOCK,
        CODEPAGE = '65001'
    );
    ----------------------------------------------------------------
END