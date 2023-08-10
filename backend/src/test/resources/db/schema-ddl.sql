CREATE TABLE `car`
(
    `id`       BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`     VARCHAR(255) NOT NULL,
    `price`    INT          NOT NULL,
    `category` VARCHAR(20)  NOT NULL,
    `image`    TEXT         NOT NULL
);

CREATE TABLE `trims`
(
    `id`          BIGINT PRIMARY KEY AUTO_INCREMENT,
    `car_id`      BIGINT       NOT NULL,
    `name`        VARCHAR(20)  NOT NULL,
    `description` VARCHAR(100) NULL,
    `price`       BIGINT       NOT NULL
);

CREATE TABLE `bodytype`
(
    `id`          BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT         NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `drivetrain`
(
    `id`          BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT         NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `external_color`
(
    `id`         BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`       VARCHAR(255) NOT NULL,
    `color_code` VARCHAR(7)   NOT NULL
);

CREATE TABLE `internal_color`
(
    `id`             BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`           VARCHAR(255) NOT NULL,
    `fabric_image`   TEXT         NOT NULL,
    `internal_image` TEXT         NOT NULL
);

CREATE TABLE `options`
(
    `id`          BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(255) NOT NULL,
    `image`       TEXT         NOT NULL,
    `description` TEXT         NULL,
    `use_count`   FLOAT        NULL
);

CREATE TABLE `powertrain`
(
    `id`          BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(255) NOT NULL,
    `description` TEXT         NULL,
    `image`       TEXT         NOT NULL
);

CREATE TABLE `hashtag`
(
    `id`   BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `package`
(
    `id`    BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name`  VARCHAR(255) NOT NULL,
    `image` TEXT         NOT NULL
);

CREATE TABLE `quotation`
(
    `id`                BIGINT PRIMARY KEY AUTO_INCREMENT,
    `trim_id`           BIGINT   NOT NULL,
    `powertrain_id`     BIGINT   NOT NULL,
    `body_type_id`      BIGINT   NOT NULL,
    `internal_color_id` BIGINT   NOT NULL,
    `external_color_id` BIGINT   NOT NULL,
    `created_at`        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `url`               TEXT     NULL
);

CREATE TABLE `category`
(
    `id`   BIGINT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
);

CREATE TABLE `trims_image`
(
    `id`      BIGINT PRIMARY KEY AUTO_INCREMENT,
    `trim_id` BIGINT NOT NULL,
    `image`   TEXT   NOT NULL,
    FOREIGN KEY (`trim_id`) REFERENCES `trims` (`id`)

);

CREATE TABLE `external_color_image`
(
    `id`                BIGINT PRIMARY KEY AUTO_INCREMENT,
    `external_color_id` BIGINT NOT NULL,
    `image`             TEXT   NOT NULL,
    FOREIGN KEY (`external_color_id`) REFERENCES `external_color` (`id`)
);

CREATE TABLE `technical_spec`
(
    `powertrain_id`   BIGINT NOT NULL,
    `drivetrain_id`   BIGINT NOT NULL,
    `displacement`    INT    NOT NULL,
    `fuel_efficiency` FLOAT  NOT NULL
);

CREATE TABLE `car_powertrain`
(
    `car_id`        BIGINT NOT NULL,
    `powertrain_id` BIGINT NOT NULL,
    `price`         INT    NOT NULL
);

CREATE TABLE `car_bodytype`
(
    `car_id`      BIGINT NOT NULL,
    `bodytype_id` BIGINT NOT NULL,
    `price`       INT    NOT NULL
);

CREATE TABLE `car_drivetrain`
(
    `car_id`        BIGINT NOT NULL,
    `drivetrain_id` BIGINT NOT NULL,
    `price`         INT    NOT NULL
);

CREATE TABLE `trims_internal_color`
(
    `trim_id`           BIGINT NOT NULL,
    `internal_color_id` BIGINT NOT NULL,
    `price`             INT    NOT NULL
);

CREATE TABLE `trims_package`
(
    `trim_id`      BIGINT NOT NULL,
    `package_id`   BIGINT NOT NULL,
    `price`        INT    NOT NULL,
    `choice_ratio` FLOAT  NULL
);

CREATE TABLE `trims_options`
(
    `trim_id`      BIGINT      NOT NULL,
    `option_id`    BIGINT      NOT NULL,
    `price`        INT         NOT NULL,
    `option_type`  VARCHAR(20) NOT NULL,
    `choice_ratio` FLOAT       NULL
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

CREATE TABLE `options_hashtag`
(
    `option_id`  BIGINT NOT NULL,
    `hashtag_id` BIGINT NOT NULL
);

CREATE TABLE `trims_external_color`
(
    `trim_id`           BIGINT NOT NULL,
    `external_color_id` BIGINT NOT NULL,
    `price`             INT    NOT NULL
);

CREATE TABLE `options_quotation`
(
    `option_id`    BIGINT NOT NULL,
    `quotation_id` BIGINT NOT NULL
);

CREATE TABLE `package_quotation`
(
    `package_id`   BIGINT NOT NULL,
    `quotation_id` BIGINT NOT NULL
);

CREATE TABLE `package_category`
(
    `package_id`  BIGINT NOT NULL,
    `category_id` BIGINT NOT NULL
);

CREATE TABLE `options_category`
(
    `option_id`   BIGINT NOT NULL,
    `category_id` BIGINT NOT NULL
);

CREATE TABLE `powertrain_spec`
(
    `powertrain_id`  BIGINT NOT NULL,
    `output_ps`      FLOAT  NULL,
    `output_rpm`     INT    NULL,
    `torque_kgfm`    FLOAT  NULL,
    `torque_min_rpm` INT    NULL,
    `torque_max_rpm` INT    NULL
);

ALTER TABLE `technical_spec`
    ADD CONSTRAINT `PK_TECHNICAL_SPEC`
        PRIMARY KEY (`powertrain_id`, `drivetrain_id`);

ALTER TABLE `car_powertrain`
    ADD CONSTRAINT `PK_CAR_POWERTRAIN`
        PRIMARY KEY (`car_id`, `powertrain_id`);

ALTER TABLE `car_bodytype`
    ADD CONSTRAINT `PK_CAR_BODYTYPE`
        PRIMARY KEY (`car_id`, `bodytype_id`);

ALTER TABLE `car_drivetrain`
    ADD CONSTRAINT `PK_CAR_DRIVETRAIN`
        PRIMARY KEY (`car_id`, `drivetrain_id`);

ALTER TABLE `trims_internal_color`
    ADD CONSTRAINT `PK_TRIMS_INTERNAL_COLOR`
        PRIMARY KEY (`trim_id`, `internal_color_id`);

ALTER TABLE `trims_package`
    ADD CONSTRAINT `PK_TRIMS_PACKAGE`
        PRIMARY KEY (`trim_id`, `package_id`);

ALTER TABLE `trims_options`
    ADD CONSTRAINT `PK_TRIMS_OPTIONS`
        PRIMARY KEY (`trim_id`, `option_id`);

ALTER TABLE `package_options`
    ADD CONSTRAINT `PK_PACKAGE_OPTIONS`
        PRIMARY KEY (`package_id`, `option_id`);

ALTER TABLE `package_hashtag`
    ADD CONSTRAINT `PK_PACKAGE_HASHTAG`
        PRIMARY KEY (`package_id`, `hashtag_id`);

ALTER TABLE `options_hashtag`
    ADD CONSTRAINT `PK_OPTIONS_HASHTAG`
        PRIMARY KEY (`option_id`, `hashtag_id`);

ALTER TABLE `trims_external_color`
    ADD CONSTRAINT `PK_TRIMS_EXTERNAL_COLOR`
        PRIMARY KEY (`trim_id`, `external_color_id`);

ALTER TABLE `options_quotation`
    ADD CONSTRAINT `PK_OPTIONS_QUOTATION`
        PRIMARY KEY (`option_id`, `quotation_id`);

ALTER TABLE `package_quotation`
    ADD CONSTRAINT `PK_PACKAGE_QUOTATION`
        PRIMARY KEY (`package_id`, `quotation_id`);

ALTER TABLE `package_category`
    ADD CONSTRAINT `PK_PACKAGE_CATEGORY`
        PRIMARY KEY (`package_id`, `category_id`);

ALTER TABLE `options_category`
    ADD CONSTRAINT `PK_OPTIONS_CATEGORY`
        PRIMARY KEY (`option_id`, `category_id`);

ALTER TABLE `powertrain_spec`
    ADD CONSTRAINT `PK_POWERTRAIN_SPEC`
        PRIMARY KEY (`powertrain_id`);

ALTER TABLE `technical_spec`
    ADD CONSTRAINT `FK_powertrain_TO_technical_spec_1`
        FOREIGN KEY (`powertrain_id`)
            REFERENCES `powertrain` (`id`);

ALTER TABLE `technical_spec`
    ADD CONSTRAINT `FK_drivetrain_TO_technical_spec_1`
        FOREIGN KEY (`drivetrain_id`)
            REFERENCES `drivetrain` (`id`);

ALTER TABLE `car_powertrain`
    ADD CONSTRAINT `FK_car_TO_car_powertrain_1`
        FOREIGN KEY (`car_id`)
            REFERENCES `car` (`id`);

ALTER TABLE `car_powertrain`
    ADD CONSTRAINT `FK_powertrain_TO_car_powertrain_1`
        FOREIGN KEY (`powertrain_id`)
            REFERENCES `powertrain` (`id`);

ALTER TABLE `car_bodytype`
    ADD CONSTRAINT `FK_car_TO_car_bodytype_1`
        FOREIGN KEY (`car_id`)
            REFERENCES `car` (`id`);

ALTER TABLE `car_bodytype`
    ADD CONSTRAINT `FK_bodytype_TO_car_bodytype_1`
        FOREIGN KEY (`bodytype_id`)
            REFERENCES `bodytype` (`id`);

ALTER TABLE `car_drivetrain`
    ADD CONSTRAINT `FK_car_TO_car_drivetrain_1`
        FOREIGN KEY (`car_id`)
            REFERENCES `car` (`id`);

ALTER TABLE `car_drivetrain`
    ADD CONSTRAINT `FK_drivetrain_TO_car_drivetrain_1`
        FOREIGN KEY (`drivetrain_id`)
            REFERENCES `drivetrain` (`id`);

ALTER TABLE `trims_internal_color`
    ADD CONSTRAINT `FK_trims_TO_trims_internal_color_1`
        FOREIGN KEY (`trim_id`)
            REFERENCES `trims` (`id`);

ALTER TABLE `trims_internal_color`
    ADD CONSTRAINT `FK_internal_color_TO_trims_internal_color_1`
        FOREIGN KEY (`internal_color_id`)
            REFERENCES `internal_color` (`id`);

ALTER TABLE `trims_package`
    ADD CONSTRAINT `FK_trims_TO_trims_package_1`
        FOREIGN KEY (`trim_id`)
            REFERENCES `trims` (`id`);

ALTER TABLE `trims_package`
    ADD CONSTRAINT `FK_package_TO_trims_package_1`
        FOREIGN KEY (`package_id`)
            REFERENCES `package` (`id`);

ALTER TABLE `trims_options`
    ADD CONSTRAINT `FK_trims_TO_trims_options_1`
        FOREIGN KEY (`trim_id`)
            REFERENCES `trims` (`id`);

ALTER TABLE `trims_options`
    ADD CONSTRAINT `FK_options_TO_trims_options_1`
        FOREIGN KEY (`option_id`)
            REFERENCES `options` (`id`);

ALTER TABLE `package_options`
    ADD CONSTRAINT `FK_package_TO_package_options_1`
        FOREIGN KEY (`package_id`)
            REFERENCES `package` (`id`);

ALTER TABLE `package_options`
    ADD CONSTRAINT `FK_options_TO_package_options_1`
        FOREIGN KEY (`option_id`)
            REFERENCES `options` (`id`);

ALTER TABLE `package_hashtag`
    ADD CONSTRAINT `FK_package_TO_package_hashtag_1`
        FOREIGN KEY (`package_id`)
            REFERENCES `package` (`id`);

ALTER TABLE `package_hashtag`
    ADD CONSTRAINT `FK_hashtag_TO_package_hashtag_1`
        FOREIGN KEY (`hashtag_id`)
            REFERENCES `hashtag` (`id`);

ALTER TABLE `options_hashtag`
    ADD CONSTRAINT `FK_options_TO_options_hashtag_1`
        FOREIGN KEY (`option_id`)
            REFERENCES `options` (`id`);

ALTER TABLE `options_hashtag`
    ADD CONSTRAINT `FK_hashtag_TO_options_hashtag_1`
        FOREIGN KEY (`hashtag_id`)
            REFERENCES `hashtag` (`id`);

ALTER TABLE `trims_external_color`
    ADD CONSTRAINT `FK_trims_TO_trims_external_color_1`
        FOREIGN KEY (`trim_id`)
            REFERENCES `trims` (`id`);

ALTER TABLE `trims_external_color`
    ADD CONSTRAINT `FK_external_color_TO_trims_external_color_1`
        FOREIGN KEY (`external_color_id`)
            REFERENCES `external_color` (`id`);

ALTER TABLE `options_quotation`
    ADD CONSTRAINT `FK_options_TO_options_quotation_1`
        FOREIGN KEY (`option_id`)
            REFERENCES `options` (`id`);

ALTER TABLE `options_quotation`
    ADD CONSTRAINT `FK_quotation_TO_options_quotation_1`
        FOREIGN KEY (`quotation_id`)
            REFERENCES `quotation` (`id`);

ALTER TABLE `package_quotation`
    ADD CONSTRAINT `FK_package_TO_package_quotation_1`
        FOREIGN KEY (`package_id`)
            REFERENCES `package` (`id`);

ALTER TABLE `package_quotation`
    ADD CONSTRAINT `FK_quotation_TO_package_quotation_1`
        FOREIGN KEY (`quotation_id`)
            REFERENCES `quotation` (`id`);

ALTER TABLE `package_category`
    ADD CONSTRAINT `FK_package_TO_package_category_1`
        FOREIGN KEY (`package_id`)
            REFERENCES `package` (`id`);

ALTER TABLE `package_category`
    ADD CONSTRAINT `FK_category_TO_package_category_1`
        FOREIGN KEY (`category_id`)
            REFERENCES `category` (`id`);

ALTER TABLE `options_category`
    ADD CONSTRAINT `FK_options_TO_options_category_1`
        FOREIGN KEY (`option_id`)
            REFERENCES `options` (`id`);

ALTER TABLE `options_category`
    ADD CONSTRAINT `FK_category_TO_options_category_1`
        FOREIGN KEY (`category_id`)
            REFERENCES `category` (`id`);

ALTER TABLE `powertrain_spec`
    ADD CONSTRAINT `FK_powertrain_TO_powertrain_spec_1`
        FOREIGN KEY (`powertrain_id`)
            REFERENCES `powertrain` (`id`);
