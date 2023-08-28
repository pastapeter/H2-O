INSERT INTO car(id, name, price, category, image) VALUES (4, 'n1', 1000, 'c1', 'i1');
INSERT INTO trims(id, car_id, name, description, price) VALUES (5, 1, 'n1', 'd1', 1000);
INSERT INTO bodytype(id, name, description, image) VALUES (2, 'n1', 'd1', 'i1');
INSERT INTO drivetrain(id, name, description, image) VALUES (3, 'n1', 'd1', 'i1');
INSERT INTO powertrain(id, name, description, image) VALUES (1, 'n1', 'd1', 'i1');
INSERT INTO external_color(id, name, color_code) VALUES (7, 'n1', '#1');
INSERT INTO internal_color(id, name, fabric_image, internal_image) VALUES (6, 'n1', 'i1', 'i2');
INSERT INTO options(id, name, image, description, use_count, category)
VALUES (8, 'n1', 'i1', 'd1', 0.1, 'c1'), (9, 'n2', 'i2', 'd2', 0.2, 'c2'), (10, 'n3', 'i3', 'd3', 0.3, 'c3');
INSERT INTO package(id, name, image, category)
VALUES (11, 'n1', 'i1', 'c1');

INSERT INTO car_bodytype(car_id, bodytype_id, price, choice_ratio) VALUES (4, 2, 1000, 0.1);
INSERT INTO car_drivetrain(car_id, drivetrain_id, price, choice_ratio) VALUES (4, 3, 1000, 0.1);
INSERT INTO car_powertrain(car_id, powertrain_id, price, choice_ratio) VALUES (4, 1, 1000, 0.1);
INSERT INTO trims_external_color(trim_id, external_color_id, price, choice_ratio) VALUES (5, 7, 1000, 0.1);
INSERT INTO trims_internal_color(trim_id, internal_color_id, price, choice_ratio) VALUES (5, 6, 1000, 0.1);
INSERT INTO trims_options(trim_id, option_id, price, option_type, choice_ratio)
VALUES (5, 8, 1000, 't1', 0.1), (5, 9, 2000, 't2', 0.2), (5, 10, 3000, 't3', 0.3);
INSERT INTO trims_package(trim_id, package_id, price, choice_ratio)
VALUES (5, 11, 1000, 0.1);
