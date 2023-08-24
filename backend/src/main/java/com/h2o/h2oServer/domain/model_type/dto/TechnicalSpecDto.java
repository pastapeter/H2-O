package com.h2o.h2oServer.domain.model_type.dto;

import com.h2o.h2oServer.domain.model_type.Entity.TechnicalSpecEntity;
import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@ApiModel(value = "차량 성능 정보 조회 응답")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TechnicalSpecDto {
    private Integer displacement;
    private Float fuelEfficiency;

    public static TechnicalSpecDto of(TechnicalSpecEntity technicalSpecEntity) {
        return new TechnicalSpecDto(
                technicalSpecEntity.getDisplacement(),
                technicalSpecEntity.getFuelEfficiency()
        );
    }
}
