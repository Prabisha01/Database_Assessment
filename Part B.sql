-- =============================================
-- Assignment Part B: SQL Programming
-- Module: Data Management Systems
-- Student Name: Abishek Bimali, Basanta Adhikari, Prabisha Khadka
-- =============================================

-- =============================================
-- SECTION 1: CREATE TABLES WITH PK & FK CONSTRAINTS
-- =============================================

-- Create USERS table
CREATE TABLE Users (
    userId VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(50),
    emailAddress VARCHAR2(100)
);

-- Create CATEGORY table
CREATE TABLE Category (
    categoryCode VARCHAR2(10) PRIMARY KEY,
    title VARCHAR2(50)
);

-- Create MUSIC table with FK to CATEGORY
CREATE TABLE Music (
    musicId VARCHAR2(10) PRIMARY KEY,
    title VARCHAR2(100),
    categoryCode VARCHAR2(10),
    costPerDownload NUMBER(5,2),
    CONSTRAINT fk_music_category FOREIGN KEY (categoryCode)
        REFERENCES Category(categoryCode)
);

-- Create DOWNLOADMUSIC table with FK to USERS and MUSIC
CREATE TABLE DownloadMusic (
    userId VARCHAR2(20),
    musicId VARCHAR2(10),
    downloadDate DATE,
    PRIMARY KEY (userId, musicId, downloadDate),
    CONSTRAINT fk_download_user FOREIGN KEY (userId)
        REFERENCES Users(userId),
    CONSTRAINT fk_download_music FOREIGN KEY (musicId)
        REFERENCES Music(musicId)
);

-- =============================================
-- SECTION 2: INSERT GIVEN DATA INTO TABLES
-- =============================================

-- Insert into USERS
SET SERVEROUTPUT ON;

-- Insert USERS data
BEGIN
    INSERT INTO Users VALUES ('wayne10', 'Wayne, R', 'wayne@hotmail.co.uk');
    INSERT INTO Users VALUES ('santos17', 'Santos, C', 'santos@ntl.co.uk');
    INSERT INTO Users VALUES ('hary05', 'Hary, M', 'hary@freeserve.co.uk');
    INSERT INTO Users VALUES ('margot9', 'Margot, C', 'margot9@msn.co.uk');
    INSERT INTO Users VALUES ('mount77', 'Mount, M', 'mount@hotmail.co.uk');
    INSERT INTO Users VALUES ('nancy91', 'Nancy, L', 'nancy91@tesco.co.uk');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Users data inserted successfully.');
END;
/


-- Insert into CATEGORY
BEGIN
    INSERT INTO Category VALUES ('MO11', 'Love');
    INSERT INTO Category VALUES ('MO12', 'Pop');
    INSERT INTO Category VALUES ('MO13', 'Rock');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Category data inserted successfully.');
END;
/

-- Insert into MUSIC
BEGIN
    INSERT INTO Music VALUES ('M001', 'Born to run', 'MO13', 0.99);
    INSERT INTO Music VALUES ('M002', 'Crawling', 'MO13', 1.99);
    INSERT INTO Music VALUES ('M003', 'You’re Beautiful', 'MO11', 1.49);
    INSERT INTO Music VALUES ('M004', 'Summer of 69', 'MO11', 1.79);
    INSERT INTO Music VALUES ('M005', 'Crazy Train', 'MO13', 1.50);
    INSERT INTO Music VALUES ('M006', 'Yellow Submarine', 'MO12', 1.10);
    INSERT INTO Music VALUES ('M007', 'Got to be there', 'MO12', 0.89);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Music data inserted successfully.');
END;
/
-- Insert into DOWNLOADMUSIC
BEGIN
    INSERT INTO DownloadMusic VALUES ('wayne10', 'M002', TO_DATE('03-May-2021','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('margot9', 'M005', TO_DATE('01-May-2022','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('margot9', 'M001', TO_DATE('06-May-2022','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('wayne10', 'M003', TO_DATE('01-Aug-2022','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('mount77', 'M004', TO_DATE('02-Aug-2022','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('nancy91', 'M007', TO_DATE('05-Sep-2021','DD-Mon-YYYY'));
    INSERT INTO DownloadMusic VALUES ('santos17', 'M002', TO_DATE('06-May-2021','DD-Mon-YYYY'));
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('DownloadMusic data inserted successfully.');
END;
/
-- Commit the inserts

-- =============================================
-- List the table one by one
-- =============================================


COMMIT;

SELECT * FROM Users;


SELECT * FROM Category;


SELECT * FROM Music;

SELECT * FROM DownloadMusic;


-- =============================================
-- SECTION 3: REQUIRED QUERIES WITH EXPLANATIONS
-- =============================================


-- =============================================
-- Query 1
-- List all music with their IDs, titles and category codes
-- Ordered alphabetically by the title
-- =============================================
SELECT 
    musicId, 
    title, 
    categoryCode
FROM 
    Music
ORDER BY 
    title;


-- =============================================
-- Query 2
-- Find the number of unique users who have downloaded
-- music in the Pop (MO12) or Rock (MO13) categories
-- =============================================
SELECT 
    COUNT(DISTINCT d.userId) AS num_users
FROM 
    DownloadMusic d
JOIN 
    Music m ON d.musicId = m.musicId
WHERE 
    m.categoryCode IN ('MO12', 'MO13');


-- =============================================
-- Query 3
-- Show the total number of downloads for each music category,
-- displaying the category titles
-- =============================================
SELECT 
    c.title AS category_title,
    COUNT(*) AS num_downloads
FROM 
    DownloadMusic d
JOIN 
    Music m ON d.musicId = m.musicId
JOIN 
    Category c ON m.categoryCode = c.categoryCode
GROUP BY 
    c.title;


-- =============================================
-- Query 4
-- Display the category titles for which music was downloaded 
-- more than once
-- =============================================
SELECT 
    c.title AS category_title
FROM 
    DownloadMusic d
JOIN 
    Music m ON d.musicId = m.musicId
JOIN 
    Category c ON m.categoryCode = c.categoryCode
GROUP BY 
    c.title
HAVING 
    COUNT(*) > 1;


-- =============================================
-- End of Part B SQL queries
-- =============================================