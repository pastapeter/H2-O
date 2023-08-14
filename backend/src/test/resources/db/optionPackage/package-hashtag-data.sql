INSERT INTO `hashtag` (`id`, `name`)
VALUES
    (1, '캠핑'),
    (2, '레저'),
    (3, '스포츠'),
    (4, '영화감상');

INSERT INTO `package` (`id`, `name`, `image`, `category`)
VALUES
    (1, 'Package 1', 'image_url_1', '상세품목'),
    (2, 'Package 2', 'image_url_2', '상세품목'),
    (3, 'Package 3', 'image_url_3', '상세품목'),
    (4, 'Package 4', 'image_url_4', '상세품목');

INSERT INTO `package_hashtag` (`package_id`, `hashtag_id`)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (3, 2),
    (4, 1),
    (4, 4);
