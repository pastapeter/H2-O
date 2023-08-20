INSERT INTO external_color (id, name, color_code) VALUES
    (1, 'Red', '#FF0000'),
    (2, 'Black', '#FF0001'),
    (3, 'Green', '#00FF00');

INSERT INTO trims_external_color (trim_id, external_color_id, price, choice_ratio) VALUES
    (1, 1, 100, 0.5),
    (2, 1, 1500, 0.2),
    (1, 2, 240, 0.2),
    (2, 2, 1600, 0.4),
    (3, 3, 2200, 0.6);
