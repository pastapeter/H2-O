package com.h2o.h2oServer.domain.model_type;

import com.h2o.h2oServer.domain.model_type.Entity.CarPowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainOutputEntity;
import com.h2o.h2oServer.domain.model_type.Entity.PowertrainTorqueEntity;
import com.h2o.h2oServer.domain.model_type.dto.CarPowertrainDto;

import java.util.List;

public class PowertrainFixture {
    public static CarPowertrainDto generateCarPowertrainDto() {
        return CarPowertrainDto.of(generateCarPowertrainEntities().get(0),
                generatePowertrainOutputEntity(),
                generatePowertrainTorqueEntity());
    }
    public static PowertrainEntity generatePowertrainEntity(Long id) {
        return PowertrainEntity.builder()
                .id(id)
                .name("powertrain1")
                .description("description1")
                .image("img_url1")
                .build();
    }

    public static PowertrainEntity generatePowertrainEntity() {
        return generatePowertrainEntity(1L);
    }

    public static List<CarPowertrainEntity> generateCarPowertrainEntities(Long carId) {
        return List.of(CarPowertrainEntity.builder()
                        .carId(carId)
                        .name("powertrain1")
                        .description("description1")
                        .image("img_url1")
                        .powertrainId(1L)
                        .price(100000)
                        .choiceRatio(0.22f)
                        .build(),
                CarPowertrainEntity.builder()
                        .carId(carId)
                        .name("powertrain2")
                        .description("description2")
                        .image("img_url2")
                        .powertrainId(2L)
                        .price(300000)
                        .choiceRatio(0.21f)
                        .build());
    }

    public static List<CarPowertrainEntity> generateCarPowertrainEntities() {
        return generateCarPowertrainEntities(1L);
    }

    public static PowertrainOutputEntity generatePowertrainOutputEntity(Long powertrainId) {
        return PowertrainOutputEntity.builder()
                .powertrainId(powertrainId)
                .output(202.2f)
                .minRpm(1000)
                .maxRpm(1000)
                .build();
    }

    public static PowertrainOutputEntity generatePowertrainOutputEntity() {
        return generatePowertrainOutputEntity(1L);
    }

    public static PowertrainTorqueEntity generatePowertrainTorqueEntity(Long powertrainId) {
        return PowertrainTorqueEntity.builder()
                .powertrainId(powertrainId)
                .torque(100.1f)
                .minRpm(3000)
                .maxRpm(3000)
                .build();
    }

    public static PowertrainTorqueEntity generatePowertrainTorqueEntity() {
        return generatePowertrainTorqueEntity(1L);
    }
}
