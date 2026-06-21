-- ============================================
-- Computer Inventory Database
-- ============================================

CREATE DATABASE IF NOT EXISTS ComputerInventory;
USE ComputerInventory;

-- ============================================
-- TABLE: Computer
-- ============================================
CREATE TABLE Computer (
    ComputerID INT AUTO_INCREMENT PRIMARY KEY,
    Manufacturer VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    SerialNumber VARCHAR(50) NOT NULL UNIQUE,
    PurchaseDate DATE,
    WarrantyExpiry DATE,
    Status ENUM('Active', 'Inactive', 'Repair') DEFAULT 'Active'
);

-- ============================================
-- TABLE: AppUser
-- ============================================
-- Changed name to 'AppUser' because 'User' is a reserved keyword in most SQL dialects
CREATE TABLE AppUser (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20)
);

-- ============================================
-- TABLE: Location
-- ============================================
CREATE TABLE Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    Building VARCHAR(50) NOT NULL,
    RoomNumber VARCHAR(20),
    Floor VARCHAR(10)
);

-- ============================================
-- TABLE: Assignment
-- ============================================
CREATE TABLE Assignment (
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    ComputerID INT NOT NULL,
    UserID INT NOT NULL,
    AssignmentDate DATE NOT NULL,
    FOREIGN KEY (ComputerID) REFERENCES Computer(ComputerID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (UserID) REFERENCES AppUser(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ============================================
-- TABLE: UserLocation
-- ============================================
-- Completed the dangling statement and added foreign key relationships
CREATE TABLE UserLocation (
    UserLocationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    LocationID INT NOT NULL,
    UserLocationDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES AppUser(UserID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ============================================
-- DATA POPULATION
-- ============================================

-- Computer
INSERT INTO Computer (Manufacturer, Model, SerialNumber, PurchaseDate, WarrantyExpiry, Status)
VALUES
('Dell', 'Latitude 5430', 'SN-DL5430-001', '2023-01-15', '2026-01-15', 'Active'),
('HP', 'EliteBook 840', 'SN-HP840-002', '2022-06-10', '2025-06-10', 'Active'),
('Lenovo', 'ThinkPad T14', 'SN-LN-T14-003', '2021-11-20', '2024-11-20', 'Repair'),
('Apple', 'MacBook Pro 14', 'SN-AP-MBP14-004', '2023-09-01', '2026-09-01', 'Active'),
('Dell', 'OptiPlex 7090', 'SN-DL7090-005', '2020-03-05', '2023-03-05', 'Inactive');

-- AppUser (FIXED: Table name corrected from 'User' to 'AppUser')
INSERT INTO AppUser (FirstName, LastName, Department, Email, Phone)
VALUES
('Liz', 'Carter', 'IT', 'liz.carter@company.com', '555-0101'),
('John', 'Smith', 'Finance', 'john.smith@company.com', '555-0102'),
('Maria', 'Gonzalez', 'HR', 'maria.gonzalez@company.com', '555-0103'),
('David', 'Lee', 'Marketing', 'david.lee@company.com', '555-0104'),
('Sarah', 'Johnson', 'IT', 'sarah.johnson@company.com', '555-0105');

-- Location
INSERT INTO Location (Building, RoomNumber, Floor)
VALUES
('Main Building', '101', '1'),
('Main Building', '202', '2'),
('Annex', '305', '3'),
('Annex', '110', '1'),
('Warehouse', 'W-01', 'Ground');

-- Assignment (links Computer to User)
INSERT INTO Assignment (ComputerID, UserID, AssignmentDate)
VALUES
(1, 1, '2023-01-20'),
(2, 2, '2022-06-15'),
(3, 3, '2021-12-01'),
(4, 4, '2023-09-05'),
(5, 5, '2020-03-10');

-- UserLocation (links User to Location)
INSERT INTO UserLocation (UserID, LocationID, UserLocationDate)
VALUES
(1, 1, '2023-01-20'),
(2, 2, '2022-06-15'),
(3, 3, '2021-12-01'),
(4, 4, '2023-09-05'),
(5, 5, '2020-03-10');


