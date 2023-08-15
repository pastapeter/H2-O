INSERT INTO trims (id, car_id, name, description, price)
VALUES
    (1, 1, 'Trim A', 'Description for Trim A', 20000),
    (2, 1, 'Trim B', 'Description for Trim B', 25000),
    (3, 2, 'Trim X', 'Description for Trim X', 30000),
    (4, 2, 'Trim Y', 'Description for Trim Y', 35000);

INSERT INTO trims_options (trim_id, option_id, price, option_type, choice_ratio)
VALUES
    (1, 1, 1000, 'default', 0.5),
    (1, 2, 1500, 'default', 0.3),
    (1, 3, 2000, 'extra', 0.2),
    (2, 2, 1800, 'default', 0.6),
    (2, 4, 2200, 'extra', 0.4),
    (3, 1, 1600, 'default', 0.7),
    (3, 3, 2400, 'extra', 0.3),
    (4, 2, 2100, 'default', 0.8),
    (4, 4, 2800, 'extra', 0.2);

INSERT INTO trims_package (trim_id, package_id, price, choice_ratio)
VALUES
    (1, 1, 1000, 0.5),
    (1, 2, 1500, 0.3),
    (2, 2, 1800, 0.6),
    (2, 3, 2200, 0.4),
    (3, 1, 1600, 0.7),
    (3, 3, 2400, 0.3),
    (4, 2, 2100, 0.8),
    (4, 4, 2800, 0.2);

INSERT INTO trims_external_color (trim_id, external_color_id, price, choice_ratio)
VALUES
    (1, 101, 200, 0.8),
    (1, 102, 220, 0.7),
    (2, 101, 180, 0.9),
    (2, 103, 210, 0.6);

INSERT INTO trims_internal_color (trim_id, internal_color_id, price, choice_ratio)
VALUES
    (1, 201, 150, 0.85),
    (1, 202, 170, 0.75),
    (2, 202, 160, 0.95),
    (2, 203, 180, 0.65);
