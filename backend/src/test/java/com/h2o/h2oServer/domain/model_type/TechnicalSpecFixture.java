package com.h2o.h2oServer.domain.model_type;

import com.h2o.h2oServer.domain.model_type.Entity.TechnicalSpecEntity;
import com.h2o.h2oServer.domain.model_type.dto.TechnicalSpecDto;

public class TechnicalSpecFixture {

    public static TechnicalSpecEntity generateTechnicalSpecEntity(Long powertrainId, Long drivetrainId) {
        return TechnicalSpecEntity.builder()
                .powertrainId(powertrainId)
                .drivetrainId(drivetrainId)
                .displacement(10)
                .fuelEfficiency(10.1f)
                .build();
    }

    public static TechnicalSpecEntity generateTechnicalSpecEntity() {
        return generateTechnicalSpecEntity(1L, 1L);
    }

    public static TechnicalSpecDto generateTechnicalSpecDto() {
        return TechnicalSpecDto.of(
                generateTechnicalSpecEntity()
        );
    }
}
