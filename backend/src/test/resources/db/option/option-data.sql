INSERT INTO `options` (`name`, `image`, `description`, `use_count`, `category`)
VALUES
    ('Option 1', 'image_url_1', 'Description for Option 1', 12.5, '파워트레인/성능'),
    ('Option 2', 'image_url_2', 'Description for Option 2', 8.3, '편의'),
    ('Option 3', 'image_url_3', NULL, 5.7, '파워트레인/성능'),
    ('Option 4', 'image_url_4', 'Description for Option 4', 20.1, '편의');

INSERT INTO `trims_options` (`trim_id`, `option_id`, `price`, `option_type`, `choice_ratio`)
VALUES
    (1, 1, 500, 'default', 0.3),
    (1, 2, 700, 'default', 0.2),
    (2, 3, 300, 'extra', 0.1),
    (3, 4, 450, 'extra', 0.4);
