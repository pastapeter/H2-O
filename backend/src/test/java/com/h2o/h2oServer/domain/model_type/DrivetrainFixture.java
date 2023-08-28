package com.h2o.h2oServer.domain.model_type;

import com.h2o.h2oServer.domain.model_type.Entity.CarDrivetrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.DrivetrainEntity;
import com.h2o.h2oServer.domain.model_type.dto.CarDrivetrainDto;

import java.util.List;

public class DrivetrainFixture {
    public static DrivetrainEntity generateDrivetrainEntity(Long drivetrainId) {
        return DrivetrainEntity.builder()
                .id(drivetrainId)
                .name("name1")
                .description("description1")
                .image("img_url1")
                .build();
    }

    public static DrivetrainEntity generateDrivetrainEntity() {
        return generateDrivetrainEntity(1L);
    }

    public static List<CarDrivetrainEntity> generateCarDrivetrainEntities(Long carId) {
        return List.of(
                CarDrivetrainEntity.builder()
                        .carId(carId)
                        .name("name1")
                        .description("description1")
                        .image("img_url1")
                        .drivetrainId(1L)
                        .price(10000)
                        .choiceRatio(0.22f)
                        .build(),
                CarDrivetrainEntity.builder()
                        .carId(carId)
                        .name("name2")
                        .description("description2")
                        .image("img_url2")
                        .drivetrainId(2L)
                        .price(20000)
                        .choiceRatio(0.23f)
                        .build());
    }

    public static List<CarDrivetrainEntity> generateCarDrivetrainEntities() {
        return generateCarDrivetrainEntities(1L);
    }

    public static CarDrivetrainDto generateCarDrivetrainDto() {
        return CarDrivetrainDto.of(generateCarDrivetrainEntities().get(0));
    }
}
