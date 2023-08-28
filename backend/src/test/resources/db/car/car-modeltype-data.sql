INSERT INTO car_drivetrain(car_id, drivetrain_id, price, choice_ratio)
VALUES (1, 1, 10000, 0.22),
       (1, 2, 20000, 0.23),
       (1, 1, 20000, 0.11),
       (2, 2, 40000, 0.11);

INSERT INTO car_bodytype(car_id, bodytype_id, price, choice_ratio)
VALUES (1, 1, 10000, 0.11),
       (1, 2, 20000, 0.21),
       (2, 1, 30000, 0.33);

INSERT INTO car_powertrain(car_id, powertrain_id, price, choice_ratio)
VALUES (1, 1, 100000, 0.22),
       (1, 2, 300000, 0.21);

INSERT INTO car (id, name, price, category, image)
VALUES
    (1, 'Car Model A', 30000, 'Sedan', 'image_url_a'),
    (2, 'Car Model B', 35000, 'SUV', 'image_url_b'),
    (3, 'Car Model C', 25000, 'Compact', 'image_url_c');
