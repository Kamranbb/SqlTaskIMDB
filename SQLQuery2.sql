CREATE DATABASE IMDB
USE IMDB

CREATE TABLE Movies
(
Id int PRIMARY KEY IDENTITY,
[Name] nvarchar(20),
[Year] int,
Duration int,
Rate decimal(2,1),
)

INSERT INTO Movies ([Name],[Year],Duration,Rate) VALUES 
('Movie1',1972,175,9.2),
 ('Movie2',2008,152,9.0),
('Movie3',2010,148,8.8),
('Movie4',2014,169,8.7)

CREATE TABLE Directors
(
Id int PRIMARY KEY IDENTITY,
FullName nvarchar(30),
MovieId int FOREIGN KEY REFERENCES Movies(Id)
)
INSERT INTO Directors (FullName) VALUES 
('Kamran Baxsaliyev'),
('Leman Memmedova'),
('Ayxan Tagizade'),
('Tahnmasib Taghizada')


CREATE TABLE Actors 
(
Id int PRIMARY KEY IDENTITY,
FullName nvarchar(30)
)
INSERT INTO Actors (FullName) VALUES 
('Musa Musayev'),
('Nerman Baxsaliyev'),
('Nigar Aliyeva'),
('Turkan Israfilov')

CREATE TABLE MovieActors
(
Id int PRIMARY KEY IDENTITY,
MovieId int FOREIGN KEY REFERENCES Movies(Id),
ActorId int FOREIGN KEY REFERENCES Actors(Id)
)


CREATE TABLE Genres 
(
Id int PRIMARY KEY IDENTITY,
[Name] nvarchar(10)
)


INSERT INTO Genres ([Name]) VALUES 
('Qorxu'),
('Dram'),
('Romantik')


CREATE TABLE MovieGenre
(
Id int PRIMARY KEY IDENTITY,
MovieId int FOREIGN KEY REFERENCES Movies(Id),
GenreId int FOREIGN KEY REFERENCES Genres(Id)
)


SELECT m.Name, m.Rate, a.FullName From Movies m
JOIN MovieActors d
ON m.Id=d.MovieId 
JOIN Actors a ON a.Id=d.ActorId

SELECT DISTINCT m.Name,  m.Rate, a.Name AS MovieGenre, d.FullName AS DirectorName, n.FullName AS ActorName FROM Movies m 
JOIN MovieGenre g ON m.Id=g.MovieId
JOIN Genres a ON a.Id=g.GenreId 
JOIN Directors d ON m.Id=d.MovieId
JOIN MovieActors b ON m.Id=b.MovieId
JOIN Actors n ON n.Id=b.ActorId


SELECT m.Name MovieName, m.Rate, d.FullName AS DirectorName  FROM Movies m 
JOIN Directors d
ON m.Id=d.MovieId

SELECT m.Name MovieName, m.Rate, a.Name GenreName From Movies m
JOIN MovieGenre g
ON m.Id=g.MovieId 
JOIN Genres a ON a.Id=g.GenreId

SELECT m.Name MovieName , m.Rate, a.Name GenreName From Movies m
JOIN MovieGenre g
ON m.Id=g.MovieId 
JOIN Genres a ON a.Id=g.GenreId
WHERE a.Name LIKE '%a%'


SELECT DISTINCT m.Name MovieName,  m.Rate, a.Name GenreName , d.FullName DirectorName, n.FullName ActorName FROM Movies m 
JOIN MovieGenre g OsN m.Id=g.MovieId
JOIN Genres a ON a.Id=g.GenreId 
JOIN Directors d ON m.Id=d.MovieId
JOIN MovieActors b ON m.Id=b.MovieId
JOIN Actors n ON n.Id=b.ActorId
WHERE m.Rate>(SELECT AVG(Rate) FROM Movies)
ORDER BY m.Rate DESC