# 🧠 User-Account-Management-Database-DDD

This MySQL project was developed for the **Database Design & Development (DDD)** module.  
It demonstrates how to build and manage a simple user-management system using **SQL**, including tables, joins, group functions, stored procedures, and triggers.

---

## 📘 Project Overview
The database models a small user management structure used in an organization.  
It contains different user types (customers, admins) and tracks their departments.

---

## 🧩 Database Tables

### 1. `Users`
Stores login credentials for each system user.
| Column | Type | Description |
|---------|------|-------------|
| user_id | INT (PK, AUTO_INCREMENT) | Unique identifier |
| username | VARCHAR(100) | Login name |
| password | VARCHAR(255) | Encrypted password |

---

### 2. `Admin`
Defines admin roles and sub-categories.
| Column | Type | Description |
|---------|------|-------------|
| admin_id | INT (PK, AUTO_INCREMENT) | Unique admin ID |
| user_id | INT (FK → Users.user_id) | Link to the user |
| subrole | VARCHAR(50) | e.g. PolicyAdmin, ITAdmin |

---

### 3. `Customer`
Holds customer personal details.
| Column | Type | Description |
|---------|------|-------------|
| user_id | INT (PK, FK → Users.user_id) | Link to the user |
| full_name | VARCHAR(100) | Customer name |
| address | VARCHAR(200) | City or residence |
| occupation | VARCHAR(100) | Job title |
| birth_date | DATE | Date of birth |

---

### 4. `General_Admin`
Links users to multiple departments.
| Column | Type | Description |
|---------|------|-------------|
| general_admin_id | INT (PK, AUTO_INCREMENT) | Record ID |
| user_id | INT (FK → Users.user_id) | Related user |
| department | VARCHAR(100) | Department name |

---

## 🔗 Relationships
- `Users` → `Customer`: 1-to-1  
- `Users` → `Admin`: 1-to-1  
- `Users` → `General_Admin`: 1-to-many  

All tables connect using the **user_id** field.

---

## ⚙️ Key Features

### ✅ Table creation and relationships
```sql
CREATE TABLE Users (...);
CREATE TABLE Customer (... FOREIGN KEY (user_id) REFERENCES Users(user_id));
