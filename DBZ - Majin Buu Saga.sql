-- Below, I created 3 tables containing information relating to Dragon Ball Z characters that are featured in the Majin Buu Saga of the show.

-- Table 1: information about the 'Z Fighters' (the heroes)
CREATE TABLE dbz_zfighters (
    id INTEGER PRIMARY KEY,
    name TEXT,
    race TEXT,
    base_ki INTEGER
);

INSERT INTO dbz_zfighters (id, name, race, base_ki) VALUES
    (1, 'Goku', 'Saiyan', 375),
    (2, 'Vegeta', 'Saiyan', 300),
    (3, 'Krillin', 'Human', 10),
    (4, 'Gohan', 'Half-Saiyan', 50),
    (5, 'Gotenks', 'Half-Saiyan', 3000),
    (6, 'Piccolo', 'Namekian', 2000),
    (7, 'Vegito', 'Saiyan', 4500000);


-- Table 2: information about the villains. This table contains a column named 'zfighter_id' indicating the 'Z Fighter' that each villain fought
CREATE TABLE dbz_villains (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    villain_name TEXT,
    villain_race TEXT,
    base_villain_ki INTEGER, 
    zfighter_id INTEGER,
    transformation_id INTEGER
);

INSERT INTO dbz_villains (villain_name, villain_race, base_villain_ki, zfighter_id, transformation_id) VALUES
    ('Babidi', 'Wizard', 10, 6, 1),
    ('Dabura', 'Evil King', 5000, 4, 3),
    ('Yakon', 'Monster', 300, 1,2),
    ('Pui Pui','Zoonian', 200, 2,1),
    ('Fat Buu', 'Bubble Gum', 120000, 1, 4),
    ('Super Buu', 'Bubble Gum', 1200000, 5, 4),
    ('Super Buu', 'Bubble Gum', 1200000, 4, 5),
    ('Super Buu, Gotenks Absorbed', 'Bubble Gum', 2400000, 4, 5),
    ('Super Buu, Gohan Absorbed', 'Bubble Gum', 2700000, 7, 2),
    ('Kid Buu', 'Bubble Gum', 150000, 2, 3),
    ('Kid Buu', 'Bubble Gum', 150000, 1, 4);
    
    
-- Table 3: information about the different 'transformations' that the 'Z Fighters can take'
CREATE TABLE transformations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    level TEXT,
    ki_multiplier INTEGER
);

INSERT INTO transformations (level, ki_multiplier) VALUES
    ('Base Form', 1),
    ('Super Saiyan', 50),
    ('Super Saiyan 2', 100),
    ('Super Saiyan 3', 400),
    ('Mystic', 30000);
    

#1 - What were the major battles that took place throughout the Majin Buu Saga?
SELECT
  zf.name AS 'Name'
  ,t.level AS 'Transformation'
  ,(zf.base_ki * t.ki_multiplier) AS 'Z Fighter Max Ki'
  ,v.villain_name AS 'Villain Name'
  ,v.base_villain_ki AS 'Villain Base Ki'
FROM dbz_zfighters AS zf
INNER JOIN dbz_villains AS v ON zf.id = v.zfighter_id
INNER JOIN transformations AS t ON v.transformation_id = t.id
ORDER BY 5 DESC, 3 DESC;

-- Why did we use an INNER JOIN above? Could we have used a LEFT JOIN or RIGHT JOIN?
/* Because we are looking at 'Battles in the Saga', we want to make sure that we query a 
table that only displays the names of 'Z Fighters' that have a matching ID in the villains 
table (Table 2). Would we have used a LEFT JOIN, we would have queried 'Krillin' with NULL 
values in the subsequent columns, given that Krillin did not participate in any battles. */
