
CREATE TABLE `car` (
                       `car_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                       `name`	VARCHAR(255)	NOT NULL,
                       `price`	INT	NOT NULL,
                       `category`	VARCHAR(20)	NOT NULL
);

CREATE TABLE `trim` (
                        `trim_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                        `car_id`	BIGINT	NOT NULL,
                        `name`	VARCHAR(20)	NOT NULL,
                        `description`	VARCHAR(100)	NOT NULL,
                        `price`	BIGINT	NOT NULL,
                        `images`	TEXT	NOT NULL
);

CREATE TABLE `technical_spec` (
                                  `powertrain_id`	BIGINT	NOT NULL,
                                  `drivetrain_id`	BIGINT	NOT NULL,
                                  `fuel_efficiency`	INT	NOT NULL,
                                  `displacement`	INT	NOT NULL
);

CREATE TABLE `powertrain` (
                              `powertrain_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                              `name`	VARCHAR(255)	NOT NULL,
                              `price`	INT	NOT NULL,
                              `description`	TEXT	NOT NULL,
                              `image`	TEXT	NOT NULL,
                              `max_output`	INT	NOT NULL,
                              `max_torque`	INT	NOT NULL
);

CREATE TABLE `bodytype` (
                            `powertrain_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                            `name`	VARCHAR(255)	NOT NULL,
                            `price`	INT	NOT NULL,
                            `description`	TEXT	NOT NULL,
                            `image`	TEXT	NOT NULL
);

CREATE TABLE `drivetrain` (
                              `drivetrain_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                              `name`	VARCHAR(255)	NOT NULL,
                              `price`	INT	NOT NULL,
                              `description`	TEXT	NOT NULL,
                              `image`	TEXT	NOT NULL
);

CREATE TABLE `trim_statistics` (
                                   `trim_statistics_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                                   `trim_id`	BIGINT	NOT NULL,
                                   `name`	VARCHAR(20)	NOT NULL,
                                   `count`	INT	NOT NULL
);

CREATE TABLE `external_color` (
                                  `external_color_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                                  `name`	VARCHAR(255)	NOT NULL,
                                  `price`	INT	NOT NULL,
                                  `color_code`	VARCHAR(10)	NOT NULL,
                                  `images`	TEXT	NOT NULL
);

CREATE TABLE `internal_color` (
                                  `internal_color_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                                  `name`	VARCHAR(255)	NOT NULL,
                                  `price`	INT	NOT NULL,
                                  `fabric_image`	TEXT	NOT NULL,
                                  `image`	TEXT	NOT NULL
);

CREATE TABLE `option` (
                          `option_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                          `name`	VARCHAR(255)	NOT NULL,
                          `price`	INT	NOT NULL,
                          `category`	VARCHAR(20)	NOT NULL,
                          `image`	TEXT	NOT NULL,
                          `description`	TEXT	NOT NULL,
                          `use_count`	INT	NOT NULL
);

CREATE TABLE `hashtag` (
                           `hashtag_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                           `name`	VARCHAR(255)	NOT NULL,
                           `price`	INT	NOT NULL,
                           `fabric_image`	TEXT	NOT NULL,
                           `image`	TEXT	NOT NULL
);

CREATE TABLE `package` (
                           `package_id`	BIGINT	NOT NULL PRIMARY KEY auto_increment,
                           `name`	VARCHAR(255)	NOT NULL,
                           `price`	INT	NOT NULL,
                           `category`	VARCHAR(20)	NOT NULL,
                           `image`	TEXT	NOT NULL
);

CREATE TABLE `car_powertrain` (
                                  `powertrain_id`	BIGINT	NOT NULL,
                                  `car_id`	BIGINT	NOT NULL
);

CREATE TABLE `car_bodytype` (
                                `powertrain_id`	BIGINT(20)	NOT NULL,
                                `car_id`	BIGINT(20)	NOT NULL
);

CREATE TABLE `car_drivetrain` (
                                  `car_id`	BIGINT	NOT NULL,
                                  `powertrain_id`	BIGINT	NOT NULL
);

CREATE TABLE `trim_internalcolor` (
                                      `internal_color_id`	BIGINT	NOT NULL,
                                      `trim_id`	BIGINT	NOT NULL
);

CREATE TABLE `trim_package` (
                                `package_id`	BIGINT	NOT NULL,
                                `trim_id`	BIGINT	NOT NULL
);

CREATE TABLE `trim_option` (
                               `trim_id`	BIGINT	NOT NULL,
                               `option_id`	BIGINT	NOT NULL
);

CREATE TABLE `package_option` (
                                  `option_id`	BIGINT	NOT NULL,
                                  `package_id`	BIGINT	NOT NULL
);

CREATE TABLE `package_tag` (
                               `hashtag_id`	BIGINT	NOT NULL,
                               `package_id`	BIGINT	NOT NULL
);

CREATE TABLE `option_tag` (
                              `option_id`	BIGINT	NOT NULL,
                              `hashtag_id`	BIGINT	NOT NULL
);

CREATE TABLE `trim_externalcolor` (
                                      `external_color_id`	BIGINT	NOT NULL,
                                      `trim_id`	BIGINT	NOT NULL
);

ALTER TABLE `technical_spec` ADD CONSTRAINT `PK_TECHNICAL_SPEC` PRIMARY KEY (
                                                                             `powertrain_id`,
                                                                             `drivetrain_id`
    );

ALTER TABLE `car_powertrain` ADD CONSTRAINT `PK_CAR_POWERTRAIN` PRIMARY KEY (
                                                                             `powertrain_id`,
                                                                             `car_id`
    );

ALTER TABLE `car_bodytype` ADD CONSTRAINT `PK_CAR_BODYTYPE` PRIMARY KEY (
                                                                         `powertrain_id`,
                                                                         `car_id`
    );

ALTER TABLE `car_drivetrain` ADD CONSTRAINT `PK_CAR_DRIVETRAIN` PRIMARY KEY (
                                                                             `car_id`,
                                                                             `powertrain_id`
    );

ALTER TABLE `trim_internalcolor` ADD CONSTRAINT `PK_TRIM_INTERNALCOLOR` PRIMARY KEY (
                                                                                     `internal_color_id`,
                                                                                     `trim_id`
    );

ALTER TABLE `trim_package` ADD CONSTRAINT `PK_TRIM_PACKAGE` PRIMARY KEY (
                                                                         `package_id`,
                                                                         `trim_id`
    );

ALTER TABLE `trim_option` ADD CONSTRAINT `PK_TRIM_OPTION` PRIMARY KEY (
                                                                       `trim_id`,
                                                                       `option_id`
    );

ALTER TABLE `package_option` ADD CONSTRAINT `PK_PACKAGE_OPTION` PRIMARY KEY (
                                                                             `option_id`,
                                                                             `package_id`
    );

ALTER TABLE `package_tag` ADD CONSTRAINT `PK_PACKAGE_TAG` PRIMARY KEY (
                                                                       `hashtag_id`,
                                                                       `package_id`
    );

ALTER TABLE `option_tag` ADD CONSTRAINT `PK_OPTION_TAG` PRIMARY KEY (
                                                                     `option_id`,
                                                                     `hashtag_id`
    );

ALTER TABLE `trim_externalcolor` ADD CONSTRAINT `PK_TRIM_EXTERNALCOLOR` PRIMARY KEY (
                                                                                     `external_color_id`,
                                                                                     `trim_id`
    );

ALTER TABLE `trim` ADD CONSTRAINT `FK_car_TO_trim_1` FOREIGN KEY (
                                                                  `car_id`
    )
    REFERENCES `car` (
                      `car_id`
        );

ALTER TABLE `technical_spec` ADD CONSTRAINT `FK_powertrain_TO_technical_spec_1` FOREIGN KEY (
                                                                                             `powertrain_id`
    )
    REFERENCES `powertrain` (
                             `powertrain_id`
        );

ALTER TABLE `technical_spec` ADD CONSTRAINT `FK_drivetrain_TO_technical_spec_1` FOREIGN KEY (
                                                                                             `drivetrain_id`
    )
    REFERENCES `drivetrain` (
                             `drivetrain_id`
        );

ALTER TABLE `trim_statistics` ADD CONSTRAINT `FK_trim_TO_trim_statistics_1` FOREIGN KEY (
                                                                                         `trim_id`
    )
    REFERENCES `trim` (
                       `trim_id`
        );

ALTER TABLE `car_powertrain` ADD CONSTRAINT `FK_powertrain_TO_car_powertrain_1` FOREIGN KEY (
                                                                                             `powertrain_id`
    )
    REFERENCES `powertrain` (
                             `powertrain_id`
        );

ALTER TABLE `car_powertrain` ADD CONSTRAINT `FK_car_TO_car_powertrain_1` FOREIGN KEY (
                                                                                      `car_id`
    )
    REFERENCES `car` (
                      `car_id`
        );

ALTER TABLE `car_bodytype` ADD CONSTRAINT `FK_bodytype_TO_car_bodytype_1` FOREIGN KEY (
                                                                                       `powertrain_id`
    )
    REFERENCES `bodytype` (
                           `powertrain_id`
        );

ALTER TABLE `car_bodytype` ADD CONSTRAINT `FK_car_TO_car_bodytype_1` FOREIGN KEY (
                                                                                  `car_id`
    )
    REFERENCES `car` (
                      `car_id`
        );

ALTER TABLE `car_drivetrain` ADD CONSTRAINT `FK_car_TO_car_drivetrain_1` FOREIGN KEY (
                                                                                      `car_id`
    )
    REFERENCES `car` (
                      `car_id`
        );

ALTER TABLE `car_drivetrain` ADD CONSTRAINT `FK_drivetrain_TO_car_drivetrain_1` FOREIGN KEY (
                                                                                             `powertrain_id`
    )
    REFERENCES `drivetrain` (
                             `drivetrain_id`
        );

ALTER TABLE `trim_internalcolor` ADD CONSTRAINT `FK_internal_color_TO_trim_internalcolor_1` FOREIGN KEY (
                                                                                                         `internal_color_id`
    )
    REFERENCES `internal_color` (
                                 `internal_color_id`
        );

ALTER TABLE `trim_internalcolor` ADD CONSTRAINT `FK_trim_TO_trim_internalcolor_1` FOREIGN KEY (
                                                                                               `trim_id`
    )
    REFERENCES `trim` (
                       `trim_id`
        );

ALTER TABLE `trim_package` ADD CONSTRAINT `FK_package_TO_trim_package_1` FOREIGN KEY (
                                                                                      `package_id`
    )
    REFERENCES `package` (
                          `package_id`
        );

ALTER TABLE `trim_package` ADD CONSTRAINT `FK_trim_TO_trim_package_1` FOREIGN KEY (
                                                                                   `trim_id`
    )
    REFERENCES `trim` (
                       `trim_id`
        );

ALTER TABLE `trim_option` ADD CONSTRAINT `FK_trim_TO_trim_option_1` FOREIGN KEY (
                                                                                 `trim_id`
    )
    REFERENCES `trim` (
                       `trim_id`
        );

ALTER TABLE `trim_option` ADD CONSTRAINT `FK_option_TO_trim_option_1` FOREIGN KEY (
                                                                                   `option_id`
    )
    REFERENCES `option` (
                         `option_id`
        );

ALTER TABLE `package_option` ADD CONSTRAINT `FK_option_TO_package_option_1` FOREIGN KEY (
                                                                                         `option_id`
    )
    REFERENCES `option` (
                         `option_id`
        );

ALTER TABLE `package_option` ADD CONSTRAINT `FK_package_TO_package_option_1` FOREIGN KEY (
                                                                                          `package_id`
    )
    REFERENCES `package` (
                          `package_id`
        );

ALTER TABLE `package_tag` ADD CONSTRAINT `FK_hashtag_TO_package_tag_1` FOREIGN KEY (
                                                                                    `hashtag_id`
    )
    REFERENCES `hashtag` (
                          `hashtag_id`
        );

ALTER TABLE `package_tag` ADD CONSTRAINT `FK_package_TO_package_tag_1` FOREIGN KEY (
                                                                                    `package_id`
    )
    REFERENCES `package` (
                          `package_id`
        );

ALTER TABLE `option_tag` ADD CONSTRAINT `FK_option_TO_option_tag_1` FOREIGN KEY (
                                                                                 `option_id`
    )
    REFERENCES `option` (
                         `option_id`
        );

ALTER TABLE `option_tag` ADD CONSTRAINT `FK_hashtag_TO_option_tag_1` FOREIGN KEY (
                                                                                  `hashtag_id`
    )
    REFERENCES `hashtag` (
                          `hashtag_id`
        );

ALTER TABLE `trim_externalcolor` ADD CONSTRAINT `FK_external_color_TO_trim_externalcolor_1` FOREIGN KEY (
                                                                                                         `external_color_id`
    )
    REFERENCES `external_color` (
                                 `external_color_id`
        );

ALTER TABLE `trim_externalcolor` ADD CONSTRAINT `FK_trim_TO_trim_externalcolor_1` FOREIGN KEY (
                                                                                               `trim_id`
    )
    REFERENCES `trim` (
                       `trim_id`
        );
