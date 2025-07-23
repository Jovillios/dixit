#!/bin/bash

mysql -u username -p"" -e "
CREATE DATABASE IF NOT EXISTS dixit;
USE dixit;
CREATE TABLE IF NOT EXISTS videos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT,
    url VARCHAR(255),
    transcript VARCHAR(255)
);
"

mysql -u root --local-infile=1 dixit \
  -e "LOAD DATA LOCAL INFILE 'videos.csv'
      INTO TABLE videos
      FIELDS TERMINATED BY ','
      ENCLOSED BY '\"'
      LINES TERMINATED BY '\n'
      IGNORE 1 ROWS
      (id, title, url, transcript);"
