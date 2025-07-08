CREATE DATABASE jobfair;

USE jobfair;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role ENUM('seeker', 'company') DEFAULT 'seeker'
);

CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    description TEXT,
    company VARCHAR(100)
);
CREATE TABLE applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    seeker_email VARCHAR(100),
    applied_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (seeker_email) REFERENCES users(email)
);
ALTER TABLE users ADD resume VARCHAR(255);
INSERT INTO users (name, email, password, role) VALUES ('Admin', 'admin@jobfair.com', 'admin123', 'admin');
