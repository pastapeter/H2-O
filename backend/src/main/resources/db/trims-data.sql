INSERT INTO car (id, name, price, category, image)
VALUES
    (1, 'Car A', 20000, 'Sedan', 'car_a.jpg'),
    (2, 'Car B', 25000, 'SUV', 'car_b.jpg'),
    (3, 'Car C', 18000, 'Hatchback', 'car_c.jpg'),
    (4, 'Car D', 30000, 'SUV', 'car_d.jpg'),
    (5, 'Car E', 22000, 'Sedan', 'car_e.jpg'),
    (6, 'Car F', 26000, 'Crossover', 'car_f.jpg'),
    (7, 'Car G', 19000, 'Hatchback', 'car_g.jpg'),
    (8, 'Car H', 28000, 'SUV', 'car_h.jpg'),
    (9, 'Car I', 23000, 'Sedan', 'car_i.jpg'),
    (10, 'Car J', 21000, 'Crossover', 'car_j.jpg');

INSERT INTO trims (car_id, name, description, price)
VALUES
    (1, 1, 'Trim 1', 'Basic Trim', 1500),
    (2, 1, 'Trim 2', 'Advanced Trim', 2500),
    (3, 2, 'Trim 3', 'Standard Trim', 2000),
    (4, 2, 'Trim 4', 'Premium Trim', 3000),
    (5, 3, 'Trim 5', 'Basic Trim', 1200),
    (6, 3, 'Trim 6', 'Advanced Trim', 2200),
    (7, 4, 'Trim 7', 'Standard Trim', 2800),
    (8, 4, 'Trim 8', 'Premium Trim', 3800),
    (9, 5, 'Trim 9', 'Basic Trim', 1700),
    (10, 5, 'Trim 10', 'Advanced Trim', 2700);
