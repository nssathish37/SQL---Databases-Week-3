CREATE TABLE Departments (
  dept_id INT PRIMARY KEY AUTO_INCREMENT,
  dept_name VARCHAR(100) NOT NULL
);
CREATE TABLE Employees (
  emp_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dept_id INT,
  salary DECIMAL(10,2),
  hire_date DATE,
  city VARCHAR(100),
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Customers (
  cust_id INT PRIMARY KEY AUTO_INCREMENT,
  cust_name VARCHAR(100),
  city VARCHAR(100),
  signup_date DATE
);
CREATE TABLE Products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(150),
  price DECIMAL(10,2)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  cust_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)
);
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
# INSERT
INSERT INTO Departments (dept_name) VALUES
('Sales'), ('HR'), ('Engineering'), ('Finance');
Select * from Departments

INSERT INTO Employees (first_name,last_name,dept_id,salary,hire_date,city) VALUES
('Amit','Kumar',1,75000,'2022-02-15','Mumbai'),
('Priya','Sharma',3,90000,'2021-11-05','Bengaluru'),
('Ravi','Patel',1,65000,'2023-03-20','Ahmedabad'),
('Anita','Verma',2,50000,'2020-06-01','Pune'),
('Sunil','Rao',4,120000,'2019-09-10','Chennai'),
('Maya','Iyer',3,85000,'2024-01-10','Bengaluru'),
('Karan','Singh',1,72000,'2020-12-01','Delhi'),
('Neha','Gupta',3,95000,'2022-08-08','Hyderabad'),
('Vikram','Das',4,110000,'2018-05-05','Mumbai'),
('Rina','Bose',2,48000,'2023-07-07','Kolkata');

Select * from Employees

INSERT INTO Customers (cust_name,city,signup_date) VALUES
('Alpha Traders','Mumbai','2021-01-15'),
('Beta Stores','Bengaluru','2022-07-20'),
('Gamma Retail','Delhi','2020-03-03'),
('Delta Supplies','Chennai','2023-02-11'),
('Epsilon Co.','Pune','2024-09-01'),
('Zeta Enterprises','Mumbai','2022-11-05'),
('Eta Mart','Ahmedabad','2021-12-25'),
('Theta Shop','Bengaluru','2023-05-30'),
('Iota Goods','Kolkata','2020-10-10'),
('Kappa Retail','Hyderabad','2024-04-18');
Select * from Customers

INSERT INTO Products (product_name,price) VALUES
('Laptop Pro 14',90000),
('Office Chair',8000),
('Wireless Mouse',1200),
('Keyboard Mechanical',3500),
('Monitor 24"',12000),
('Printer A4',7000),
('Router AC',3500),
('External HDD 1TB',4500),
('USB-C Cable',500),
('Webcam 1080p',3000);
Select * from Products

INSERT INTO Orders (cust_id,order_date,total_amount) VALUES
(1,'2024-10-01',93000),
(2,'2024-11-15',15500),
(3,'2024-12-01',9000);
Select * from Orders

INSERT INTO OrderItems (order_id,product_id,quantity,unit_price) VALUES
(1,1,1,90000),
(1,9,6,500),
(2,5,1,12000),
(2,3,3,1200),
(3,2,1,8000),
(3,10,1,3000);
Select * from OrderItems

SELECT first_name, last_name, salary FROM Employees;

SELECT * FROM Employees WHERE salary > 80000;
SELECT * FROM Customers WHERE city = 'Bengaluru';

SELECT first_name,last_name,salary FROM Employees ORDER BY salary DESC;

SELECT first_name,last_name,salary FROM Employees ORDER BY salary DESC LIMIT 5;

SELECT DISTINCT city FROM Customers;

SELECT city, COUNT(*) AS customer_count

SELECT c.cust_name, o.order_id, o.order_date, o.total_amount
FROM Customers c
INNER JOIN Orders o ON c.cust_id = o.cust_id;

SELECT c.cust_name, o.order_id

SELECT o.order_id, c.cust_name
FROM Orders o
RIGHT JOIN Customers c ON o.cust_id = c.cust_id;

FROM Customers c
LEFT JOIN Orders o ON c.cust_id = o.cust_id;


FROM Customers
GROUP BY city
HAVING COUNT(*) >= 2;

-- Postgres:
SELECT c.cust_name, o.order_id
FROM Customers c
FULL OUTER JOIN Orders o ON c.cust_id = o.cust_id;

-- MySQL simulation:
SELECT c.cust_name, o.order_id
FROM Customers c LEFT JOIN Orders o ON c.cust_id = o.cust_id
UNION
SELECT c.cust_name, o.order_id
FROM Orders o LEFT JOIN Customers c ON o.cust_id = c.cust_id;

SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

SELECT emp_id, first_name, last_name, salary

SELECT city, COUNT(*) AS customers_count
FROM Customers
GROUP BY city
ORDER BY customers_count DESC;

FROM Employees
ORDER BY salary DESC
LIMIT 5;

SELECT p.product_id, p.product_name,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;

SELECT emp_id, first_name, last_name, hire_date
FROM Employees
WHERE hire_date > '2022-01-01'
ORDER BY hire_date;

SELECT c.cust_id, c.cust_name, SUM(o.total_amount) AS total_spend
FROM Customers c
JOIN Orders o ON c.cust_id = o.cust_id
GROUP BY c.cust_id, c.cust_name
ORDER BY total_spend DESC
LIMIT 5;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS revenue
FROM Orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY month
ORDER BY month;

SELECT d.dept_name, AVG(e.salary) AS avg_salary, COUNT(e.emp_id) AS emp_count
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT p.product_id, p.product_name
FROM Products p
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

SELECT city, COUNT(*) AS employee_count
FROM Employees
GROUP BY city
ORDER BY employee_count DESC;

SELECT o.order_id, COUNT(DISTINCT oi.product_id) AS distinct_products
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING COUNT(DISTINCT oi.product_id) > 2;














