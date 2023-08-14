INSERT INTO `package` (`id`, `name`, `image`, `category`)
VALUES
    (1, 'Package 1', 'image_url_pkg_1', '상세품목'),
    (2, 'Package 2', 'image_url_pkg_2', '상세품목'),
    (3, 'Package 3', 'image_url_pkg_3', '상세품목');

INSERT INTO `trims_package` (`trim_id`, `package_id`, `price`, `choice_ratio`)
VALUES
    (2, 1, 500, 0.7),
    (2, 2, 700, 0.6),
    (2, 3, 800, 0.8);
