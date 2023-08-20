INSERT INTO bodytype(id, name, description, image)
VALUES (1, 'name1', 'description1', 'img_url1'),
       (2, 'name2', 'description2', 'img_url2'),
       (3, 'name3', 'description3', 'img_url3');

INSERT INTO car_bodytype(car_id, bodytype_id, price, choice_ratio)
VALUES (1, 1, 10000, 0.11),
       (1, 2, 20000, 0.21),
       (2, 1, 30000, 0.33);
