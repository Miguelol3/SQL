-- I created a list of household items that I wanted to get rid of during a garage sale a few weeks back

CREATE TABLE garage_sale (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_name TEXT,
    item_brand TEXT,
    item_color TEXT,
    home_section TEXT,
    item_price REAL,
    item_condition TEXT
);

INSERT INTO garage_sale (item_name, item_brand, item_color, home_section, item_price, item_condition) VALUES
    ("writing desk", "furinno", "white", "home office", 19.99, "good"),
    ("desk chair", "furmax", "black", "home office", 39.99, "used"),
    ("computer monitor", "lenovo", "black", "home office", 89.99, "good"),
    ("dresser", "IKEA", "grey", "bedroom", 59.99, "used"),
    ("TV", "samsumng", "black", "common room", 219.99, "good"),
    ("dining table", "IKEA", "dark oak", "common room", 84.99, "used"),
    ("couch", "burrow", "beige", "common room", 314.99, "worn"),
    ("lamp", "mainstays", "brown", "bedroom", 14.99, "good"),
    ("tennis racket", "wilson", "red", "patio", 9.99, "worn"),
    ("grill", "blackstone", "black", "patio", 164.99, "used"),
    ("rug", "nuloom", "blue", "common room", 74.99, "used"),
    ("vaccum", "bissell", "red", "common room", 42.99, "good"),
    ("cookware set", "tools of the trade", "silver", "kitchen", 34.99, "used"),
    ("coffee table", "IKEA", "dark oak", "common room", 9.99, "good"),
    ("pressure cooker", "ninja", "silver", "kitchen", 94.99, "good");  

-- #1. Display items for sale ordered by largest price.
SELECT * FROM garage_sale 
ORDER BY item_price DESC;


-- #2. What is the average price of the items for sale?
SELECT ROUND(AVG(item_price), 2) AS 'AVG Item Price' FROM garage_sale;


-- #3. How many items are being sold per category?
SELECT home_section, COUNT(*) AS 'Item Count' FROM garage_sale 
GROUP BY home_section 
ORDER BY 2 DESC;


-- #4. What are the 4 most common colors across these 15 items?
SELECT item_color, COUNT(*) AS 'Item Count' FROM garage_sale 
GROUP BY item_color 
ORDER BY 2 DESC 
LIMIT 4;
