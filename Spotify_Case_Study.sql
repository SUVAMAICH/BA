CREATE DATABASE spotify_db;
USE spotify_db;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    country VARCHAR(50),
    plan VARCHAR(20)
);

CREATE TABLE Artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    genre VARCHAR(50)
);

CREATE TABLE Tracks (
    track_id INT PRIMARY KEY,
    track_name VARCHAR(100),
    artist_id INT,
    duration_sec INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

CREATE TABLE Listening_History (
    play_id INT PRIMARY KEY,
    user_id INT,
    track_id INT,
    minutes_played INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (track_id) REFERENCES Tracks(track_id)
);

INSERT INTO Users (user_id, user_name, country, plan) VALUES
(1, 'Aditi', 'India', 'Premium'),
(2, 'Rahul', 'India', 'Free'),
(3, 'Emma', 'UK', 'Premium'),
(4, 'Noah', 'USA', 'Free'),
(5, 'Sofia', 'Spain', 'Premium'),
(6, 'Arjun', 'India', 'Free');

INSERT INTO Artists (artist_id, artist_name, genre) VALUES
(101, 'Arijit Singh', 'Bollywood'),
(102, 'Taylor Swift', 'Pop'),
(103, 'The Weeknd', 'Pop'),
(104, 'A. R. Rahman', 'Bollywood'),
(105, 'Ed Sheeran', 'Pop'),
(106, 'Imagine Dragons', 'Rock');

INSERT INTO Tracks (track_id, track_name, artist_id, duration_sec) VALUES
(201, 'Kesariya', 101, 268),
(202, 'Anti-Hero', 102, 200),
(203, 'Blinding Lights', 103, 200),
(204, 'Jai Ho', 104, 210),
(205, 'Shape of You', 105, 234),
(206, 'Believer', 106, 204),
(207, 'Perfect', 105, 263),
(208, 'Channa Mereya', 101, 290);

INSERT INTO Listening_History (play_id, user_id, track_id, minutes_played) VALUES
(1001, 1, 201, 4),
(1002, 1, 202, 3),
(1003, 2, 201, 4),
(1004, 2, 203, 3),
(1005, 3, 205, 4),
(1006, 3, 207, 4),
(1007, 4, 206, 3),
(1008, 4, 203, 3),
(1009, 5, 202, 3),
(1010, 5, 205, 4),
(1011, 6, 208, 5),
(1012, 6, 201, 4),
(1013, 1, 208, 5),
(1014, 2, 206, 3),
(1015, 3, 202, 3);

SELECT * FROM Users;
SELECT * FROM Artists;
SELECT * FROM Tracks;
SELECT * FROM Listening_History;

-- a. FETCH – Get Me the Basic Numbers
-- Your manager asks you to retrieve the following information.

-- 1. List all available tracks along with their durations.
select track_id,track_name,duration_sec from tracks;
-- 2. Show all users who are subscribed to the Premium plan.
select * from users where plan='premium';
-- 3. Find all tracks whose names contain the word “Lights”.
select * from tracks where track_name like '%lights%';
-- 4. Find all tracks whose names start with the letter “B”.
select * from tracks where track_name like 'b%';
-- 5. Display track names and durations using meaningful column aliases.
SELECT track_name AS "Track Name", duration_sec AS "Duration (Seconds)" FROM Tracks;
-- 6. List all artists in alphabetical order.
select * from artists order by artist_name asc;
-- 7. Show all users from India who are on the Free plan.
select * from users where country ='india' and plan = 'free';

-- b. ANALYZE – Help Me Understand What's Happening

-- 8. Calculate the number of tracks available in each genre.
select a.genre,count(t.track_id) as total_count
from tracks t
join artists a
on a.artist_id = t.artist_id
group by a.genre;
-- 9. Find the total number of plays for each song.
select t.track_name,count(l.play_id) as total_count
from listening_history l
join tracks t 
on l.track_id = t.track_id
group by t.track_name;
-- 10. Identify the top 5 most-played songs.
select t.track_name,count(l.play_id) as total_count
from listening_history l
join tracks t 
on l.track_id = t.track_id
group by t.track_name
order by total_count desc
limit 5;
-- 11. Calculate the total listening minutes for each user.
select u.user_id,u.user_name,sum(l.minutes_played) as total
from listening_history l
join users u
on l.user_id=u.user_id
group by u.user_id ;
-- 12. Find artists whose songs have been played more than twice.
select a.artist_id,a.artist_name,count(l.play_id) as played
from tracks t 
join artists a
on a.artist_id = t.artist_id
join listening_history l 
on t.track_id = l.track_id
group by a.artist_id
having played>2;
-- 13. Calculate the total listening minutes for each country.
select u.country,sum(l.minutes_played) as total
from listening_history l
join users u
on u.user_id = l.user_id
group by u.country;
-- 14. Find genres that contain more than one track.
select a.genre,count(t.track_id) as total_count
from tracks t
join artists a
on a.artist_id = t.artist_id
group by a.genre
having total_count>1;
-- 15. Display each user's listening history along with the song title and artist name.
select u.user_id,u.user_name,l.play_id,t.track_name,a.artist_name
from listening_history l 
join users u
on u.user_id = l.user_id
join tracks t
on t.track_id = l.track_id
join artists a
on a.artist_id = t.artist_id;

