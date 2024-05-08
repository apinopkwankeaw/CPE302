CREATE DATABASE  exchange_db;
USE exchange_db;

CREATE TABLE  User (
    User_ID VARCHAR(6) PRIMARY KEY,
    Username VARCHAR(20) UNIQUE,
    Email VARCHAR(50) UNIQUE,
    Password VARCHAR(20) CHECK (CHAR_LENGTH(Password) BETWEEN 8 AND 20)
);

INSERT INTO User (User_ID, Username, Email, Password) VALUES
('A00001', 'Apinop2546', 'apinop2546@gmail.com', 'A123456789'),
('A00002', 'Nopparoot', 'nopparoot@example.com', 'B987654321');

CREATE TABLE  Item (
    Item_ID VARCHAR(6) PRIMARY KEY,
    Item_Name VARCHAR(20),
    Description TEXT,
    Date DATETIME,
    Quantity INT
);
INSERT INTO Item (Item_ID, Item_Name, Description, Date, Quantity) VALUES
('B001', 'Book', 'หนังสือการ์ตูน', '2013-10-23', 30),
('B002', 'Laptop', 'โน้ตบุ๊ค', '2015-05-12', 10);

CREATE TABLE  Exchange (
    Exchange_ID VARCHAR(50) PRIMARY KEY,
    Requester_ID VARCHAR(20),
    Responder_ID VARCHAR(20),
    Item_ID VARCHAR(6),
    Exchange_date DATETIME,
    Status VARCHAR(9),
    Contact TEXT,
    FOREIGN KEY (Requester_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Responder_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
);
INSERT INTO Exchange (Exchange_ID, Requester_ID, Responder_ID, Item_ID, Exchange_date, Status, Contact) VALUES
('Ex001', 'A00001', 'A00002', 'B001', '2013-10-23', 'Completed', 'IG'),
('Ex002', 'A00002', 'A00001', 'B002', '2015-05-12', 'Pending', 'Facebook');

CREATE TABLE  Donating_Money (
    Donating_ID VARCHAR(6) PRIMARY KEY,
    User_ID VARCHAR(6),
    Description TEXT,
    Amount INT,
    Donating_date DATETIME,
    Status VARCHAR(9),
    Contact VARCHAR(10),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);
INSERT INTO Donating_Money (Donating_ID, User_ID, Description, Amount, Donating_date, Status, Contact) VALUES
('DN0001', 'A00001', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 200, '2013-10-23', 'Completed', '1234567890'),
('DN0002', 'A00002', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 300, '2015-05-12', 'Pending', '0987654321');


CREATE TABLE  Donate (
    Donating_ID VARCHAR(6),
    User_ID VARCHAR(6),
    Products_ID VARCHAR(6),
    Quantity INT,
    Donating_date DATETIME,
    Status VARCHAR(9),
    Contact VARCHAR(10),
    PRIMARY KEY (Donating_ID, User_ID),
    FOREIGN KEY (User_ID) REFERENCES User(User_ID),
    FOREIGN KEY (Products_ID) REFERENCES Item(Item_ID)
);
INSERT INTO Donate (Donating_ID, User_ID, Products_ID, Quantity, Donating_date, Status, Contact) VALUES
('DN0001', 'A00001', 'B001', 1, '2013-10-23', 'Error', '1234567890'),
('DN0002', 'A00002', 'B002', 2, '2015-05-12', 'Completed', '0987654321');



--INSERT TABLE
-- Inserting 5 more records into the User table
INSERT INTO User (User_ID, Username, Email, Password) VALUES
('A00003', 'JohnDoe', 'john.doe@example.com', 'C123456789'),
('A00004', 'JaneDoe', 'jane.doe@example.com', 'D987654321'),
('A00005', 'AliceSmith', 'alice.smith@example.com', 'Eabcdef123'),
('A00006', 'BobJohnson', 'bob.johnson@example.com', 'F654321abcdef'),
('A00007', 'EmmaDavis', 'emma.davis@example.com', 'Ghijkl987654');

-- Inserting 5 more records into the Item table
INSERT INTO Item (Item_ID, Item_Name, Description, Date, Quantity) VALUES
('B003', 'Phone', 'โทรศัพท์มือถือ', '2018-08-15', 20),
('B004', 'Tablet', 'แท็บเล็ต', '2020-01-30', 15),
('B005', 'Chair', 'เก้าอี้', '2019-05-20', 50),
('B006', 'Desk', 'โต๊ะทำงาน', '2021-07-10', 25),
('B007', 'Printer', 'เครื่องพิมพ์', '2017-03-05', 10);

-- Inserting 5 more records into the Exchange table
INSERT INTO Exchange (Exchange_ID, Requester_ID, Responder_ID, Item_ID, Exchange_date, Status, Contact) VALUES
('Ex003', 'A00003', 'A00005', 'B003', '2018-08-15', 'Completed', 'Line'),
('Ex004', 'A00004', 'A00006', 'B004', '2020-01-30', 'Pending', 'WhatsApp'),
('Ex005', 'A00005', 'A00007', 'B005', '2019-05-20', 'Completed', 'Telegram'),
('Ex006', 'A00006', 'A00003', 'B006', '2021-07-10', 'Pending', 'Email'),
('Ex007', 'A00007', 'A00004', 'B007', '2017-03-05', 'Completed', 'Phone');

-- Inserting 5 more records into the Donating_Money table
INSERT INTO Donating_Money (Donating_ID, User_ID, Description, Amount, Donating_date, Status, Contact) VALUES
('DN0003', 'A00003', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 150, '2018-08-15', 'Completed', '1234509876'),
('DN0004', 'A00004', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 250, '2020-01-30', 'Pending', '0987612345'),
('DN0005', 'A00005', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 350, '2019-05-20', 'Completed', '9876543210'),
('DN0006', 'A00006', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 450, '2021-07-10', 'Pending', '0123456789'),
('DN0007', 'A00007', 'เลขบัญชี,รายระเอียดการบริจากเงิน', 550, '2017-03-05', 'Completed', '9876543210');

-- Inserting 5 more records into the Donate table
INSERT INTO Donate (Donating_ID, User_ID, Products_ID, Quantity, Donating_date, Status, Contact) VALUES
('DN0003', 'A00003', 'B003', 2, '2018-08-15', 'Completed', '1234509876'),
('DN0004', 'A00004', 'B004', 1, '2020-01-30', 'Error', '0987612345'),
('DN0005', 'A00005', 'B005', 3, '2019-05-20', 'Pending', '9876543210'),
('DN0006', 'A00006', 'B006', 2, '2021-07-10', 'Completed', '0123456789'),
('DN0007', 'A00007', 'B007', 1, '2017-03-05', 'Error', '9876543210');
