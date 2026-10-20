CREATE OR ALTER PROCEDURE bronze.bronze_stpr AS
BEGIN
    -- ===============================================
    -- Bronze layer ingestion procedure
    -- Purpose: Loads raw source CSV files into the bronze tables
    -- Notes:
    -- 1. Each table is truncated before loading to ensure a fresh snapshot.
    -- 2. CSV files are loaded with standard settings for quoted fields and UTF-8 data.
    -- 3. FIRSTROW = 2 skips header rows in the raw source files.
    -- ===============================================

    PRINT '======================';
    PRINT ' LOADING BRONZE LAYER';
    PRINT '======================';

    ----------------------------------------------------------------
    -- Load order_items raw data into bronze layer
    ----------------------------------------------------------------
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

    ----------------------------------------------------------------
    -- Load orders raw data into bronze layer
    ----------------------------------------------------------------
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

    ----------------------------------------------------------------
    -- Load reviews raw data into bronze layer
    ----------------------------------------------------------------
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

    ----------------------------------------------------------------
    -- Load menu raw data into bronze layer
    -- UTF-8 encoded source files require CODEPAGE = '65001'
    ----------------------------------------------------------------
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
    -- Load users raw data into bronze layer
    -- UTF-8 encoded source files require CODEPAGE = '65001'
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

    ----------------------------------------------------------------
    -- Load restaurants raw data into bronze layer
    -- UTF-8 encoded source files require CODEPAGE = '65001'
    ----------------------------------------------------------------
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
    -- Load food_items raw data into bronze layer
    -- UTF-8 encoded source files require CODEPAGE = '65001'
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
    PRINT 'BRONZE LAYER LOAD COMPLETED';
END
