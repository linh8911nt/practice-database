CREATE DATABASE practice_csdl;

USE practice_csdl;

CREATE TABLE customers(
	customerNumber INT NOT NULL AUTO_INCREMENT,
    customerName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    country VARCHAR(50) NOT NULL,
    creditLimit FLOAT,
    salesRepEmployeeNumber INT NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (customerNumber)
);

ALTER TABLE customers
    ADD CONSTRAINT customers_to_employees_fk FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber);


CREATE TABLE orders(
	orderNumber INT NOT NULL AUTO_INCREMENT,
    orderDate DATETIME NOT NULL,
    requiredDate DATETIME NOT NULL,
    shippedDate DATETIME,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT NOT NULL,
    CONSTRAINT orders_pk PRIMARY KEY (orderNumber)
);

ALTER TABLE orders
    ADD CONSTRAINT orders_to_customers_fk FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber);


CREATE TABLE payments(
	customerNumber INT NOT NULL,
    checkNumber VARCHAR(50) NOT NULL,
    paymentDate DATETIME NOT NULL,
    amount FLOAT NOT NULL,
    CONSTRAINT payments_pk PRIMARY KEY (customerNumber)
);

ALTER TABLE payments
    ADD CONSTRAINT payments_to_customers_fk FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber);


CREATE TABLE orderdetails(
	orderNumber INT NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT NOT NULL,
	priceEach FLOAT NOT NULL,
    orderLineNumber TEXT,
    CONSTRAINT orderdetails_to_orders_fk FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    CONSTRAINT orderdetails_to_products_fk FOREIGN KEY (productCode) REFERENCES products(productCode)
);

CREATE TABLE products(
	productCode VARCHAR(15) NOT NULL,
    productName VARCHAR(70) NOT NULL,
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock INT NOT NULL,
    buyPrice FLOAT NOT NULL,
    MSRP FLOAT NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    CONSTRAINT products_pk PRIMARY KEY (productCode)
);

ALTER TABLE products
    ADD CONSTRAINT products_to_productlines_fk FOREIGN KEY (productLine) REFERENCES productlines(productLine);


CREATE TABLE productlines(
	productLine VARCHAR(50) NOT NULL,
    textDescription TEXT,
    image TEXT,
    CONSTRAINT productlines_pk PRIMARY KEY (productLine)
);

CREATE TABLE employees(
	employeeNumber INT NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    jobTitle VARCHAR(50) NOT NULL,
    reportTo INT NOT NULL,
    officeCode VARCHAR(10) NOT NULL,
    CONSTRAINT emplyees_pk PRIMARY KEY (employeeNumber)
);

ALTER TABLE employees
    ADD CONSTRAINT employees_fk FOREIGN KEY (reportTo) REFERENCES employees(employeeNumber);
ALTER TABLE employees
    ADD CONSTRAINT employees_to_offices_fk FOREIGN KEY (officeCode) REFERENCES offices(officeCode);

CREATE TABLE offices(
	officeCode VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    CONSTRAINT offices_pk PRIMARY KEY (officeCode)
);

