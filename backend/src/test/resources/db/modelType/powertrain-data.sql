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
