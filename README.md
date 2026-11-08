# Restaurant Sales Analysis Using Microsoft SQL Server

## Project Overview

This project demonstrates relational database design and SQL-based sales analysis using Microsoft SQL Server. It uses manually created sample restaurant data to explore customer activity, product performance, order trends, and revenue.

## Objectives

- Design a relational database with primary keys, foreign keys, and CHECK constraints.
- Store customer, product, order, and order-item information.
- Analyze sales using SQL queries and aggregate functions.
- Practice joins, subqueries, CTEs, and window functions.
- Work with date, string, and JSON functions.
- Implement stored procedures and basic error handling.

## Database Structure

| Table | Description |
|---|---|
| `Customers` | Customer details |
| `Products` | Product names, categories, and prices |
| `Orders` | Customer orders, dates, and statuses |
| `OrderItems` | Products, quantities, and prices for each order |

## SQL Concepts Covered

- Database and table creation
- Primary keys, foreign keys, and CHECK constraints
- INSERT and SELECT statements
- INNER JOIN and LEFT JOIN
- GROUP BY, HAVING, and aggregate functions
- CASE expressions
- Subqueries and Common Table Expressions (CTEs)
- ROW_NUMBER(), RANK(), and DENSE_RANK()
- Window functions and running totals
- Date and string functions
- JSON_VALUE(), JSON_QUERY(), and OPENJSON()
- Stored procedures and output parameters
- TRY...CATCH error handling

## Project Structure

```text
restaurant-sales-analysis-sql-server/
├── sql/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_sample_data.sql
│   ├── 04_basic_sales_queries.sql
│   ├── 05_customer_product_category_analysis.sql
│   ├── 06_subqueries_and_ctes.sql
│   ├── 07_window_functions.sql
│   ├── 08_additional_sales_queries.sql
│   ├── 09_date_and_string_functions.sql
│   ├── 10_json_queries.sql
│   └── 11_stored_procedures_and_error_handling.sql
├── README.md
└── .gitignore
```

## Tools

- Microsoft SQL Server 2025 Developer Edition
- SQL Server Management Studio (SSMS) 22
- Transact-SQL (T-SQL)

## How to Run

1. Install Microsoft SQL Server and SQL Server Management Studio.
2. Open the scripts in the `sql` folder using SSMS.
3. Execute the scripts in numerical order, starting with `01_create_database.sql`.
4. Run the analysis scripts after the tables and sample data have been created.

**Important:** The setup scripts are intended for a fresh database. Do not run the entire setup sequence again against an already populated database, because database/table creation and INSERT statements can fail or duplicate data. The analysis scripts can be run independently after setup.

## Dataset

The project uses manually created sample data for demonstration and SQL practice. It is not real restaurant business data.

## Project Status

Completed as a SQL Server learning and portfolio project.
