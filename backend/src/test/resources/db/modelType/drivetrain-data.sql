INSERT INTO drivetrain(id, name, description, image) VALUES
                                                     (1, 'name1', 'description1', 'img_url1'),
                                                     (2, 'name2', 'description2', 'img_url2'),
                                                     (3, 'name3', 'description3', 'img_url3'),
                                                     (4, 'name4', 'description4', 'img_url4');

INSERT INTO car_drivetrain(car_id, drivetrain_id, price, choice_ratio) VALUES
                                                                           (1, 1, 10000, 0.22),
                                                                           (1, 2, 20000, 0.23),
                                                                           (2, 1, 20000, 0.11),
                                                                           (2, 2, 40000, 0.11);
