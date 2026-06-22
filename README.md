# E-Commerce Sales Analytics Engineering Pipeline

An end-to-end analytics engineering project using **dbt Core**, **PostgreSQL**, and **Power BI** to transform raw e-commerce data into clean, tested, documented, and dashboard-ready data marts.

---

## Project Overview

This project simulates a real-world e-commerce analytics workflow. Raw transactional data is loaded into PostgreSQL, transformed using dbt, tested for data quality, documented through dbt Docs, and prepared for visualization in Power BI.

The main goal of this project is to demonstrate how raw business data can be transformed into reliable analytics-ready tables for business reporting and decision-making.

---

## Tech Stack

| Tool         | Purpose                                                  |
| ------------ | -------------------------------------------------------- |
| PostgreSQL   | Database for raw and transformed data                    |
| dbt Core     | Data transformation, testing, documentation, and lineage |
| dbt-postgres | Adapter to connect dbt with PostgreSQL                   |
| SQL          | Main transformation language                             |
| Power BI     | Dashboard and business visualization                     |
| pgAdmin      | PostgreSQL database management                           |
| GitHub       | Version control and portfolio publishing                 |

---

## Business Questions

This project is designed to answer several business questions:

* How much net revenue was generated each month?
* Which product categories contributed the most revenue?
* Which products generated the highest sales and estimated profit?
* How are customers segmented based on order behavior?
* Which cities have the highest customer distribution?
* How much refund occurred and how does it affect net revenue?

---

## Project Workflow

```text
Raw CSV Data
   ↓
dbt seed
   ↓
PostgreSQL Raw Tables
   ↓
dbt Staging Models
   ↓
dbt Intermediate Models
   ↓
dbt Marts Models
   ↓
dbt Tests
   ↓
dbt Docs and Lineage
   ↓
Power BI Dashboard
```

---

## Dataset

The project uses dummy e-commerce data stored as CSV files in the `seeds/` folder.

| File                  | Description              |
| --------------------- | ------------------------ |
| `raw_customers.csv`   | Customer profile data    |
| `raw_products.csv`    | Product master data      |
| `raw_orders.csv`      | Order transaction data   |
| `raw_order_items.csv` | Order item detail data   |
| `raw_payments.csv`    | Payment transaction data |
| `raw_refunds.csv`     | Refund transaction data  |

---

## Project Structure

```text
dbt_ecommerce/
│
├── models/
│   ├── staging/
│   │   ├── sources.yml
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   ├── stg_payments.sql
│   │   └── stg_refunds.sql
│   │
│   ├── intermediate/
│   │   ├── int_order_revenue.sql
│   │   ├── int_order_refunds.sql
│   │   ├── int_order_payments.sql
│   │   └── int_customer_order_summary.sql
│   │
│   ├── marts/
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   ├── fct_sales.sql
│   │   ├── mart_monthly_revenue.sql
│   │   ├── mart_product_performance.sql
│   │   └── mart_customer_segments.sql
│   │
│   └── schema.yml
│
├── seeds/
│   ├── raw_customers.csv
│   ├── raw_products.csv
│   ├── raw_orders.csv
│   ├── raw_order_items.csv
│   ├── raw_payments.csv
│   └── raw_refunds.csv
│
├── dbt_project.yml
└── README.md
```

---

## Data Modeling Layers

This project follows a layered analytics engineering approach:

```text
Raw → Staging → Intermediate → Marts
```

### Raw Layer

Raw data is loaded from CSV files into PostgreSQL using `dbt seed`.

Raw tables:

```text
public.raw_customers
public.raw_products
public.raw_orders
public.raw_order_items
public.raw_payments
public.raw_refunds
```

---

### Staging Layer

The staging layer cleans and standardizes raw data.

Staging models:

```text
public_staging.stg_customers
public_staging.stg_products
public_staging.stg_orders
public_staging.stg_order_items
public_staging.stg_payments
public_staging.stg_refunds
```

Main transformations:

* Standardizing order and payment status
* Casting date and numeric fields
* Lowercasing email values
* Filtering invalid IDs
* Preparing clean source models for downstream transformations

---

### Intermediate Layer

The intermediate layer contains reusable business logic before building final marts.

Intermediate models:

```text
public_intermediate.int_order_revenue
public_intermediate.int_order_refunds
public_intermediate.int_order_payments
public_intermediate.int_customer_order_summary
```

Examples of logic:

* Calculating gross revenue per order
* Calculating refund amount per order
* Summarizing payment information per order
* Summarizing customer order activity

---

### Marts Layer

The marts layer contains final analytics-ready tables for dashboarding.

Marts models:

```text
public_marts.dim_customers
public_marts.dim_products
public_marts.fct_sales
public_marts.mart_monthly_revenue
public_marts.mart_product_performance
public_marts.mart_customer_segments
```

| Model                      | Type      | Description                           |
| -------------------------- | --------- | ------------------------------------- |
| `dim_customers`            | Dimension | Customer profile and customer segment |
| `dim_products`             | Dimension | Product master data                   |
| `fct_sales`                | Fact      | Main sales transaction table          |
| `mart_monthly_revenue`     | Mart      | Monthly revenue summary               |
| `mart_product_performance` | Mart      | Product-level performance summary     |
| `mart_customer_segments`   | Mart      | Customer segment summary              |

---

## Key Metrics

| Metric                 | Description                               |
| ---------------------- | ----------------------------------------- |
| Gross Revenue          | Revenue before refund deduction           |
| Refund Amount          | Total refund value                        |
| Net Revenue            | Gross revenue minus refund amount         |
| Total Orders           | Number of completed orders                |
| Total Customers        | Number of unique customers                |
| Average Order Value    | Net revenue divided by total orders       |
| Total Quantity Sold    | Number of products sold                   |
| Estimated Gross Profit | Estimated revenue after product cost      |
| Customer Segment       | Customer category based on order behavior |

Main formula:

```text
Net Revenue = Gross Revenue - Refund Amount
```

---

## dbt Tests

Data quality tests are defined in `models/schema.yml`.

The project uses the following generic tests:

| Test              | Purpose                                |
| ----------------- | -------------------------------------- |
| `not_null`        | Ensures important fields are not empty |
| `unique`          | Ensures ID fields are not duplicated   |
| `accepted_values` | Ensures categorical values are valid   |

Example:

```yaml
- name: order_id
  tests:
    - not_null
    - unique
```

Example accepted values test:

```yaml
- name: order_status
  tests:
    - accepted_values:
        values: ['completed', 'cancelled', 'pending', 'unknown']
```

Run tests:

```bash
dbt test
```

---

## dbt Commands

### Check dbt Configuration

```bash
dbt debug
```

Used to validate the dbt project configuration and PostgreSQL connection.

### Load CSV Files into PostgreSQL

```bash
dbt seed
```

Used to load CSV files from the `seeds/` folder into PostgreSQL.

### Run dbt Models

```bash
dbt run
```

Used to execute SQL models and build views or tables in PostgreSQL.

### Run Data Tests

```bash
dbt test
```

Used to validate data quality.

### Generate dbt Documentation

```bash
dbt docs generate
```

Used to generate dbt documentation and lineage.

### Serve dbt Documentation

```bash
dbt docs serve
```

Used to open dbt documentation locally in the browser.

---

## How to Run This Project

### 1. Clone Repository

```bash
git clone https://github.com/your-username/dbt-ecommerce-analytics.git
cd dbt-ecommerce-analytics
```

### 2. Install dbt PostgreSQL Adapter

```bash
python -m pip install dbt-postgres
```

### 3. Configure PostgreSQL Profile

Create or update this file:

```text
C:\Users\YOUR_USERNAME\.dbt\profiles.yml
```

Example configuration:

```yaml
dbt_ecommerce:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: postgres
      password: your_postgres_password
      port: 5432
      dbname: ecommerce_analytics
      schema: public
      threads: 4
```

### 4. Run dbt Pipeline

```bash
dbt debug
dbt seed
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

## Power BI Dashboard

The final dashboard contains three main pages:

### 1. Executive Summary

A high-level overview of revenue, orders, customers, product category contribution, and customer segments.

Main visuals:

* Total Net Revenue
* Total Gross Revenue
* Total Orders
* Total Customers
* Average Order Value
* Net Revenue Trend by Month
* Revenue by Product Category
* Customer Segment
* Key Business Insight

### 2. Product Performance

Product revenue, sales volume, and profitability overview.

Main visuals:

* Gross Revenue by Product
* Total Quantity Sold by Product
* Revenue by Category
* Estimated Gross Profit by Product
* Product Performance Table

### 3. Customer Analysis

Customer segments, city distribution, and order activity insights.

Main visuals:

* Total Customers
* New Customers
* Repeat Customers
* Loyal Customers
* Total Customers by Segment
* Customers by City
* Total Orders by Customer
* Customer Detail Table

---

## Key Insights

Some example insights generated from this project:

* Net revenue is calculated after deducting refunds from gross revenue.
* Product category contribution helps identify which categories generate the most revenue.
* Customer segmentation helps identify new, repeat, loyal, and inactive customers.
* Monthly revenue trends help monitor sales performance over time.
* Refund analysis is important because refund amount directly affects net revenue.

---

## What This Project Demonstrates

This project demonstrates practical skills in:

* SQL transformation
* dbt project structure
* PostgreSQL analytics workflow
* Data modeling
* Staging, intermediate, and marts layer design
* Fact and dimension table design
* Data quality testing
* Source configuration
* dbt documentation
* Data lineage
* Power BI dashboard preparation
* End-to-end analytics engineering workflow

---

## Future Improvements

Possible future improvements:

* Add `fct_order_items` for more detailed product-level transaction analysis
* Add a date dimension table
* Add customer lifetime value metrics
* Add payment method analysis
* Add refund rate by product category
* Add incremental models
* Add snapshots for tracking customer segment changes over time
* Deploy the project using BigQuery or Snowflake
* Add GitHub Actions for automated `dbt run` and `dbt test`

---

## Project Summary

This project successfully builds an end-to-end e-commerce analytics engineering pipeline using dbt and PostgreSQL.

Raw e-commerce data is loaded into PostgreSQL, transformed into staging and intermediate models, modeled into analytics-ready marts, tested for data quality, documented with dbt Docs, and prepared for Power BI dashboard development.

The final output is a clean and structured analytics layer that supports business reporting on revenue, product performance, customer segmentation, and sales activity.
