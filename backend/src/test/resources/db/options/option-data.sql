INSERT INTO options(id, name, image, description, use_count, category)
VALUES (1, 'option1', 'img1', 'desc1', 20.0, '악세사리'),
       (2, 'option2', 'img2', 'desc2', 20.0, '안전'),
       (3, 'option3', 'img3', 'desc3', 20.0, '외관'),
       (4, 'option4', 'img4', 'desc4', 20.0, '외관'),
       (5, 'option5', 'img5', 'desc5', 20.0, '외관'),
       (6, 'option6', 'img6', 'desc6', 20.0, '외관'),
       (7, 'option7', 'img7', 'desc7', 20.0, '외관'),
       (8, 'option8', 'img8', 'desc8', 20.0, '외관'),
       (9, 'option9', 'img9', 'desc9', 20.0, '외관');


INSERT INTO trims_options(trim_id, option_id, price, option_type, choice_ratio)
VALUES (1, 1, 1000, 'extra', 21.2),
       (1, 2, 0, 'default', null),
       (1, 3, 0, 'default', null),
       (1, 4, 2000, 'extra', 31.2),
       (1, 5, 0, 'default', null),
       (1, 6, 3000, 'extra', 31.2),
       (1, 7, 0, 'default', null),
       (1, 8, 5000, 'extra', 31.2),
       (1, 9, 0, 'default', null);
