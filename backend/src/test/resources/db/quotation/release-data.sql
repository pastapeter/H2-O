INSERT INTO sold_car (id, car_id, trim_id, powertrain_id, bodytype_id, drivetrain_id, internal_color_id, external_color_id, price)
VALUES
    (1, 1, 2, 1, 1, 1, 1, 1, 30000),
    (4, 1, 2, 1, 1, 1, 1, 1, 30000),
    (2, 1, 2, 2, 2, 2, 2, 2, 35000),
    (3, 1, 2, 2, 2, 2, 2, 2, 35000);

-- Inserting data into sold_car_extra_options table
INSERT INTO sold_car_extra_options (sold_car_id, option_id)
VALUES
    (1, 1),
    (3, 1),
    (3, 4),
    (2, 1),
    (2, 4),
    (4, 1);

-- Inserting data into sold_car_package table
INSERT INTO sold_car_package (sold_car_id, package_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 3),
    (4, 1),
    (4, 2);
