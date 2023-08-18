INSERT INTO external_color (id, name, color_code) VALUES
    (1, 'Red', '#FF0000'),
    (2, 'Blue', '#0000FF'),
    (3, 'Green', '#00FF00');

INSERT INTO trims_external_color (trim_id, external_color_id, price, choice_ratio) VALUES
    (1, 1, 2000, 0.3),
    (2, 1, 1500, 0.2),
    (1, 2, 1800, 0.5),
    (2, 2, 1600, 0.4),
    (3, 3, 2200, 0.6);
