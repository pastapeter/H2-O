INSERT INTO car (name, price, category, image)
VALUES
    ('Car A', 20000, 'Sedan', 'car_a.jpg'),
    ('Car B', 25000, 'SUV', 'car_b.jpg'),
    ('Car C', 18000, 'Hatchback', 'car_c.jpg'),
    ('Car D', 30000, 'SUV', 'car_d.jpg'),
    ('Car E', 22000, 'Sedan', 'car_e.jpg'),
    ('Car F', 26000, 'Crossover', 'car_f.jpg'),
    ('Car G', 19000, 'Hatchback', 'car_g.jpg'),
    ('Car H', 28000, 'SUV', 'car_h.jpg'),
    ('Car I', 23000, 'Sedan', 'car_i.jpg'),
    ('Car J', 21000, 'Crossover', 'car_j.jpg');

INSERT INTO trims (car_id, name, description, price)
VALUES
    (1, 'Trim 1', 'Basic Trim', 1500),
    (1, 'Trim 2', 'Advanced Trim', 2500),
    (2, 'Trim 3', 'Standard Trim', 2000),
    (2, 'Trim 4', 'Premium Trim', 3000),
    (3, 'Trim 5', 'Basic Trim', 1200),
    (3, 'Trim 6', 'Advanced Trim', 2200),
    (4, 'Trim 7', 'Standard Trim', 2800),
    (4, 'Trim 8', 'Premium Trim', 3800),
    (5, 'Trim 9', 'Basic Trim', 1700),
    (5, 'Trim 10', 'Advanced Trim', 2700);
