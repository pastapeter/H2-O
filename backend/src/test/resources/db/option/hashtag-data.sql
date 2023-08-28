-- hashtag 테이블 더미 데이터 생성
INSERT INTO `hashtag` (`id`, `name`)
values
    (1, '캠핑'),
    (2, '레저'),
    (3, '스포츠'),
    (4, '영화감상');

-- options 테이블 더미 데이터 생성
INSERT INTO `options` (`id`, `name`, `image`, `description`, `use_count`, `category`)
VALUES
    (1, 'Option 1', 'image_url_1', 'Description for Option 1', 12.5, '파워트레인/성능'),
    (2, 'Option 2', 'image_url_2', 'Description for Option 2', 8.3, '파워트레인/성능'),
    (3, 'Option 3', 'image_url_3', NULL, 5.7, '파워트레인/성능'),
    (4, 'Option 4', 'image_url_4', 'Description for Option 4', 20.1, '파워트레인/성능');

-- options_hashtag 테이블 더미 데이터 생성
INSERT INTO `options_hashtag` (`option_id`, `hashtag_id`)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (3, 2),
    (4, 1),
    (4, 4);
