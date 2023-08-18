CREATE TABLE `car`
(
    `id`       BIGINT       NOT NULL,
    `name`     VARCHAR(255) NOT NULL,
    `price`    INT          NOT NULL,
    `category` VARCHAR(20)  NOT NULL,
    `image`    TEXT         NOT NULL
);

CREATE TABLE `trims`
(
    `id`          BIGINT      NOT NULL,
    `car_id`      BIGINT      NOT NULL,
    `name`        VARCHAR(20) NOT NULL,
    `description` VARCHAR(100) NULL,
    `price`       BIGINT      NOT NULL
);

CREATE TABLE `bodytype`
(
    `id`          BIGINT       NOT NULL,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `drivetrain`
(
    `id`          BIGINT       NOT NULL,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `external_color`
(
    `id`         BIGINT       NOT NULL,
    `name`       VARCHAR(255) NOT NULL,
    `color_code` VARCHAR(7)   NOT NULL
);

CREATE TABLE `internal_color`
(
    `id`             BIGINT       NOT NULL,
    `name`           VARCHAR(255) NOT NULL,
    `fabric_image`   TEXT         NOT NULL,
    `internal_image` TEXT         NOT NULL
);

CREATE TABLE `options`
(
    `id`          BIGINT       NOT NULL,
    `name`        VARCHAR(255) NOT NULL,
    `image`       TEXT         NOT NULL,
    `description` TEXT NULL,
    `use_count`   FLOAT NULL,
    `category`    VARCHAR(20)  NOT NULL
);

CREATE TABLE `powertrain`
(
    `id`          BIGINT       NOT NULL,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `hashtag`
(
    `id`   BIGINT       NOT NULL,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `package`
(
    `id`       BIGINT       NOT NULL,
    `name`     VARCHAR(255) NOT NULL,
    `image`    TEXT         NOT NULL,
    `category` VARCHAR(20)  NOT NULL
);

CREATE TABLE `quotation`
(
    `id`                BIGINT   PRIMARY KEY AUTO_INCREMENT,
    `car_id`            BIGINT   NOT NULL,
    `trim_id`           BIGINT   NOT NULL,
    `powertrain_id`     BIGINT   NOT NULL,
    `bodytype_id`       BIGINT   NOT NULL,
    `drivetrain_id`     BIGINT   NOT NULL,
    `internal_color_id` BIGINT   NOT NULL,
    `external_color_id` BIGINT   NOT NULL,
    `created_at`        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `url`               TEXT NULL
);

CREATE TABLE `sold_car`
(
    `id`                BIGINT NOT NULL,
    `car_id`            BIGINT NOT NULL,
    `trim_id`           BIGINT NOT NULL,
    `powertrain_id`     BIGINT NOT NULL,
    `bodytype_id`       BIGINT NOT NULL,
    `drivetrain_id`     BIGINT NOT NULL,
    `internal_color_id` BIGINT NOT NULL,
    `external_color_id` BIGINT NOT NULL,
    `price`             INT    NOT NULL
);

CREATE TABLE `sold_car_extra_options`
(
    `sold_car_id` BIGINT NOT NULL,
    `option_id`   BIGINT NOT NULL
);

CREATE TABLE `sold_car_package`
(
    `sold_car_id` BIGINT NOT NULL,
    `package_id`  BIGINT NOT NULL
);

CREATE TABLE `powertrain_output`
(
    `powertrain_id` BIGINT NOT NULL,
    `output`        FLOAT NULL,
    `min_rpm`       INT NULL,
    `max_rpm`       INT NULL
);

CREATE TABLE `powertrain_torque`
(
    `powertrain_id` BIGINT NOT NULL,
    `torque`        FLOAT NULL,
    `min_rpm`       INT NULL,
    `max_rpm`       INT NULL
);

CREATE TABLE `car_powertrain`
(
    `car_id`        BIGINT NOT NULL,
    `powertrain_id` BIGINT NOT NULL,
    `price`         INT    NOT NULL,
    `choice_ratio`  FLOAT NULL
);

CREATE TABLE `car_bodytype`
(
    `car_id`       BIGINT NOT NULL,
    `bodytype_id`  BIGINT NOT NULL,
    `price`        INT    NOT NULL,
    `choice_ratio` FLOAT NULL
);

CREATE TABLE `car_drivetrain`
(
    `car_id`        BIGINT NOT NULL,
    `drivetrain_id` BIGINT NOT NULL,
    `price`         INT    NOT NULL,
    `choice_ratio`  FLOAT NULL
);

CREATE TABLE `technical_spec`
(
    `powertrain_id`   BIGINT NOT NULL,
    `drivetrain_id`   BIGINT NOT NULL,
    `displacement`    INT    NOT NULL,
    `fuel_efficiency` FLOAT  NOT NULL
);

CREATE TABLE `external_color_image`
(
    `id`                BIGINT NOT NULL,
    `external_color_id` BIGINT NOT NULL,
    `image`             TEXT   NOT NULL
);

CREATE TABLE `trims_image`
(
    `id`      BIGINT NOT NULL,
    `trim_id` BIGINT NOT NULL,
    `image`   TEXT   NOT NULL
);

CREATE TABLE `trims_external_color`
(
    `trim_id`           BIGINT NOT NULL,
    `external_color_id` BIGINT NOT NULL,
    `price`             INT    NOT NULL,
    `choice_ratio`      FLOAT NULL
);

CREATE TABLE `trims_internal_color`
(
    `trim_id`           BIGINT NOT NULL,
    `internal_color_id` BIGINT NOT NULL,
    `price`             INT    NOT NULL,
    `choice_ratio`      FLOAT NULL
);

CREATE TABLE `trims_package`
(
    `trim_id`      BIGINT NOT NULL,
    `package_id`   BIGINT NOT NULL,
    `price`        INT    NOT NULL,
    `choice_ratio` FLOAT NULL
);

CREATE TABLE `trims_options`
(
    `trim_id`      BIGINT      NOT NULL,
    `option_id`    BIGINT      NOT NULL,
    `price`        INT         NOT NULL,
    `option_type`  VARCHAR(20) NOT NULL,
    `choice_ratio` FLOAT NULL
);

CREATE TABLE `options_hashtag`
(
    `option_id`  BIGINT NOT NULL,
    `hashtag_id` BIGINT NOT NULL
);

CREATE TABLE `options_quotation`
(
    `quotation_id` BIGINT NOT NULL,
    `option_id`    BIGINT NOT NULL
);

CREATE TABLE `package_options`
(
    `package_id` BIGINT NOT NULL,
    `option_id`  BIGINT NOT NULL
);

CREATE TABLE `package_hashtag`
(
    `package_id` BIGINT NOT NULL,
    `hashtag_id` BIGINT NOT NULL
);

CREATE TABLE `package_quotation`
(
    `quotation_id` BIGINT NOT NULL,
    `package_id`   BIGINT NOT NULL
);
