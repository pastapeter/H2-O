INSERT INTO internal_color (id, name, fabric_image, internal_image) VALUES
    (1, 'Red', 'fabric_image_url_1', 'internal_image_url_1'),
    (2, 'Blue', 'fabric_image_url_2', 'internal_image_url_2'),
    (3, 'Green', 'fabric_image_url_3', 'internal_image_url_3');

INSERT INTO trims_internal_color (trim_id, internal_color_id, price, choice_ratio) VALUES
    (1, 1, 2000, 0.3),
    (1, 2, 1500, 0.2),
    (2, 1, 1800, 0.5),
    (2, 3, 1600, 0.4),
    (3, 2, 2200, 0.6);
