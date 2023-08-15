INSERT INTO package(id, name, image, category)
VALUES (1, 'pack1', 'img1', '악세사리'),
       (2, 'pack2', 'img2', '외관');

INSERT INTO trims_package(trim_id, package_id, price, choice_ratio)
VALUES (1, 1, 1000, 10.1),
       (1, 2, 2000, 20.1);
