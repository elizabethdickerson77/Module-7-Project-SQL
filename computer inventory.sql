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

