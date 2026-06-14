# 📦 Zepto E-commerce SQL Data Analyst Project

> **End-to-end SQL Data Analytics** on real quick-commerce inventory data using PostgreSQL — covering database design, data cleaning, EDA, and business insights.

---

## 📌 Project Overview

This is a complete, real-world **SQL Portfolio Project** built on an e-commerce inventory dataset scraped from **Zepto** — one of India's fastest-growing quick-commerce platforms. It simulates the end-to-end workflow a data analyst performs in an e-commerce or retail domain:

- Designing and creating a relational database
- Importing and exploring raw CSV data
- Cleaning messy, real-world data
- Answering business questions using SQL queries

**Tech Stack:** PostgreSQL · pgAdmin · SQL

---

## 📁 Folder Structure

```
zepto-sql-analysis/
│
│---zepto_v2.csv          # Raw dataset (source: Kaggle)
│
├── zepto_analysis_sql
│
└── README.md
```

---

## 📊 Dataset

- **Source:** [Kaggle – Zepto Inventory Dataset](https://www.kaggle.com/)
- **Records:** ~3,500+ SKUs scraped from Zepto's live product listings
- **Format:** CSV

| Column | Description |
|---|---|
| `sku_id` | Unique product identifier (auto-generated) |
| `category` | Product category (Dairy, Snacks, Beverages, etc.) |
| `name` | Product name |
| `mrp` | Maximum Retail Price (₹) |
| `discountPercent` | Discount percentage offered |
| `discountedSellingPrice` | Final price after discount (₹) |
| `availableQuantity` | Stock quantity available |
| `weightInGms` | Product weight in grams |
| `outOfStock` | Boolean — TRUE if out of stock |
| `quantity` | Units per package |

---

## 🔧 Project Workflow

### 1. Database & Table Creation

```sql
CREATE TABLE zepto (
  sku_id               SERIAL PRIMARY KEY,
  category             VARCHAR(120),
  name                 VARCHAR(150) NOT NULL,
  mrp                  NUMERIC(8,2),
  discountPercent      NUMERIC(5,2),
  availableQuantity    INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms          INTEGER,
  outOfStock           BOOLEAN,
  quantity             INTEGER
);
```

### 2. Data Import

Via pgAdmin GUI import, or via psql:

```sql
\copy zepto(category, name, mrp, discountPercent, availableQuantity,
            discountedSellingPrice, weightInGms, outOfStock, quantity)
FROM 'data/zepto_v2.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');
```

### 3. Data Exploration (EDA)

- Total record count
- Distinct product categories
- Null value analysis across all columns
- In-stock vs out-of-stock distribution
- Duplicate product name detection
- Sample data inspection

### 4. Data Cleaning

- Removed records with MRP = 0 or selling price = 0
- Converted paise values to rupees where applicable
- Standardized NULL handling

### 5. Business Insights

| # | Business Question |
|---|---|
| 1 | Which products have the highest discount percentage? |
| 2 | What are the high-MRP products that are currently out of stock? |
| 3 | What is the estimated revenue potential per category? |
| 4 | Which products are premium (high price, low discount)? |
| 5 | What is the average discount offered per category? |
| 6 | Which products offer the best value per gram? |
| 7 | How are products distributed by weight segment (light/medium/heavy)? |
| 8 | What is the total inventory weight per category? |

---

## 💡 Key Insights

- **Dairy & Beverages** categories have the highest number of out-of-stock premium products
- Some products have MRP stored in **paise** — data cleaning is critical before any price analysis
- **Top discounted products** (>60% off) are concentrated in the Snacks and Personal Care categories
- Revenue potential analysis shows **Staples** and **Beverages** as top categories by estimated GMV

---

## 🚀 How to Run

1. Install [PostgreSQL](https://www.postgresql.org/download/) and [pgAdmin](https://www.pgadmin.org/)
2. Create a new database: `zepto_db`
3. Run `sql/01_create_table.sql` to create the table
4. Import `data/zepto_v2.csv` using pgAdmin's import tool or the `\copy` command
5. Run scripts 02 → 03 → 04 in order

---

## 🎓 What I Learned

- Designing a normalized table schema for e-commerce catalog data
- Real-world data cleaning challenges (paise vs rupees, zero-value entries, duplicates)
- Writing analytical SQL with `GROUP BY`, `HAVING`, `ORDER BY`, `CASE WHEN`, and aggregate functions
- Translating business questions into SQL queries

---

## 📬 Connect

**Pragati** | B.S CS & Data analytics IIT Patna
[GitHub](https://github.com/pr23sa) · [LinkedIn](www.linkedin.com/in/pragatisahu01)

---

## 📜 License

MIT License — free to use and reference in your own portfolio.
