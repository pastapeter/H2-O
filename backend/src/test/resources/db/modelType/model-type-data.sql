INSERT INTO powertrain(name, description, image) VALUES
                                                     ('powertrain1', 'description1', 'img_url1'),
                                                     ('powertrain2', 'description2', 'img_url2'),
                                                     ('powertrain3', 'description3', 'img_url3'),
                                                     ('powertrain4', 'description4', 'img_url4');

INSERT INTO powertrain_output(powertrain_id, output, min_rpm, max_rpm) VALUES
                                                                           (1, 202.2, 1000, 1000),
                                                                           (2, 150.3, 2000, 2000);

INSERT INTO powertrain_torque(powertrain_id, torque, min_rpm, max_rpm) VALUES
                                                                           (1, 100.1, 3000, 3000),
                                                                           (2, 199.2, 4500, 5500);

INSERT INTO car_powertrain(car_id, powertrain_id, price, choice_ratio) VALUES
                                                                           (1, 1, 100000, 0.22),
                                                                           (1, 2, 300000, 0.21);

INSERT INTO drivetrain(name, description, image) VALUES
                                                         ('drivetrain1', 'description1', 'img_url1'),
                                                         ('drivetrain2', 'description2', 'img_url2'),
                                                         ('drivetrain3', 'description3', 'img_url3'),
                                                         ('drivetrain4', 'description4', 'img_url4');

INSERT INTO car_drivetrain(car_id, drivetrain_id, price, choice_ratio) VALUES
                                                                           (1, 1, 10000, 0.22),
                                                                           (1, 2, 20000, 0.23),
                                                                           (2, 1, 20000, 0.11),
                                                                           (2, 2, 40000, 0.11);

INSERT INTO bodytype(name, description, image) VALUES
                                                       ('bodytype1', 'description1', 'img_url1'),
                                                       ('bodytype2', 'description2', 'img_url2'),
                                                       ('bodytype3', 'description3', 'img_url3');

INSERT INTO car_bodytype(car_id, bodytype_id, price, choice_ratio) VALUES
                                                                       (1, 1, 10000, 0.11),
                                                                       (1, 2, 20000, 0.21),
                                                                       (2, 1, 30000, 0.33);
