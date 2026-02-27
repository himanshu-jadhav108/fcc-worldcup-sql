# World Cup Database — PostgreSQL Project

This project is part of the freeCodeCamp Relational Database certification.

It builds a relational database to store and analyze World Cup knockout stage matches using PostgreSQL, Bash scripting, and SQL queries.

---

## 📌 Project Overview

The dataset (`games.csv`) contains match information from the final three rounds of the FIFA World Cup tournaments (2014 and 2018).

This project demonstrates:

- Database schema design
- Data normalization with foreign keys
- ETL pipeline using Bash
- Analytical SQL queries

---

## 🛠 Tech Stack

- PostgreSQL
- Bash
- SQL
- CSV data processing

---

## 🗄 Database Design

### **teams table**
- `team_id` (SERIAL, Primary Key)
- `name` (UNIQUE, NOT NULL)

### **games table**
- `game_id` (SERIAL, Primary Key)
- `year`
- `round`
- `winner_id` (Foreign Key → teams)
- `opponent_id` (Foreign Key → teams)
- `winner_goals`
- `opponent_goals`

The schema follows normalization principles by separating teams and match results.

---

## ⚙️ ETL Pipeline

The `insert_data.sh` script:

1. Reads the CSV file
2. Inserts unique teams
3. Maps team IDs
4. Inserts match records into the games table

This simulates a basic data ingestion pipeline.

---

## 📊 Example Queries

The `queries.sh` script extracts insights such as:

- Total and average goals
- Highest scoring matches
- Tournament champions
- Teams participating in specific rounds
- Winning team trends

---

## 🚀 How to Run

### Create database and load data

```bash
psql -U postgres < worldcup.sql
